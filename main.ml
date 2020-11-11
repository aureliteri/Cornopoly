(** [main ()] prompts for the game to play, then starts it. *)
(* TODO: if player does not have enough money they should not be able to buy

   add function if a player is broke, then they should be removed from teh playerlist
*)
open Board  
open Player
open Space
open Card
open Command


let rec print_locations playerlist acc = 
  match playerlist with
  | [] -> acc
  | h :: t -> 
    let player_location = space_name (get_space (current_location_id h) spacelist) in
    let complete_string = name h ^ " is currently at " ^ player_location ^ ".\n" in
    print_locations t (acc ^ complete_string)

let rec print_balances playerlist acc = 
  match playerlist with
  | [] -> acc
  | h :: t -> 
    let player_balance = string_of_int (balance h) in
    let complete_string = name h ^ " currently has a balance of $" ^ player_balance ^ ".\n" in
    print_balances t (acc ^ complete_string )

let rec print_properties (properties : property list) : unit = 
  match properties with
  | [] -> print_endline ""
  | h :: t -> 
    print_endline ("Name: " ^ property_name h);
    print_endline ("ID: " ^ string_of_int (property_id h));
    print_endline ("Color: " ^ property_color h);
    print_endline ("Rent Price: $" ^ string_of_int (rent_price h)^"\n");
    print_properties t 

(** get space is using Space.spacelist *)
let rec print_players players = 
  match players with
  | [] -> print_endline ""
  | h :: t -> let p_id = string_of_int (id h) in 
    let p_name = name h in 
    let p_current_loc = space_name (get_space (current_location_id h) spacelist) in 
    let p_balance = string_of_int (balance h )in 
    let p_properties = property_list h in 
    print_endline ("\n"^ p_name ^ "'s ID is " ^p_id ^ " and their current location is " ^ p_current_loc ^ ". Their balance is $" ^p_balance^ "." ^ " Their properties are:");
    print_properties p_properties;
    print_players t

let print_initial_board (spaces : space list) (player : player list) : unit = 
  let rec print_spaces lst = 
    match lst with
    | [] -> print_endline ""
    | h :: t -> let id = space_id h in 
      print_endline ((string_of_int id ) ^ ". " ^ space_name h); 
      print_spaces t
  in print_spaces spaces

let rec delete_player_record board player acc=
  match board with 
  | [] -> acc
  | h :: t -> 
    match h with
    |Property x -> if property_owner x = name player 
      then delete_player_record t player (Property(change_owner x "")::acc) 
      else delete_player_record t player acc
    | _ ->  delete_player_record t player acc

let update_board playerlist  =
  print_endline ("\n"^print_locations playerlist "");
  print_endline (print_balances playerlist "") 

let check_space (space: space) (player: Player.player) (board: Space.space list) : (Player.player *  Space.space list)=
  match space with
  | Property property ->  
    begin
      if (String.equal (property_owner property) "") then 
        begin
          let rec try_command s =         
            try 
              buy_property (parse_buy s) player board property
            with 
            | Malformed -> print_endline "Invalid command! Try Again"; 
              print_string "> "; 
              try_command (read_line())
            | Empty -> print_endline "Please enter a command!"; 
              print_string "> "; 
              try_command (read_line())
          in 
          print_endline ("The price of " ^ (property_name property) ^ " is $" ^ (string_of_int (buy_price property)));
          print_endline "Do you want to purchase it? (Type: Yes or No)"; 
          print_string "> "; 
          try_command (read_line())
        end 
      else begin (**pay_rent stuff *)
        print_endline ((property_name property)^" is owned by " ^ property_owner property ^ ". You must pay rent of $"^ (string_of_int (rent_price property)^ "."));
        let p = update_balance player (-1 * rent_price property) in
        (p, board)
      end
    end

  | CardSpace chance -> 
    let chosen_card = pick_card in
    print_endline ("The card you have chosen is: " ^ (card_description chosen_card));
    (card_action (card_act chosen_card) player, board)

  (** TODO: Change this implementation to account for players landing in jail and how to leave jail so ??
      Pay the $50 fine before rolling the dice
      Use a ‘Get Out Of Jail Free Card’ before rolling the dice
      Optional Functionality: Roll doubles in an attempt to leave jail.
      After the 3rd failed turns to attempt to roll doubles, you must pay the $50 fine and leave jail
  *)
  | Jail jail -> 
    print_endline "Bad luck! You have landed in jail, skip your next turn";
    let p' = change_jail player true in (p', board)

  | Penalty penalty -> print_endline (penalty_description penalty);
    (update_balance player (-1 * penalty_price penalty),board)

  | Go go -> print_endline "Pass Go! You have collected $200";
    (player, board)

  | JustVisiting justvisiting -> 
    print_endline "Oop. Close call to Jail, luckily you are just visiting";
    (player, board)

(** CHECK THE COUNTER STUFF AND JAIL STUFF WE ADDDED 
    THERE IS ALSO A FATAL ERROR: EXCEPTION NOT_FOUND-> could be because a player 
    landed on a spot that already has an owner*)
(**[iterate playerlist lst] is the list of players that undergo 1 turn of Monopoly *)

