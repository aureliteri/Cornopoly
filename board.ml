open Player
open Card
open Space

let roll_dice =
  let d1 = Random.int 6 + 1 in
  let d2 = Random.int 6 + 1 in
  d1 + d2

let pick_card  =
  let ind = Random.int (List.length cardlist) in
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
    let player_location = space_name (List.nth spacelist (current_location_id h)) in
    let complete_string = name h ^ " is currently at " ^ player_location ^ "." in
    print_locations t (acc ^ complete_string)


(* I AM NOT SURE HOW TO DO NEW LINE. IF SOMEONE DOES, ADD IT AFTER "." PLEASE *)
let rec print_balances playerlist acc = 
  match playerlist with
  | [] -> acc
  | h :: t -> 
    let player_balance = string_of_int (balance h) in
    let complete_string = name h ^ " currently has a balance of " ^ player_balance ^ "." in
    print_balances t (acc ^ complete_string)


(**Check space takes the updated l *)
let check_space (space: space) (player: Player.player) : Player.player =
  match space with
  | Property property -> 
    begin
      if String.equal (property_owner property) ""
      then 
        begin
          print_endline ("The price of " ^ (property_name property) ^ "is " ^ (string_of_int (rent_price property)));
          print_endline "Do you want to purchase it? (Type: Yes or No)"; 
          print_string "> "; 
          let check_buy s =
            if s = "Yes" || s = "yes" 
            then begin 
              let p = add_property player property in 
              update_balance p (-1  * buy_price property)
            end
            else player
          in
          check_buy (read_line())
        end
      else 
        update_balance (find_player (property_owner property) playerlist) (-1  * rent_price property)
    end

  | CardSpace chance -> 
    let chosen_card = pick_card in
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
    card_action (card_act chosen_card) player
  (* Functionality to be carried out: 
      card_act chosen_card*)

  | Jail jail -> 
    print_endline "Bad luck! You have landed in jail, skip your next turn";
    player
  (* Functionality to be carried out: 
     Skip the players turn (maybe by skipping them in the queue?*)


  | Penalty penalty -> print_endline (penalty_description penalty);
    update_balance player (-1 * penalty_price penalty)

  | Go go -> print_endline "Pass Go! You have collected $200";
    update_balance player 200


  | JustVisiting justvisiting -> 
    print_endline "Oop. Close call, you are just visiting";
    (* Functionality to be carried out: 
        None? "end turn??" *)
    player

(**After every player moves, check_space is called on that updated player BEFORE
   being added to lst. *)
let rec iterate playerlist (lst: Player.player list) =
  match playerlist with
  | [] -> lst
  | h :: t -> begin
      let new_player = move h roll_dice in 
      let new_player_id = id new_player in 
      let new_space = get_space new_player_id in 
      iterate t (check_space new_space new_player :: lst)
    end

(** Prints all of the property names, space_id, color, & rent_price 
    of a property list *)
let print_properties_name (properties : property list) = 
  let name_lst = List.map (fun prop -> property_name prop) properties in 
  List.iter (fun name -> print_endline ("Name: " ^ name)) name_lst
(* let id_lst = List.map (fun prop -> (space_id Property(prop)) properties  *)


let print_initial_board (spaces : space list) (player : player list) : unit = 
  (**print all of the space names and ids *)
  let rec print_spaces lst = 
    match lst with
    | [] -> print_endline ""
    | h :: t -> let id = space_id h in 
      print_endline ((string_of_int id ) ^ ". " ^ space_name h); 
      print_spaces t
  in print_spaces spaces

let rec print_players = function
  | [] -> print_endline ""
  | h :: t -> let p_id = string_of_int (id h) in 
    let p_name = name h in 
    let p_current_loc = string_of_int (current_location_id h) in 
    let p_balance = string_of_int (balance h )in 
    let p_properties = property_list h in 
    print_endline (p_name ^ "'s ID is" ^p_id ^ "")




let update_board playerlist =
  let new_lst = iterate playerlist [] in 
  print_endline (print_locations new_lst "");
  print_endline (print_balances new_lst "")



