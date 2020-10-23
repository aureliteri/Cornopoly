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
  Array.get cardlist ind


(* [print_locations] returns the location of EACH player. This is to be called
   at the beginning of each turn. Eg:
   ""Meghana is currently at Cafe Jennie.
   Aaron is currently at Cow Land.
   Amy is currently at CKB.
   Michelle is currently at Dickson.
   It is now __'s turn.""
   call [print_locations] with acc as an []
*)
let rec print_locations playerlist acc = 
  match playerlist with
  | [] -> acc
  | h :: t -> print_locations t 
                acc ^ space_name (List.nth spacelist (current_location_id h))

let rec iterate playerlist (lst: Player.player list) =
  match playerlist with
  | [] -> lst
  | h :: t -> begin
      iterate playerlist ((move h roll_dice) :: lst)
    end

let update_board playerlist =
  iterate playerlist []

let check_space (space: space) player =
  match space with
  | Property property -> "" 
  (* begin
      if String.equal property.owner ""
      then
      else begin
        update_balance player (-1.0 *.property.rent);
        update_balance (find_player property.owner playerlist) property.rent
      end
     end 
  *)

  (* THIS CURRENTLY ONLY PRINTS, NO FUNCTIONALITY 
     pick_card 10 for now, because cardlist length  = 10 *)
  | CardSpace chance -> let chosen_card = (pick_card 10) in
    "The card you have chosen is: " ^ (card_description chosen_card)
  (* Functionality to be carried out: 
      card_act chosen_card*)

  | Jail jail -> "Bad luck! You have landed in jail, skip your next turn"
  (* Functionality to be carried out: 
     Skip the players turn (maybe by skipping them in the queue?*)

  | Penalty penalty -> penalty_description penalty
  (* Functionality to be carried out: 
     player.update_balance NEGATIVE(penalty_price penalty) *)


  | Go go -> "Pass Go! You have collected $200"
  (* Functionality to be carried out: 
     player.update_balance 200 *)


  | JustVisiting justvisiting -> "Oop. Close call, you are just visiting"
