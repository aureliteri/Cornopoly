open Player
open Card
open Space

let roll_dice x =
  let d1 = Random.int x + 1 in
  let d2 = Random.int x + 1 in
  let bool = if d1==d2 then true else false in
  (d1 + d2, bool)

let pick_card x =
  let ind = Random.int x in
  List.find (fun x -> card_id x = ind) cardlist

(* [print_locations] returns the location of EACH player. This is to be called
   at the beginning of each turn. Eg:
   ""Meghana is currently at Cafe Jennie.
   Aaron is currently at Cow Land.
   Amy is currently at CKB.
   Michelle is currently at Dickson.
   It is now __'s turn.""
   call [print_locations] with acc as an []

   I AM NOT SURE HOW TO DO NEW LINE. IF SOMEONE DOES, ADD IT AFTER "." PLEASE
*)
let rec print_locations playerlist acc = 
  match playerlist with
  | [] -> acc
  | h :: t -> 
    let player_location = space_name (get_space (current_location_id h)) in
    let complete_string = name h ^ " is currently at " ^ player_location ^ ".\n" in
    print_locations t (acc ^complete_string)


(* I AM NOT SURE HOW TO DO NEW LINE. IF SOMEONE DOES, ADD IT AFTER "." PLEASE *)
let rec print_balances playerlist acc = 
  match playerlist with
  | [] -> acc
  | h :: t -> 
    let player_balance = string_of_int (balance h) in
    let complete_string = name h ^ " currently has a balance of $" ^ player_balance ^ ".\n" in
    print_balances t (acc ^ complete_string )

(**Checks what tyoe of space the player landed on, and updates player information and board
   Outputs: (updated player, updated board)
*)
let check_space (space: space) (player: Player.player) (board: Space.space list) : (Player.player *  Space.space list)=
  match space with
  | Property property -> 
    begin
      if String.equal (property_owner property) ""
      then 
        begin
          print_endline ("The price of " ^ (property_name property) ^ " is $" ^ (string_of_int (buy_price property)));
          print_endline "Do you want to purchase it? (Type: Yes or No)"; 
          print_string "> "; 
          let check_buy s =
            if s = "Yes" || s = "yes" || s = "Y" || s = "y"
            then begin 
              let p = add_property player property in (** adds property to player's property list *)
              let p' = update_balance p (-1  * buy_price property) in  (** updates player's balance *)
              let updated_space = Property(change_owner property (name p')) in
              let new_space_list = List.map (fun x -> if space_id x = space_id updated_space then updated_space else x) board in
              (p',new_space_list)
            end
            else (player,board)
          in
          check_buy (read_line())
        end
      else begin
        let p = update_balance (find_player (property_owner property) playerlist) (-1  * rent_price property) in
        (p,board)
      end
    end

  | CardSpace chance -> 
    let chosen_card = pick_card (List.length cardlist) in
    let rec card_action (act_lst : Card.action list) (player : Player.player) : player = 
      match act_lst with
      | h :: t -> begin
          match h with
          | Change x -> card_action t (update_balance player x)
          | Move x -> card_action t (move player x)
        end
      | [] -> player
    in
    print_endline ("The card you have chosen is: " ^ (card_description chosen_card));
    (card_action (card_act chosen_card) player,board)
  (* Functionality to be carried out: 
      card_act chosen_card*)

  | Jail jail -> 
    print_endline "Bad luck! You have landed in jail, skip your next turn";
    let p' = go_jail player in
    (p',board)
  (* Functionality to be carried out: 
     Skip the players turn (maybe by skipping them in the queue?*)


  | Penalty penalty -> print_endline (penalty_description penalty);
    (update_balance player (-1 * penalty_price penalty),board)

  | Go go -> print_endline "Pass Go! You have collected $200";
    (player, board)


  | JustVisiting justvisiting -> 
    print_endline "Oop. Close call, you are just visiting";
    (* Functionality to be carried out: 
        None? "end turn??" *) 
    (player,board)

(** Returns an updated list of all players after one round/iteration *)
let rec iterate playerlist (lst: (Player.player) list) =
  match playerlist with
  | [] -> lst
  | h :: t -> 
    if (in_jail h) = false then begin
      print_endline ("It's "^ name h ^ " turn!");
      let roll = roll_dice 6 in
      let new_player = move h (fst roll) in 
      let new_space_id = current_location_id new_player in 
      let new_space = get_space new_space_id in 
      let updated_tuple = check_space new_space new_player spacelist in
      if (snd roll == false) then
        iterate t ((fst updated_tuple) :: lst)
      else begin
        print_endline ("You rolled a double!");
        iterate ((fst updated_tuple)::t) (lst)
      end
    end
    else begin
      print_endline ("You are in jail! Skip a turn.");
      iterate t (h::lst)
    end

(* Prints all of the property names, space_id, color, & rent_price 
    of a property list *)
let print_properties (properties : property list) = 
  let name_lst = List.map (fun prop -> property_name prop) properties in 
  List.iter (fun name -> print_endline ("Name: " ^ name)) name_lst;

  let id_lst = List.map (fun prop -> property_id prop) properties in 
  List.iter (fun id -> print_endline ("ID: " ^ string_of_int id)) id_lst;

  let color_lst = List.map (fun prop -> property_color prop) properties in 
  List. iter (fun color -> print_endline ("Color: " ^ color)) color_lst;

  let rent_lst = List.map (fun prop -> rent_price prop) properties in 
  List.iter (fun rent -> print_endline ("Rent Price: $" ^ string_of_int rent)) rent_lst

(*[print_players prints all of the information about the players of a player list] *)
let rec print_players players = 
  match players with
  | [] -> print_endline ""
  | h :: t -> let p_id = string_of_int (id h) in 
    let p_name = name h in 
    let p_current_loc = space_name (get_space (current_location_id h)) in 
    let p_balance = string_of_int (balance h )in 
    let p_properties = property_list h in 
    print_endline ("\n"^ p_name ^ "'s ID is " ^p_id ^ " and their current location is " ^ p_current_loc ^ ". 
    Their balance is $" ^p_balance^ " and their properties are");
    print_properties p_properties;
    print_players t


let print_initial_board (spaces : space list) (player : player list) : unit = 
  (**print all of the space names and ids *)
  let rec print_spaces lst = 
    match lst with
    | [] -> print_endline ""
    | h :: t -> let id = space_id h in 
      print_endline ((string_of_int id ) ^ ". " ^ space_name h); 
      print_spaces t
  in print_spaces spaces

let update_board playerlist  =
  print_endline ("\n"^print_locations playerlist "");
  print_endline (print_balances playerlist "") 


