open Player
open Card
open Space

let roll_dice =
  let d1 = Random.int 6 + 1 in
  let d2 = Random.int 6 + 1 in
  d1 + d2

(* Hi, I am confused regarding size? because isnt this size constant*)
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
            then add_property player property; update_balance player (-1) * buy_price property
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
      iterate playerlist (check_space new_space new_player :: lst)
    end

let update_board playerlist =
  let new_lst = iterate playerlist [] in 
  print_endline (print_locations new_lst "");
  print_endline (print_balances new_lst "")



