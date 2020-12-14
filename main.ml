(** [main ()] prompts for the game to play, then starts it. *)
(* TODO:
   1. Divide functions into smaller helper functions.
   Must be shorter than 20 lines.
   - iterate this shit is 200 lines (main.ml)

   2. Write all spcifications for helper functions. 
   Complete mli functions specifications. 
   Clean up unnecessary notes/comments.
   3. OUnit tests
   - test the commands: jail and buying properties
   - test exceptions ???
   -  checking if property list empty if player is bankrupt
   - test winning scenarios in ounit (like if color list win and stuffs)
   - test all of the module function, we should have more than 50 ounit tests 

     4. Make JSON maps and players -> parse json and return specific type list
     5. Make rental prices and fees reasonable so that game is actually enjoyable.
     6. Create a working make docs (HTML thing)
     7. Fix liines going over 80 characters
     ???. ??? Make bisect

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
    let player_loc = space_name (get_space (current_location_id h) spacelist)in
    let complete_string = name h ^ " is currently at " ^ player_loc ^ ".\n" in
    print_locations t (acc ^ complete_string)

let rec print_balances playerlist acc = 
  match playerlist with
  | [] -> acc
  | h :: t -> 
    let player_balance = string_of_int (balance h) in
    let complete_string = name h ^ " currently has a balance of $" 
                          ^ player_balance ^ ".\n" in
    print_balances t (acc ^ complete_string )

let rec print_properties (properties : property list) : unit = 
  match properties with
  | [] -> print_endline ""
  | h :: t -> 
    print_endline ("Name: " ^ property_name h);
    print_endline ("ID: " ^ string_of_int (property_id h));
    print_endline ("Color: " ^ property_color h);
    print_endline ("Rent Price: $" ^ string_of_int (rent_price h)^ "\n");
    print_properties t 

(** get space is using Space.spacelist *)
let rec print_players players = 
  match players with
  | [] -> print_endline ""
  | h :: t -> let p_id = string_of_int (id h) in 
    let p_name = name h in 
    let p_cur_loc = space_name (get_space (current_location_id h) spacelist) in 
    let p_balance = string_of_int (balance h )in 
    let p_properties = property_list h in print_endline 
      ("\n" ^ p_name ^ "'s ID is " ^ p_id ^ " and their current location is " 
       ^ p_cur_loc ^ ".\nTheir balance is $" ^ p_balance ^ 
       ". Their properties are:");
    if List.length p_properties = 0 then 
      print_endline "None" else 
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

let rec delete_player_record board player acc = 
  match board with 
  | [] -> acc
  | h :: t ->  
    match h with
    | Property x -> if property_owner x = name player 
      then delete_player_record t player (Property (change_owner x "") :: acc) 
      else delete_player_record t player (h :: acc)
    | _ ->  delete_player_record t player (h :: acc)

let update_board playerlist  =
  print_endline ("\n" ^ print_locations playerlist "");
  print_endline (print_balances playerlist "")

let check_space_chance chance player playerList board = 
  let chosen_card = pick_card (Array.length cardlist) in
  print_endline ("The card you have chosen is: \n"
                 ^ (card_description chosen_card));
  let card_action_player = card_action (card_act chosen_card) player in 
  (replace_player playerList card_action_player , board)

let check_space_jail jail player playerList board  = 
  let () = print_endline "Bad luck! You have landed in jail." in
  let p' = change_jail player true in (replace_player playerList p', board)

let check_space_penalty penalty player playerList board  = 
  print_endline "You have landed on a Penalty space.";
  print_endline (penalty_description penalty);
  let penalty_update = update_balance player (-1 * penalty_price penalty) in 
  (replace_player playerList penalty_update, board)

let check_space_go go player playerList board = 

  print_endline "Pass Go! You have collected $50."; (playerList, board)

let check_space_justvisiting jv player playerList board  = 
  print_endline "Oop. Close call to Jail, luckily you are just visiting.";
  (playerList, board)

let rec try_command_property s p pl board property =      
  try 
    buy_property (parse_buy s) p pl board property
  with 
  | Malformed -> print_endline "Invalid command! Try Again"; 
    print_string "> "; 
    try_command_property (read_line()) p pl board property
  | Empty -> print_endline "Please enter a command!"; 
    print_string "> "; 
    try_command_property (read_line()) p pl board property

let land_someone_else_property player playerList board property = 
  print_endline ("You have landed on " ^(property_name property) ^ 
                 ". It is owned by " ^ property_owner property ^ 
                 ". \nYou must pay rent of $" ^ 
                 (string_of_int  (rent_price property)  ^ "."));
  let pl = update_balance player (-1 * rent_price property) in
  let updated_owner = update_balance (find_player (property_owner property) 
                                        playerList) (rent_price property) in
  let lst = replace_player playerList pl in
  let lst2 = replace_player lst updated_owner in
  print_endline ("The price of " ^ (property_name property) ^ " is $" ^
                 (string_of_int (buy_price property)));
  print_endline "Do you want to purchase it? (Type: Yes or No)"; 
  print_string "> ";
  try_command_property (read_line()) pl lst2 board property

