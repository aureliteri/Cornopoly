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
                    (fst(List.split(property_list player))) [] ) 
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

let buy_property_helper player plst board prop level buy_price = 
  let player1 = add_property player level prop in (** adds property to player's property list *) (**FIX *)
  let p' = update_balance player1 (-1 * buy_price) in  (** updates player's balance *)
  (* print_endline ("Level:" ^ (string_of_int level) ^ "  Balance: " ^ (string_of_int (balance p')) ); *)
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
    if not (String.equal old_owner "") && not (String.equal old_owner(name player)) then
      let rem_prop_own = remove_property 
          (find_player old_owner updated_pL) prop in 
      let owner_bal_upd = update_balance rem_prop_own (buy_price) in
      let new_playerlist = replace_player updated_pL owner_bal_upd in 
      let () = if_full_set player prop in (new_playerlist, new_space_list)
    else let () = if_full_set player prop in (updated_pL, new_space_list)
  end


(** [yes_buy_property p plist board prop] returns a tuple of a Player.player list and a Space.space list
    that contains the updated information of the lsit of all players [plist] and the game board [board] after
    player [player] purchases the [prop] property *)
let yes_buy_property player plst board prop =
  print_endline "Which level do you want to buy? (Enter: 0, 1, or 2)";
  print_string "> ";
  let level = try_command_level (read_line()) in
  let buy_price_level = Array.get (buy_price prop) level in 
  buy_property_helper player plst board prop level buy_price_level

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

let buy_off_someone command player playerList board property level buy_price = 
  match command with 
  | Yes -> buy_property_helper player playerList board property level buy_price
  | No -> let updated_pL = replace_player playerList player in  
    (updated_pL, board) 

let rec compare_lvl old_lvl new_lvl =

  if new_lvl > old_lvl && new_lvl <= 2 then new_lvl else 
    let () = print_endline ("Invalid level! \n Which level do you want to buy? (You can only buy a level greater than the current level you own. Must be greater than"
                            ^ string_of_int old_lvl); 
      print_string "> "; in
    compare_lvl old_lvl (try_command_level (read_line()) ) 

let yes_level_up pl pl_lst board property = 
  (**get the current level from property
     ask which level they want to buy; it has to be greater from  previous level
  *)
  let old_level = property_level property in
  print_endline ("Which level do you want to buy? (You can only buy a level greater than the current level you own. Must be greater than "
                 ^ string_of_int old_level);
  print_string "> ";
  let new_lvl = try_command_level (read_line()) in
  let verified_lvl = compare_lvl old_level new_lvl in 
  let bp_arr = buy_price property in 
  let price = bp_arr.(verified_lvl) - bp_arr.(old_level) in
  print_endline (string_of_int price);
  buy_property_helper pl pl_lst board property verified_lvl price

let level_up_prop command player playerList board property = 
  match command with 
  | Yes -> yes_level_up player playerList board property
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

