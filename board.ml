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

(* [if_full_set player property_just_bought] is called every single time 
   a property is bought. It will check whether the property that has been
   bought will allow the player to reach a full set of a color. A full set is 
   a set of 3 properties of the same color except a set of 2 for color "black"
   or "blue". If [property_just_bought] is the last property needed to
   reach a completed set, the function will print out the winner, else
   the game continues as per normal. *)
let if_full_set (player : Player.player)  
    (property_just_bought : Space.property) : unit =
  let color = property_color property_just_bought in
  let full_size = if String.equal color "black" || String.equal color "blue" 
    then 1 else 2 in
  let rec extract_color_property color_just_bought property_list acc = 
    match property_list with
    | h :: t -> if (property_color h) = color_just_bought 
      then extract_color_property color_just_bought t (h :: acc)
      else extract_color_property color_just_bought t acc
    | [] -> acc
  in let no_of_color_owned = List.length 
         (extract_color_property color 
            (fst(List.split(property_list player))) []) in 
  if no_of_color_owned = full_size 
  then begin print_endline 
      ("Winner is " ^ name player ^"! They have a full set of "
       ^ color ^ "! \nCongratulations! Thank you for playing Cornopoly! 
       Created by Amy Ouyang, Aaron Kang, Michelle Keoy, Meghana Avvaru.");
    exit 0; end
  else print_string ""

(* [try_command_level s] is what the player  will
   interact with to input either which level of the property they
   wish to buy. If the input is not 0, 1, or 2, it will raise mailformed
   and ask the player to input a valid command. *)
let rec try_command_level s =      
  try 
    parse_level_input s 
  with 
  | Malformed -> print_endline "Invalid command! Input a level."; 
    print_string "> "; 
    try_command_level (read_line())
  | Empty -> print_endline "Please enter a command! Input a level."; 
    print_string "> "; 
    try_command_level (read_line()) 

(* [try_command_property s p pl board property] is what the player [p] will
   interact with to input either yes or no for whether they wish to buy
   the property or not. If the input is not yes or no, it will raise mailformed
   and ask the player to input a valid command. *)
let rec try_command_property s p pl board property =      
  try 
    match parse_buy s with 
    | Yes -> yes_buy_property p pl board property 
    | No -> let updated_pL = replace_player pl p in  
      (updated_pL, board) 
  with 
  | Malformed -> print_endline "Invalid command! Input yes or no"; 
    print_string "> "; 
    try_command_property (read_line()) p pl board property
  | Empty -> print_endline "Please enter a command! Input yes or no"; 
    print_string "> "; 
    try_command_property (read_line()) p pl board property

(** [buy_property_helper player plst board prop level buy_price] is a 
    helper function for when a player tries to buy a property. It returns an 
    updated (Player.player list * Space.space list)*)
and buy_property_helper player plst board prop level buy_price = 
  let p' = update_balance (add_property player level prop) (-1 * buy_price) in
  let updated_pL = replace_player plst p' in  
  if balance p' <= 0 then 
    let () = print_endline "You do not have enough in your balance! Sorry!\nDo you still want to buy a property? (Yes or No). If so, input a valid level."; in
    try_command_property (read_line ()) player plst board prop 
  else begin let updated_p = (change_owner prop (name p')) in
    let updated_space = Property(change_level updated_p level) in
    let new_space_list = 
      List.map (fun x -> if space_id x = space_id updated_space 
                 then updated_space else x) board in
    let old_owner = property_owner prop in 
    if not(String.equal old_owner "") && not(String.equal old_owner 
                                               (name player)) then
      let rem_prop_own = remove_property 
          (find_player old_owner updated_pL) prop in 
      let owner_bal_upd = update_balance rem_prop_own (buy_price) in
      let new_playerlist = replace_player updated_pL owner_bal_upd in 
      let () = if_full_set player prop in (new_playerlist, new_space_list)
    else let () = if_full_set player prop in (updated_pL, new_space_list) end

(** [yes_buy_property p plist board prop] returns a tuple of a 
    Player.player list and a Space.space list that contains the updated
     information  of the list of all players [plist] and the game board 
     [board] after player [player] purchases the [prop] property 
*)
and yes_buy_property player plst board prop =
  print_endline "Which level do you want to buy? (Enter: 0, 1, or 2)";
  print_string "> ";
  let level = try_command_level (read_line()) in
  let bp_arr = buy_price prop in 
  let buy_price_level = bp_arr.(level) in 
  buy_property_helper player plst board prop level buy_price_level

let buy_off_someone command player playerList board property level buy_price = 
  match command with 
  | Yes -> buy_property_helper player playerList board property level buy_price
  | No -> let updated_pL = replace_player playerList player in  
    (updated_pL, board) 

(** [compare_lvl old_lvl new_lvl] is [new_lvl] if [new_lvl] is a valid level 
    that is greater than [old_lvl] and less than or equal to 2. Otherwise, 
    the funciton iss continuously called until a valid [new_lvl]] is inputted.
*)
let rec compare_lvl old_lvl new_lvl =
  if new_lvl > old_lvl && new_lvl <= 2 then new_lvl else 
    let () = print_endline 
        ("Invalid level! Enter a level greater than " 
         ^string_of_int old_lvl^" and less than or equal to 2. 
          Which level do you want to buy? (You can only buy a level greater than the current level of " 
         ^ string_of_int old_lvl ^")"); 
      print_string "> "; in
    compare_lvl old_lvl (try_command_level (read_line())) 

(** [yes_level_up pl pl_lst board property] returns an updated 
    (Player.player list * Space.space list) in a scenerio when a player 
    chooses to level up their property. *)
let yes_level_up pl pl_lst board property = 
  let old_level = property_level property in
  print_endline ("Which level do you want to buy? (You can only buy a level greater than the current level of "
                 ^ string_of_int old_level^ ")");
  print_string "> ";
  let new_lvl = try_command_level (read_line()) in
  let verified_lvl = compare_lvl old_level new_lvl in 
  let bp_arr = buy_price property in 
  let price = bp_arr.(verified_lvl) - bp_arr.(old_level) in
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


(* [if_full_set_test_helper player property_just_bought] is
   a function that is similar to if_full_set but returns a bool instead. This
   function is used for testing to confirm that if_full_set works by 
   returning a boolean. *)
let if_full_set_test_helper (player : Player.player)  
    (property_just_bought : Space.property) : bool =
  let color = property_color property_just_bought in
  let full_size = if color = "blue" then 1 else 2 in
  let rec extract_color_property color_just_bought property_list acc = 
    match property_list with
    | h :: t -> if (property_color h) = color_just_bought 
      then extract_color_property color_just_bought t (h :: acc)
      else extract_color_property color_just_bought t acc
    | [] -> acc
  in let no_of_color_owned = List.length 
         (extract_color_property color 
            (fst(List.split(property_list player))) []) in 
  if no_of_color_owned = full_size 
  then true else false