let check_space_property space player playerList board property = 
  if (String.equal (property_owner property) "") then 
    begin
      print_endline ("The price of " ^ (property_name property) ^ " is $" ^ 
                     (string_of_int (buy_price property)) ^ 
                     "\nDo you want to purchase it? (Type: Yes or No)");
      print_string "> ";
      try_command_property (read_line()) player playerList board property 
    end
  else begin 
    if String.equal (property_owner property) (name player)
    then begin
      print_endline ("You own this property. You get to stay for free!");
      (playerList, board)
    end
    else
      land_someone_else_property player playerList board property
  end  

(**[check_space].... pass in 
   [space] which the current space that the player is on, pass in 
   [player] which is the current player, 
   [player_lst] which is ALLLLL of the players in the CURRENT turn,
   pass in [board] which is the CURRENT board. *)
let check_space (space: space) player (playerList: Player.player list) 
    (board: Space.space list) : (Player.player list * Space.space list) =
  match space with
  | Property property ->  
    check_space_property space player playerList board property
  | CardSpace chance -> check_space_chance chance player playerList board 
  | Jail jail -> check_space_jail jail player playerList board 
  | Penalty penalty -> check_space_penalty penalty player playerList board 
  | Go go -> check_space_go go player playerList board 
  | JustVisiting jv -> check_space_justvisiting jv player playerList board 

(**[iterate playerlist lst] is the list of players that undergo 1 turn of Monopoly *)


(**TEST CASE if you roll 3 times WHILE IN JAIL then you get out  *)



let counter = ref 0 
let counter_jail = ref 0
let rec iterate playerlist (sp: space list) acc =
  match playerlist with
  | [] -> acc | h :: t -> print_endline (" \nIt's "^ name h ^ " turn!");
    if (in_jail h) = false then begin let roll = roll_dice 6 in 
      let new_player = move h (fst roll) in 
      print_endline (name h ^ " has rolled a "^ string_of_int (fst roll) ^"!");
      let new_space = get_space (current_location_id new_player) sp in 
      let upd_tup = check_space new_space new_player
          ((fst acc) @ playerlist) sp in
      let current_player = find_player (name h) (fst upd_tup) in 
      let new_acc = (List.filter (fun x -> id x < id h) (fst upd_tup), sp) in 
      let new_t = List.filter (fun x -> id x > id h) (fst upd_tup) in 
      if (balance (current_player) <= 0) then 
        player_bankrupt current_player playerlist sp new_acc
      else let upd_sp = snd upd_tup in  
        if (snd roll) then (** if a double is rolled *)
          double_rolled new_player new_t upd_sp new_acc current_player
        else begin counter := 0;
          iterate new_t (upd_sp) (current_player :: fst new_acc, upd_sp) 
        end end else player_in_jail h acc sp t

