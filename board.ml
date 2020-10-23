open Player
open Card
open Space

let roll_dice =
  let d1 = Random.int 6 +1 in
  let d2 = Random.int 6 +1 in
  d1 + d2

(* Hi, I am confused regarding size? because isnt this size constant*)
let pick_card size =
  let ind = Random.int size in
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
    (* let player_location =  (List.find (fun x -> x.space_id = (current_location_id h)) spacelist) in *)
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


let rec iterate playerlist (lst: Player.player list) =
  match playerlist with
  | [] -> lst
  | h :: t -> iterate playerlist (move h roll_dice :: lst)

let update_board playerlist =
  let new_lst = iterate playerlist [] in 
  print_endline (print_locations new_lst "");
  print_endline (print_balances new_lst "")

let check_space (space: space) (player: Player.player) : unit =
  match space with
  | Property property -> print_endline""; 
    (* begin
        if property.owner = ""
        then "The price of " ^ property.name ^ "is " ^ float_of_string property.rent_price ^ ". Do you want to purchase it?"
        else begin
          update_balance player (-1.0 *.property.rent);
          update_balance (find_player property.owner playerlist) property.rent
        end
       end 
    *)

    (* THIS CURRENTLY ONLY PRINTS, NO FUNCTIONALITY 
       pick_card 10 for now, because cardlist length  = 10 *)
  | CardSpace chance -> let chosen_card = (pick_card 10) in
    print_endline ("The card you have chosen is: " ^ (card_description chosen_card));
    (* Functionality to be carried out: 
        card_act chosen_card*)

  | Jail jail -> 
    print_endline "Bad luck! You have landed in jail, skip your next turn";
    (* Functionality to be carried out: 
       Skip the players turn (maybe by skipping them in the queue?*)

  | Penalty penalty -> print_endline (penalty_description penalty);
    (* Functionality to be carried out: 
       player.update_balance NEGATIVE(penalty_price penalty) *)

  | Go go -> print_endline "Pass Go! You have collected $200";
    (* Functionality to be carried out: 
       player.update_balance 200 *)


  | JustVisiting justvisiting -> 
    print_endline "Oop. Close call, you are just visiting";
    (* Functionality to be carried out: 
        None? "end turn??" *)

