open Player
open Card
open Space
open Command

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
  (* Random.self_init (); *)
  let d1 = Random.int x + 1 in
  let d2 = Random.int x + 1 in 
  (d1 + d2, d1 = d2)

let pick_card =
  let ind = Random.int (Array.length cardlist) in
  cardlist.(ind)

(**new-space with the updated property is not being passed *)
(**Helpers: 1. buy_property function `2. pay_rent function`
   3.  *)

let buy_property command player board property= 
  match command with 
  | Yes -> let p = add_property player property in (** adds property to player's property list *)
    let p' = update_balance p (-1 * buy_price property) in  (** updates player's balance *)
    let updated_space = Property((change_owner property (name p'))) in
    let new_space_list = 
      List.map (fun x -> if space_id x = space_id updated_space 
                 then updated_space else x) board in
    (p', new_space_list)
  | No -> (player, board)

let rec try_buy s = 
  print_endline "Do you want to purchase it? (Type: Yes or No)"; 
  print_string "> "; 
  buy_property (parse_buy s)


let rec card_action (act_lst : Card.action list) (player : Player.player) : player = 
  match act_lst with
  | h :: t -> begin
      match h with
      | Change x -> card_action t (update_balance player x)
      | Move x -> card_action t (move player x)
      | Get_out x -> change_jail_card player x
    end
  | [] -> player



(* TODOOOO : Account for winning scenarios- 
   purchasing entire 1 same-color territories other players are bankrupt - Make lists of same color properties (Hashmap)
   Implement Colorset in Board --> hashmap where key is a string (color name) and the value is a list of Property.spaces
   Set appropriate rent prices and buy prices (as well as penalty prices) -> Make sure plyers can pay rent
*)