and double_rolled new_player new_t updated_sp new_acc current_player = 
  (** if a double is rolled *)
  print_endline ("You rolled a double!");
  incr counter; (**add 1 to the count of doubles rolled *)
  if !counter = 3 then (**if the # of doubles is 3, then send the player to jail. *)
    let () = print_endline ("You rolled 3 doubles in total! Go to Jail.") in
    let jail_player = (change_jail (set_location new_player 10) true )in (**set current location of player to jail. Then change the player's jail property to true  *)
    iterate new_t (updated_sp) (jail_player :: (fst new_acc), updated_sp) (**iterate to next player in line. Add jailed player to accumulator *)
  else iterate (current_player :: new_t) (updated_sp) (fst new_acc, updated_sp)

and player_in_jail h acc sp t = 
  incr counter_jail;
  if !counter_jail = 1 then 
    print_endline (name h ^ " is in jail! You will be stuck here for three turns. \nYou can pay a fine of $100, use your get out of jail free card, \nor try to roll a double to leave jail early.");
  let rec try_command s =         
    print_string (">");
    try 
      jail_rules (parse_jail s) h acc sp t
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


and jail_rules command player acc sp playerlist = 
  match command with
  | Pay -> jail_pay_command player acc sp playerlist
  (**parse s into PAY commnd. Pass the command into a function that moves the player out of jail *)
  | Card -> jail_card_command player acc sp playerlist
  | Roll -> jail_roll_command player acc sp playerlist

and jail_pay_command player acc sp playerlist = 
  if (balance player < 100) then 
    let () = print_endline "You do not have enough in your balance to pay! Type in another command." in 
    jail_rules (parse_jail (read_line())) player acc sp playerlist
  else 
    let pay_jail_player = update_balance player (-100) in
    counter_jail := 0;
    let not_in_jail = change_jail pay_jail_player false in 
    print_endline ("Congrats! You have paid $100 to get out of jail.");
    iterate playerlist sp (not_in_jail :: fst acc , snd acc)

and jail_card_command player acc sp playerlist = 
  if (jail_card player) then 
    let used_card = change_jail_card player false in 
    let updated_player = change_jail used_card false in
    print_endline ("Congrats! You used your Get Out of Jail Card. You are out of jail.");
    counter_jail := 0;
    iterate playerlist sp (updated_player :: fst acc , snd acc)
  else
    let () = print_endline ("You do not have a Get Out of Jail Card. Enter another command.") in
    print_string (">");
    jail_rules (parse_jail (read_line())) player acc sp playerlist

and jail_roll_command player acc sp playerlist = 
  if snd (roll_dice 6)
  then (counter_jail := 0;
        let not_in_jail = change_jail player false  in
        let () = print_endline ("Congrats! You have rolled a double - you are out of jail!") in
        iterate playerlist sp (not_in_jail :: fst acc , snd acc))
  else begin 
    if !counter_jail = 3 then 
      (counter_jail := 0;
       let not_in_jail = change_jail player false  in
       let () = print_endline ("You have stayed in jail for three turns. You are now out of jail") in
       iterate playerlist sp (not_in_jail :: fst acc , snd acc))
    else
      let () =  print_endline ("You didn't roll a double. You are still in jail.") in 
      iterate playerlist sp (player :: fst acc , snd acc)
  end

and player_bankrupt player playerlist sp acc = 
  let () = print_endline ("Your balance is now $" ^(string_of_int (balance (player)))) in
  let () = print_endline "You have gone bankrupt. You're out of the game!" in 
  let new_board = List.rev(delete_player_record sp (player) []) in
  iterate (remove_player player playerlist) new_board (fst acc, new_board)

and player_not_bankrupt current_player new_player playerlist sp acc roll = 
  if (snd roll) then (** if a double is rolled *)
    begin
      print_endline ("You rolled a double!");
      incr counter; (**add 1 to the count of doubles rolled *)
      if !counter = 3 then (**if the # of doubles is 3, then send the player to jail. *)
        let () = print_endline ("You rolled 3 doubles! Go to Jail.") in
        let jail_player = (change_jail (set_location new_player 10) true )in (**set current location of player to jail. Then change the player's jail property to true  *)
        iterate playerlist (sp) (jail_player :: (fst acc), sp) (**iterate to next player in line. Add jailed player to accumulator *)
      else iterate (current_player :: playerlist) (sp) (fst acc, sp) 
      (**if # of doubles rolled per person has not reached three, replace head player with jailed player make  *)
    end 
  else begin
    counter := 0;
    iterate playerlist (sp) (current_player :: fst acc, sp) 
  end 


let end_game lst : unit = 
  match lst with 
  | [] -> print_endline ("No winner sorry."); exit 0;
  | h :: t -> if List.length t = 0 then 
      (print_endline (name h ^ " is the winner! Everyone else has gone bankrupt."); exit 0; ) else ()

let rec play s player_lst space_lst : unit = 
  match s with
  | "quit" -> exit 0;
  | _ -> ( 
      print_players player_lst;
      let new_lst = iterate player_lst space_lst ([], []) in
      let pl_lst = List.rev (fst new_lst) in
      end_game pl_lst;
      update_board pl_lst; 
      print_endline "Type 'quit' to quit. Type anything else to continue.";
      let s = read_line() in
      play s pl_lst (snd new_lst);)


let main () = Random.self_init ();
  print_endline("Welcome to Cornopoly!! \nThe goal of this game is to win a full color set, or bankrupt the rest of your players. \nYou can do this by purchasing properties on the board, and staying out of jail. \nPlayer 1, please insert your name:");
  let p1_name = read_line () in
  let p1 = update_name (List.nth Player.playerlist 0) p1_name in
  print_endline("Player 2, please insert your name:");
  let p2_name = read_line () in
  let p2 = update_name (List.nth Player.playerlist 1) p2_name in
  print_endline("Player 3, please insert your name:");
  let p3_name = read_line () in
  let p3 = update_name (List.nth Player.playerlist 2) p3_name in
  print_endline("Player 4, please insert your name:");
  let p4_name = read_line () in 
  let p4 = update_name (List.nth Player.playerlist 3) p4_name in
  print_endline("The players are: "^p1_name^", "^p2_name^", "^p3_name^", " ^
                p4_name^".\nHere is the layout of the initial board: ");
  print_initial_board Space.spacelist [p1;p2;p3;p4];
  print_endline "Type quit to quit. Type anything else to play.";
  let s = read_line () in play s [p1;p2;p3;p4] Space.spacelist;
  match read_line () with | exception End_of_file -> ()
                          | file_name -> failwith "hi"

(* Execute the game engine. *)
let () = main ()