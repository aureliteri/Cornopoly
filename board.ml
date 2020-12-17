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
  in 
  if List.length (extract_color_property color 
                    (snd(List.split(property_list player))) [] ) 
     = full_size 
  then begin print_endline ("Winner is " ^ name player ^"! 
  They have a full set of " ^ color ^ "! \nCongratulations!");
    exit 0; end
  else print_string ""

let rec try_command_level s =      
  try 
    parse_level_input s
  with 
  | Malformed -> print_endline "Invalid command! Try Again"; 
    print_string "> "; 
    try_command_level (read_line())
  | Empty -> print_endline "Please enter a command!"; 
    print_string "> "; 
    try_command_level (read_line()) 


let rec print_locations1 playerlist board acc = 
  match playerlist with
  | [] -> acc
  | h :: t -> 
    let player_loc = space_name (get_space(current_location_id h) board)in
    let complete_string = name h ^ " is currently at " ^ player_loc^".\n" in
    print_locations1 t board (acc ^ complete_string)

(** [yes_buy_property p plist board prop] returns a tuple of a Player.player list and a Space.space list
    that contains the updated information of the lsit of all players [plist] and the game board [board] after
    player [player] purchases the [prop] property *)
let yes_buy_property player plst board prop =
  print_endline "Which level do you want to buy? (Enter: 0, 1, or 2)";
  let level = try_command_level (read_line()) in
  let buy_price_level = Array.get (buy_price prop) level in 
  let player = add_property player level prop in (** adds property to player's property list *) (**FIX *)
  let p' = update_balance player (-1 * buy_price_level) in  (** updates player's balance *)

  let updated_pL = replace_player plst p' in  
  if (balance p' <= 0) then 
    let () = print_endline "You do not have enough in your balance! Sorry!"
    in (plst, board)
  else begin
    let updated_p = (change_owner prop (name p')) in
    let updated_space = Property(change_level updated_p level) in
    let new_space_list = 
      List.map (fun x -> if space_id x = space_id updated_space 
                 then updated_space else x) board in
    let old_owner = property_owner prop in 
    if not (String.equal old_owner "") then
      let rem_prop_own = remove_property 
          (find_player old_owner updated_pL) prop in 
      let owner_bal_upd = update_balance rem_prop_own (buy_price_level) in
      let new_playerlist = replace_player updated_pL owner_bal_upd in
      let () = if_full_set player prop in (new_playerlist, new_space_list)
    else let () = if_full_set player prop in (updated_pL, new_space_list)
  end

(* let upgrade_property command player playerList board property  = 
   match command with 
   | Yes -> yes_buy_property player playerList board property
   | No -> (playerList, board)

   let rec try_update s = 
   print_endline "Do you want to update your property? (Type: Yes or No)"; 
   print_string "> "; 
   upgrade_property (parse_buy s) *)



let buy_property command player playerList board property = 
  match command with 
  | Yes -> yes_buy_property player playerList board property 
  | No -> let updated_pL = replace_player playerList player in  
    (updated_pL, board) 

let rec card_action (act_lst : Card.action list) 
    (player : Player.player) : player = 
  match act_lst with
  | h :: t -> 
    begin
      match h with
      | Change x -> card_action t (update_balance player x)
      | Move x -> card_action t (move_to_space player x) 
      | Get_out x -> change_jail_card player x
    end
  | [] -> player

