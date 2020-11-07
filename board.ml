open Player
open Card
open Space

(**TODO Friday, 11/6: 
   3. then winner scenarios ahahaha detail later cool
      2a. Players aim to own all properties in ONE color set, or bankrupt all other players.
      Bankruptcy: This is when a player has $0, or cannot no longer afford to pay any dues (eg. rent, tax, fines)

   4. unit tests (EXTENSIVE)


   TODO: add Command module to parse terminal inputs
    2. separate out code into more individual functions
    3. add printing in main
*)

(**TODO: Implement/change this method to account for double rolls (if you roll doubles three time )
   try to implement random seeds? idk how tho haha
*)
let roll_dice x =
  let d1 = Random.int x + 1 in
  let d2 = Random.int x + 1 in 
  (d1 + d2, d1 = d2)

let pick_card =
  let ind = Random.int (Array.length cardlist) in
  cardlist.(ind)

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

(**new-space with the updated property is not being passed *)
let check_space (space: space) (player: Player.player) (board: Space.space list) : (Player.player *  Space.space list)=
  match space with
  | Property property -> 
    begin
      if (String.equal (property_owner property) "") then 
        begin
          print_endline ("The price of " ^ (property_name property) ^ " is $" ^ (string_of_int (buy_price property)));
          print_endline "Do you want to purchase it? (Type: Yes or No)"; 
          print_string "> "; 
          let check_buy s =
            if s = "Yes" || s = "yes" || s = "Y" || s = "y"
            then begin 
              let p = add_property player property in (** adds property to player's property list *)
              let p' = update_balance p (-1 * buy_price property) in  (** updates player's balance *)
              let updated_space = Property((change_owner property (name p'))) in
              let new_space_list = 
                List.map (fun x -> if space_id x = space_id updated_space 
                           then updated_space else x) board in
              (p', new_space_list)
            end
            else (player, board)
          in check_buy (read_line())
        end
      else begin
        print_endline ((property_name property)^" is owned by " ^ property_owner property ^ ". You must pay rent of $"^ (string_of_int (rent_price property)));
        let p = update_balance player (-1 * rent_price property) in
        (p, board)
      end
    end

  | CardSpace chance -> 
    let chosen_card = pick_card in 
    let rec card_action (act_lst : Card.action list) (player : Player.player) : player = 
      match act_lst with
      | h :: t -> begin
          match h with
          | Change x -> card_action t (update_balance player x)
          | Move x -> card_action t (move player x)
          | Get_out x -> change_jail_card player x
        end
      | [] -> player
    in
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
let counter = ref 0 
let rec iterate playerlist (lst: (Player.player) list) (sp: space list) =
  match playerlist with
  | [] -> lst
  | h :: t -> 
    if (in_jail h) = false then begin
      print_endline ("It's "^ name h ^ " turn!");
      let roll = roll_dice 6 in 
      print_endline (string_of_int (fst roll));
      let new_player = move h (fst roll) in 
      let new_space_id = current_location_id new_player in 
      let new_space = get_space new_space_id sp in 
      let updated_tuple = check_space new_space new_player sp in

      if (snd roll) then (** if a double is rolled *)
        begin
          print_endline ("You rolled a double!");
          incr counter; (**add 1 to the count of doubles rolled *)
          if !counter = 3 then (**if the # of doubles is 3, then send the player to jail. *)
            let jail_player = (change_jail (set_location new_player 10) true )in (**set current location of player to jail. Then change the player's jail property to true  *)
            iterate t (jail_player :: lst)(snd updated_tuple) (**iterate to next player in line. Add jailed player to accumulator *)
          else iterate ((fst updated_tuple) :: t) (lst) (snd updated_tuple)
          (**if # of doubles rolled per person has not reached three, replace head player with jailed player make  *)
        end 
      else begin
        counter := 0;
        iterate t ((fst updated_tuple) :: lst) (snd updated_tuple)
      end
    end
    else begin
      print_endline ("You are in jail! Skip a turn.");
      iterate t ((change_jail h false)::lst) sp
    end



let rec iterate1 playerlist (sp: space list) (acc: Player.player list * Space.space list )  =
  match playerlist with
  | [] -> acc
  | h :: t -> print_endline ("It's "^ name h ^ " turn!");
    if (in_jail h) = false then begin
      let roll = roll_dice 6 in 
      let new_player = move h (fst roll) in 
      let new_space_id = current_location_id new_player in 
      let new_space = get_space new_space_id sp in (**get_space *)
      let updated_tuple = check_space new_space new_player sp in
      let updated_sp = snd updated_tuple in 

      if (snd roll) then (** if a double is rolled *)
        begin
          print_endline ("You rolled a double!");
          incr counter; (**add 1 to the count of doubles rolled *)
          if !counter = 3 then (**if the # of doubles is 3, then send the player to jail. *)
            let jail_player = (change_jail (set_location new_player 10) true )in (**set current location of player to jail. Then change the player's jail property to true  *)
            iterate1 t (updated_sp) (jail_player :: (fst acc), updated_sp) (**iterate to next player in line. Add jailed player to accumulator *)
          else iterate1 ((fst updated_tuple) :: t) (updated_sp)  (fst acc, updated_sp) 
          (**if # of doubles rolled per person has not reached three, replace head player with jailed player make  *)
        end 
      else begin
        counter := 0;
        iterate1 t (updated_sp) ((fst updated_tuple) :: fst acc , updated_sp) 
      end
    end

    (* LEAVE JAIL SCENARIOS!! like pay the fine, roll a double, or if you have a get out of jail free card
    *)
    else begin (** THE PLAYER IS IN JAIL RIGHT NOW *)
      print_endline (name h ^ " is in jail! You will be stuck here for three turns. You can pay a fine of $100, use your get out of jail free card, or try to roll a double to leave jail early.");
      let rec jail_rules s = 
        print_endline ("Enter PAY, CARD, or ROLL");
        if (s = "PAY") then 
          let pay_jail_player = update_balance h (-100) in 
          let not_in_jail = change_jail pay_jail_player false in 
          print_endline ("Congrats! You are out of jail.");
          iterate1 t sp (not_in_jail :: fst acc , snd acc)

        else if (s = "CARD" && jail_card h) then 
          let used_card = change_jail_card h false in 
          print_endline ("Congrats! You used your Get Out of Jail Card. You are out of jail.");
          iterate1 t sp (used_card :: fst acc , snd acc)
        else if (s = "CARD" && not (jail_card h)) then 
          let () = print_endline ("You do not have a Get Out of Jail Card. Enter another command.") in
          jail_rules (read_line())
        else if (s = "ROLL") then (
          if (snd (roll_dice 6))
          then 
            let not_in_jail = change_jail h false  in
            print_endline ("Congrats! You rolled a double and are out of jail");

            iterate1 t sp (not_in_jail :: fst acc , snd acc)
          else 
            let () =  print_endline ("You didn't roll a double. You are still in jail") in 
            iterate1 t sp (h :: fst acc , snd acc)
        )
        else 
          let () = print_endline ("Invalid command.") in 
          jail_rules (read_line())
      in 
      print_endline ("Enter PAY, CARD, or ROLL");
      jail_rules (read_line())
    end


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

(* TODOOOO : Account for winning scenarios- 
   purchasing entire 1 same-color territories other players are bankrupt - Make lists of same color properties (Hashmap)
   Implement Colorset in Board --> hashmap where key is a string (color name) and the value is a list of Property.spaces
   Set appropriate rent prices and buy prices (as well as penalty prices) -> Make sure plyers can pay rent
*)
let update_board playerlist  =
  print_endline ("\n"^print_locations playerlist "");
  print_endline (print_balances playerlist "") 