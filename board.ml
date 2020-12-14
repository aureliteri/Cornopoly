open Player
open Card
open Space
open Command

let roll_dice x =
  let d1 = Random.int x + 1 in
  let d2 = Random.int x + 1 in 
  (d1 + d2, d1 = d2)

let pick_card x =
  let ind = Random.int x in
  cardlist.(ind)

let if_full_set (player : Player.player) 
    (property_just_bought : Space.property) : unit =
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
  then begin print_endline ("Winner is " ^ name player ^"! 
  They have a full set of " ^ color ^ "! \nCongratulations!");
    exit 0; end
  else print_string ""



(** [yes_buy_property p plist board prop] returns a tuple of a Player.player list and a Space.space list
    that contains the updated information of the lsit of all players [plist] and the game board [board] after
    player [player] purchases the [prop] property *)
let yes_buy_property player plst board prop =
  let p = add_property player prop in (** adds property to player's property list *)
  let p' = update_balance p (-1 * buy_price prop) in  (** updates player's balance *)
  let updated_pL = replace_player plst p' in  
  if (balance p' <= 0) then 
    let () = print_endline "You do not have enough in your balance! Sorry!"
    in (plst, board)
  else begin
    let updated_space = Property((change_owner prop (name p'))) in
    let new_space_list = 
      List.map (fun x -> if space_id x = space_id updated_space 
                 then updated_space else x) board in
    let old_owner = property_owner prop in 
    if not (String.equal old_owner "") then
      let rem_prop_own = remove_property 
          (find_player old_owner updated_pL) prop in 
      let owner_bal_upd = update_balance rem_prop_own (buy_price prop) in
      let new_playerlist = replace_player updated_pL owner_bal_upd in
      let () = if_full_set p prop in (new_playerlist, new_space_list)
    else let () = if_full_set p prop in (updated_pL, new_space_list)
  end


let buy_property command player playerList board property  = 
  match command with 
  | Yes -> yes_buy_property player playerList board property
  | No -> (playerList, board)

(** [try_buy s] takes in a string [s] and prompts the user for user input. According to the user input
    [try_buy s] returns a tuple of updated Player.player list and Space.space list. *)
let rec try_buy s = 
  print_endline "Do you want to purchase it? (Type: Yes or No)"; 
  print_string "> "; 
  buy_property (parse_buy s)

let rec card_action (act_lst : Card.action list) 
    (player : Player.player) : player = 
  match act_lst with
  | h :: t -> begin
      match h with
      | Change x -> card_action t (update_balance player x)
      | Move x -> card_action t (move_to_space player x) 
      | Get_out x -> change_jail_card player x
    end
  | [] -> player