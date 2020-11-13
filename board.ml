open Player
open Card
open Space
open Command
(* IF ALL OTHER PLAYERSS BANKRUPT FUNCTION *)

(**TODO Friday, 11/6: 
   3. then winner scenarios ahahaha detail later cool
      2a. Players aim to own all properties in ONE color set, or bankrupt all other players.
      Bankruptcy: This is when a player has $0, or cannot no longer afford to pay any dues (eg. rent, tax, fines)

   4. unit tests (EXTENSIVE)


   TODO: add Command module to parse terminal inputs
    2. separate out code into more individual functions
    3. add printing in main
*)

(**TODO: Implement/change th  is method to account for double rolls (if you roll doubles three time )
   try to implement random seeds? idk how tho haha
*)
let roll_dice x =
  let d1 = Random.int x + 1 in
  let d2 = Random.int x + 1 in 
  (d1 + d2, d1 = d2)

let pick_card x =
  let ind = Random.int x in
  cardlist.(ind)

(* ONLY CALL THIS FUNCTION WHEN A PROPERTY HAS BEEN BOUGHT.
   USE THAT PROPERTY TO CHECK THE COLOR OF THAT PROPERTY (other wise we have to 
   loop through every single color. This way, it just matches the color of
   the property that was bought) *)
let if_full_set (player : Player.player) (property_just_bought : Space.property) : unit =
  let color = property_color property_just_bought in
  let full_size = if color = "blue" then 2 else 3 in
  let rec extract_color_property color_just_bought property_list acc = 
    match property_list with
    | h :: t -> if (property_color h) = color_just_bought 
      then extract_color_property color_just_bought t (h :: acc)
      else extract_color_property color_just_bought t acc
    | [] -> acc
  in if List.length (extract_color_property color (property_list player) [] ) 
        = full_size 
  then begin print_endline ("Winner is " ^ name player ^"! They have a full set of " ^ color ^ "! \nCongratulations!");
    exit 0; end
  else print_string ""


(**new-space with the updated property is not being passed *)
(**Helpers: 1. buy_property function `2. pay_rent function`
   3.  *)

let buy_property command player playerList board property: (Player.player list * Space.space list) = 
  match command with 
  | Yes ->  
    begin
      let p = add_property player property in (** adds property to player's property list *)
      let p' = update_balance p (-1 * buy_price property) in  (** updates player's balance *)
      let updated_pL = replace_player playerList p' in  
      if (balance p' <= 0) then 
        let () = print_endline "You do not have enough in your balance! Sorry!" in
        (playerList, board)
      else begin
        let updated_space = Property((change_owner property (name p'))) in
        let new_space_list = 
          List.map (fun x -> if space_id x = space_id updated_space 
                     then updated_space else x) board 
        in
        (**get old owner name. then go through property list and remove this property. get old owner back
           replace the updated old owner with non updated old owner in [updated_pl] -> playerlist where all of the owners balances
           and properties are updated*)
        let old_owner = property_owner property in 
        if not (String.equal old_owner "") then
          let removed_prop_owner = remove_property (find_player old_owner updated_pL) property in 
          let owner_balance_update = update_balance removed_prop_owner (buy_price property) in
          let new_playerlist = replace_player updated_pL owner_balance_update in
          let () = if_full_set p property in
          (new_playerlist, new_space_list)

        else
          let () = if_full_set p property in
          (updated_pL, new_space_list)
      end
    end 
  | No -> (playerList, board)

let rec try_buy s = 
  print_endline "Do you want to purchase it? (Type: Yes or No)"; 
  print_string "> "; 
  buy_property (parse_buy s)

let rec card_action (act_lst : Card.action list) (player : Player.player) : player = 
  match act_lst with
  | h :: t -> begin
      match h with
      | Change x -> card_action t (update_balance player x)
      | Move x -> card_action t (move_to_space player x) 
      | Get_out x -> change_jail_card player x
    end
  | [] -> player


(* TODOOOO : Account for winning scenarios- 
   purchasing entire 1 same-color territories other players are 
   bankrupt - Make lists of same color properties (Hashmap)
   Implement Colorset in Board --> hashmap where 
   key is a string (color name) and the value is a list of Property.spaces
   Set appropriate rent prices and buy prices 
   (as well as penalty prices) -> Make sure plyers can pay rent
*)