(* once game begins, player's go through their turns one by one. Have a function that just iterates through playerlist
   For each player, pass (in jail) as an argument for helper*)
let counter = ref 0 

let rec iterate playerlist (sp: space list) (acc: Player.player list * Space.space list )  =
  match playerlist with
  | [] -> acc
  | h :: t -> print_endline ("It's "^ name h ^ " turn!");
    if (in_jail h) = false then begin
      let roll = roll_dice 6 in 
      let new_player = move h (fst roll) in 
      let new_space_id = current_location_id new_player in 
      let new_space = get_space new_space_id sp in 
      let updated_tuple = check_space new_space new_player sp in

      if (balance (fst updated_tuple) < 0) then 
        let () = print_endline (string_of_int (balance (fst updated_tuple))) in
        let () = print_endline "You're bankrupt! You're out of the game." in 
        let new_board = List.rev(delete_player_record sp (fst updated_tuple) []) in
        iterate (remove_player (fst updated_tuple) playerlist) new_board (fst acc , snd acc)
      else
        let updated_sp = snd updated_tuple in 

        if (snd roll) then (** if a double is rolled *)
          begin
            print_endline ("You rolled a double!");
            incr counter; (**add 1 to the count of doubles rolled *)
            if !counter = 3 then (**if the # of doubles is 3, then send the player to jail. *)
              let jail_player = (change_jail (set_location new_player 10) true )in (**set current location of player to jail. Then change the player's jail property to true  *)
              iterate t (updated_sp) (jail_player :: (fst acc), updated_sp) (**iterate to next player in line. Add jailed player to accumulator *)
            else iterate ((fst updated_tuple) :: t) (updated_sp)  (fst acc, updated_sp) 
            (**if # of doubles rolled per person has not reached three, replace head player with jailed player make  *)
          end 
        else begin
          counter := 0;
          iterate t (updated_sp) ((fst updated_tuple) :: fst acc , updated_sp) 
        end
    end

    (* LEAVE JAIL SCENARIOS!! like pay the fine, roll a double, or if you have a get out of jail free card
    *)
    else begin (** THE PLAYER IS IN JAIL RIGHT NOW *)
      print_endline (name h ^ " is in jail! You will be stuck here for three turns. You can pay a fine of $100, use your get out of jail free card, or try to roll a double to leave jail early.");
      let rec jail_rules command = 

        match command with
        | Pay ->
          (**parse s into PAY commnd. Pass the command into a function that moves the player out of jail *)

          let pay_jail_player = update_balance h (-100) in 
          if (balance pay_jail_player < 100) then 
            let () = print_endline "You do not have enough in your balance! Sorry!" in 
            iterate t sp ( fst acc , snd acc)
          else begin
            let not_in_jail = change_jail pay_jail_player false in 
            print_endline ("Congrats! You are out of jail.");
            iterate t sp (not_in_jail :: fst acc , snd acc)
          end

        | Card -> if (jail_card h) then 
            let used_card = change_jail_card h false in 
            print_endline ("Congrats! You used your Get Out of Jail Card. You are out of jail.");
            iterate t sp (used_card :: fst acc , snd acc)
          else
            let () = print_endline ("You do not have a Get Out of Jail Card. Enter another command.") in
            print_string (">");
            jail_rules (parse_jail (read_line()))

        | Roll -> (
            if (snd (roll_dice 6))
            then 
              let not_in_jail = change_jail h false  in
              print_endline ("Congrats! You rolled a double and are out of jail");

              iterate t sp (not_in_jail :: fst acc , snd acc)
            else 
              let () =  print_endline ("You didn't roll a double. You are still in jail.") in 
              iterate t sp (h :: fst acc , snd acc)
          ) in
      let rec try_command s =         
        print_endline ("Enter PAY, CARD, or ROLL");
        print_string (">");
        try 
          jail_rules (parse_jail s)
        with 
        | Malformed -> print_endline "Invalid command! Try Again"; 
          print_string "> "; 
          try_command (read_line())
        | Empty -> print_endline "Please enter a command!"; 
          print_string "> "; 
          try_command (read_line())
      in 
      print_endline ("Enter PAY, CARD, or ROLL");
      print_string (">");
      try_command (read_line())
    end


let main () = 
  print_endline("Welcome to Cornopoly");
  print_endline("There are four players: Meghana, Michelle, Aaron, Amy. \
                 Here is the layout of the initial board: ");

  print_initial_board Space.spacelist Player.playerlist;
  let rec play s player_lst space_lst : unit = 
    match s with
    | "quit" -> exit 0;
    | _ -> begin 
        print_players player_lst;
        let new_lst = iterate player_lst space_lst ([], []) in
        let pl_lst = List.rev (fst new_lst) in
        update_board pl_lst;
        print_endline "Type quit to quit. Type anything else to continue.";
        let s = read_line() in
        play s pl_lst (snd new_lst);
      end
  in
  print_endline "Type quit to quit. Type anything else to play.";
  let s = read_line() in
  play s Player.playerlist Space.spacelist;


  (*1. Print the inital board  - print eveery space: the id's, desciption, board price
     2. Player 1.name goes first*)


  match read_line () with
  | exception End_of_file -> ()
  | file_name -> failwith "hi"

(* Execute the game engine. *)
let () = main ()