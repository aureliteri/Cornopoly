open Board  
open Player
open Space
open Card
open Command

(** [print_locations playerlist acc] iterates through [playerlist] and accumulates 
    the location of each player in the game as a string *)
let rec print_locations playerlist board acc = 
  match playerlist with
  | [] -> acc
  | h :: t -> 
    let player_loc = space_name (get_space(current_location_id h) board)in
    let complete_string = name h ^ " is currently at " ^ player_loc^".\n" in
    print_locations t board (acc ^ complete_string)

(** [print_balances playerlist acc] iterates through [playerlist] and accumulates 
    the balance of each player in the game as a string *)
let rec print_balances playerlist acc = 
  match playerlist with
  | [] -> acc
  | h :: t -> 
    let player_balance = string_of_int (balance h) in
    let complete_string = name h ^ " currently has a balance of $" 
                          ^ player_balance ^ ".\n" in
    print_balances t (acc ^ complete_string )

(** [print_properties properties] iterates through [properties] and prints 
    all property traits of all properties. *)
let rec print_properties properties : unit = 
  match properties with
  | [] -> print_endline ""
  | (k,v) :: t -> 
    print_endline ("Name: " ^ property_name k);
    print_endline ("Ownership Level " ^ string_of_int v);
    print_endline ("ID: " ^ string_of_int (property_id k));
    print_endline ("Color: " ^ property_color k);
    print_endline ("Rent Price: $" ^ string_of_int (rent_price k).(v) ^ "\n");
    print_properties t 

(** [print_players players] prints the status of every player [players], 
    including the player's name, location, balance, and list of properties. *)
let rec print_players players board = 
  match players with
  | [] -> print_endline ""
  | h :: t -> let p_id = string_of_int (id h) in 
    let p_name = name h in 
    let p_cur_loc = space_name (get_space (current_location_id h) board) in 
    let p_balance = string_of_int (balance h)in 
    let p_properties = property_list h in print_endline (**FIX PROPERTIES *)
      ("\n" ^ p_name ^ "'s ID is " ^ p_id ^ " and their current location is " 
       ^ p_cur_loc ^ ".\nTheir balance is $" ^ p_balance ^ 
       ". Their properties are:");
    if List.length p_properties = 0 
    then 
      print_endline "None" else 
      print_properties p_properties; 
    print_players t board

(** [print_initial_board spaces player] prints all of the information about
    the game board. The informaiton includes each player's name, starting
    balance, their current location, and the current list of properties they own. 
    It also includes all of the space names and ids. *)
let print_initial_board (spaces : space list) (player : player list) : unit = 
  let rec print_spaces lst = 
    match lst with
    | [] -> print_endline ""
    | h :: t -> let id = space_id h in 
      print_endline ((string_of_int id ) ^ ". " ^ space_name h); 
      print_spaces t
  in print_spaces spaces

(**[delete_player_record board player acc] deletes all properties of [player] 
   from [board], re-initalizing the owned properties of [player]. This method is
   called when [player] is eliminated *)
let rec delete_player_record board player acc = 
  match board with 
  | [] -> acc 
  | h :: t ->  
    match h with
    | Property x -> 
      if property_owner x = name player 
      then delete_player_record t player (Property (change_owner x "") :: acc) 
      else delete_player_record t player (h :: acc)
    | _ ->  delete_player_record t player (h :: acc)

(**[update_board playerlist board] prints all the locations and balances of all 
   players*)
let update_board playerlist board =
  print_endline ("\n" ^ print_locations playerlist board "");
  print_endline (print_balances playerlist "")

(**[check_space_chance player playerList board] is the tuple containing
   the updated [playerlist] and [board]. [check_space_chance] is specifically  
   called when the [player] lands on a card space. This function picks a random
    card from the card and the [player] is taken through the specific card's
    actions. The updated [playerlist] contains the same [player] that has
     undergone the card action.*)
let check_space_chance player playerList (board: Space.space list) = 
  let chosen_card = pick_card (Array.length cardlist) in
  print_endline ("The card you have chosen is: \n"
                 ^ (card_description chosen_card));
  let card_action_player = card_action (card_act chosen_card) player in 
  (replace_player playerList card_action_player , board)

(** [check_space_jail jail player playerList board] updates [player] so that 
    [player] goes to jail and retuns (Player.player list * Space.space list) that 
    contains all updated players and spaces *)
let check_space_jail player playerList (board: Space.space list)  = 
  let () = print_endline "Bad luck! You have landed in jail." in
  let p' = change_jail player true in (replace_player playerList p', board)

(** [check_space_penalty penalty player playerList board] updates [player] according to
    what [penalty] player landed on and retuns (Player.player list * Space.space list) that 
    contains all updated players and spaces *)
let check_space_penalty penalty player playerList (board : Space.space list) = 
  print_endline "You have landed on a Penalty space.";
  print_endline (penalty_description penalty);
  let penalty_update = update_balance player (-1 * penalty_price penalty) in 
  (replace_player playerList penalty_update, board)

(**[check_space_go chance player playerList board] is the tuple containing
   the updated [playerlist] and [board]. [check_space_go] passes the player
    through the Go space. The updated [playerlist] contains the same [player] 
    that has passed go.*)
let check_space_go (playerList : Player.player list)(board : Space.space list)=
  print_endline "Pass Go! You have collected $200."; (playerList, board)

(**[check_space_justvisiting playerList board] is the tuple containing
   the updated [playerlist] and [board]. [check_space_justvisiting] passes the
    player through the JustVisiting space. The updated [playerlist] 
    contains the same [player] that has passed JustVisiting.  *)
let check_space_justvisiting  playerList board  = 
  print_endline "Oop. Close call to Jail, luckily you are just visiting.";
  (playerList, board)

(**[try_command_buy_off_p] parses user input [s] and
    returns (Player.player list * Space.space list) according to user's input
    about purchasing a property owned by another player. *)
let rec try_command_buy_off_p s p pl board property level buy_price=      
  try 
    buy_off_someone (parse_buy s) p pl board property level buy_price
  with 
  | Malformed -> print_endline "Invalid command! Input yes or no"; 
    print_string "> "; 
    try_command_property (read_line()) p pl board property
  | Empty -> print_endline "Please enter a command! Input yes or no"; 
    print_string "> "; 
    try_command_property (read_line()) p pl board property

(**[land_someone_else_property player playerList baord property] updates 
   [player] [board] and [property] according to interaction between [player] and 
   [property]. [player] must first pay rent, then decide if [player] wants to 
   purchase the property from the previous owner. The updated 
   (Player.player list * Space.space list) is returned.*)
let land_someone_else_property player playerList board property =  (**FIX FOR NEW PROPERTY LIST *)
  let cur_price = get_level_price property in
  print_endline ("You have landed on " ^(property_name property) ^ 
                 ". It is owned by " ^ property_owner property ^ 
                ". \nYou must pay rent of $" ^ 
                 (string_of_int (cur_price) ^ "."));
  let pl = update_balance player (-1 * cur_price) in
  let updated_owner = update_balance (find_player (property_owner property) 
                                        playerList) cur_price in
  let lst = replace_player playerList pl in
  let lst2 = replace_player lst updated_owner in
  print_endline ("The price of " ^ (property_name property) ^ " is $" ^
                 (string_of_int ((buy_price property).(property_level property))
                  ^ " at Level " ^ (string_of_int (property_level property))));
  print_endline "Do you want to purchase it? (Type: Yes or No)"; 
  print_string "> ";
  try_command_buy_off_p (read_line()) pl lst2 board property 
    (property_level property) ((buy_price property).(property_level property))

(**[print_buy_prices] prints the list of level 0, 1, and 2 buy prices for a
   [property].*)
let print_buy_prices property = 
  Array.iteri (fun i p -> print_endline 
                  ("Property level: " ^ string_of_int i ^ ", Price: $"^
                   string_of_int p)) (buy_price property)

(**[try_level_property] parses user input [s] and
    returns (Player.player list * Space.space list) according to user's input
    about leveling up on a property the player [p] already owns.*)
let rec try_level_property s p pl board property =      
  try 
    level_up_prop (parse_buy s) p pl board property
  with 
  | Malformed -> print_endline "Invalid command! Input yes or no."; 
    print_string "> "; 
    try_level_property (read_line()) p pl board property
  | Empty -> print_endline "Please enter a command! yes or no"; 
    print_string "> "; 
    try_level_property (read_line()) p pl board property

(**[print_prop_prices player pList board property] displays the current 
property landed on and the prices and prompts the player to input a command*)
let print_prop_prices player pList board property : unit = 
  print_endline ("You landed on " ^ property_name property ^".");
  print_endline ("The property prices are");
  print_buy_prices property;
  print_endline "Do you want to purchase it? (Type: Yes or No)";     
  print_string "> "

(**[print_level_prices player pList board property] displays the current 
level of the property landed on and the associated prices as well as
 prompts the player to input a command*)
let print_level_prices player pList board property : unit = 
  print_endline ("\nThis property's level is currently " ^  
     string_of_int (property_level property) 
     ^". \nDo you want to level up this property?");
  print_endline ("The property prices are: ");
  print_buy_prices property;
  print_string "> "

(**[check_space_property space player playerList board property] updates checks
   if [space] i owned by [player] and returns an updated 
   (Player.player list * Space.space list) accordingly *)
let check_space_property space player playerList board property =  (**FIX FOR NEW PROPERTY LIST *)
  if (String.equal (property_owner property) "") then  (**HERREE *)
    begin
      let () = print_prop_prices player playerList board property in 
      try_command_property (read_line()) player playerList board property 
    end
  else begin 
    if String.equal (property_owner property) (name player)
    then begin
      print_endline ("You landed on " ^ property_name property ^". You own this property. You get to stay for free!"); (**Implement level update *)
      if (property_level property = 2) then 
        let () = print_endline ("This propertry's level is MAX") in
        (replace_player playerList player, board)
      else
        let () = print_level_prices player playerList board property in
        try_level_property (read_line()) player playerList board property 
    end
    else
      land_someone_else_property player playerList board property (** Match last owner's level *)
  end  

(**[check_space].... pass in 
   [space] which the current space that the player is on, pass in 
   [player] which is the current player, 
   [player_lst] which is ALLLLL of the players in the CURRENT turn,
   pass in [board] which is the CURRENT board. *)

(**[check_space space player playerList board] is the updated playerList board tuple given from pattern-matching 
   the [space] the [player] lands on, and updates the [player] information 
   and [board] *)
let check_space (space: space) player (playerList: Player.player list) 
    (board: Space.space list) : (Player.player list * Space.space list) =
  match space with
  | Property property ->  
    check_space_property space player playerList board property
  | CardSpace chance ->
    check_space_chance player playerList board 
  | Jail jail ->
    check_space_jail player playerList board 
  | Penalty penalty ->
    check_space_penalty penalty player playerList board 
  | Go go -> 
    check_space_go playerList board 
  | JustVisiting jv ->
    check_space_justvisiting playerList board 

(** [counter] is a counter for the number of doubles a player rolls in a row.
This can we shared amoungst all players because player turns are discrete. *)
let counter = ref 0

(** [iterate playerlist sp acc] is one turn in the game of Cornopoly in which 
    every player in [playerlist] moves to a space and updates the player 
    and the space information accordingly finally returning [acc] which is a 
    tuple of the updated [playerlist] and the updated [sp] *)
let rec iterate playerlist (sp: space list) acc =
  match playerlist with
  | [] -> acc | h :: t -> print_endline (" \nIt's "^ name h ^ " turn!");
    if (in_jail h) = false then begin let roll = roll_dice 6 in 
      let new_player = move h (fst roll) in 
      print_endline (name h ^ " has rolled a "^ string_of_int (fst roll) ^"!");
      let new_space = get_space (current_location_id new_player) sp in 
      let upd_tup = check_space new_space new_player
          ((fst acc) @ playerlist) sp in
      let current_player = find_player (name h) (fst upd_tup) in 
      let new_acc = (List.filter (fun x -> id x < id h) (fst upd_tup), sp) in 
      let new_t = List.filter (fun x -> id x > id h) (fst upd_tup) in 
      if (balance (current_player) <= 0) then 
        player_bankrupt current_player playerlist sp new_acc
      else let upd_sp = snd upd_tup in  
        if (snd roll) then (* if a double is rolled *)
          double_rolled new_player new_t upd_sp new_acc current_player
        else begin counter := 0;
          iterate new_t (upd_sp) (current_player :: fst new_acc, upd_sp) 
        end 
      end else player_in_jail h acc sp t

(** [double_rolled new_player new_t updated_sp new_acc current_player]
    is when a double is rolled and keeps track of the number of doubles.
    If 3 doubles are rolled then the [new_player]'s location is set to 
    jail and passed into iterate along with [new_t], [updated_sp], [new_acc]. 
    Otherwise,[current_player] and the other parameters are passed into iterate.
*)
and double_rolled new_player new_t updated_sp new_acc current_player = 
  (* if a double is rolled *)
  print_endline("You rolled a double!");
  incr counter; (*add 1 to the count of doubles rolled *)
  if !counter = 3 
  then (*if the # of doubles is 3, then send the player to jail. *)
    let () = print_endline ("You rolled 3 doubles in total! Go to Jail.") in
    let jail_player = (change_jail (set_location new_player 10) true ) in 
    iterate new_t (updated_sp) (jail_player :: (fst new_acc), updated_sp) 
  else iterate (current_player :: new_t) (updated_sp) (fst new_acc, updated_sp)

(** [player_in_jail h acc sp t] is the function called when the player [h]
    is in jail. The player will be in jail for 3 turns or the player can 
    try to get out of jail early by satisfyting [jail_rules] by 
    either paying, having a card, or rolling. *)
and player_in_jail h acc sp t = 
  incr (jail_count h);
  if !(jail_count h) = 1 then 
    print_endline (name h^" is in jail! You will be stuck here for three turns. \nYou can pay a fine of $100, use your get out of jail free card, \nor try to roll a double to leave jail early.");
  let rec try_command s =         
    print_string ("> ");
    try 
      jail_rules (parse_jail s) h acc sp t
    with 
    | Malformed -> print_endline "Invalid command! Try Again"; 
      print_string "> "; 
      try_command (read_line())
    | Empty -> print_endline "Please enter a command!"; 
      print_string "> "; 
      try_command (read_line())
  in 
  print_endline ("Enter PAY, CARD, or ROLL");
  print_string ("> ");
  try_command (read_line())

(** [jail_rules command player acc sp playerlist] matches the [command] 
    with Pay, Card, and Roll and returns the tuple of the 
    updated [playerlist] and updated [sp] accordingly to whether 
    they are free from jail*)
and jail_rules command player acc sp playerlist = 
  match command with
  | Pay -> jail_pay_command player acc sp playerlist
  | Card -> jail_card_command player acc sp playerlist
  | Roll -> jail_roll_command player acc sp playerlist

(**[jail_pay_command player acc sp playerlist] checks if the player can pay 
   the jail fee. If they can pay, the player is taken out of jail with $100
    taken out of their balance. If they cannot, the player is requested to 
    input a different jail command. *)
and jail_pay_command player acc sp playerlist = 
  if (balance player < 100) then 
    let () = print_endline "You do not have enough in your balance to pay! Type in another command." 
    in jail_rules (parse_jail (read_line())) player acc sp playerlist
  else 
    let pay_jail_player = update_balance player (-100) in
   (jail_count player) := 0;
    let not_in_jail = change_jail pay_jail_player false in 
    print_endline ("Congrats! You have paid $100 to get out of jail.");
    iterate playerlist sp (not_in_jail :: fst acc , snd acc)

(** [jail_card_command player acc sp playerlist] checks if the player 
    has a "Get Out of Jail Card" to get out of jail. If they player has this 
    card, then they are taken out of jail. Otherwise, the player must input
    a different jail command.  *)
and jail_card_command player acc sp playerlist = 
  if (jail_card player) 
  then 
    let used_card = change_jail_card player false in 
    let updated_player = change_jail used_card false in
    print_endline ("Congrats! You used your Get Out of Jail Card. \nYou are out of jail.");
    (jail_count player) := 0;
    iterate playerlist sp (updated_player :: fst acc , snd acc)
  else
    let () = print_endline ("You do not have a Get Out of Jail Card. \nEnter another command.")
    in print_string ("> ");
    jail_rules (parse_jail (read_line())) player acc sp playerlist

(**[jail_roll_command] checks to see if they player rolls a double to exit jail.
   If the player rolls a double, they are removed from jail. If they don't roll
    a double, the player's turn is passed on. If player has remained in jail for
     three turns, they are taken out of jail automatically.  *)
and jail_roll_command player acc sp playerlist = 
  if !(jail_count player) = 3 
  then 
    ((jail_count player) := 0;
     let not_in_jail = change_jail player false  in
     let () = print_endline ("You have stayed in jail for three turns. You are now out of jail.") in
     iterate playerlist sp (not_in_jail :: fst acc , snd acc))
  else begin
    if snd (roll_dice 6)
    then ((jail_count player) := 0;
          let not_in_jail = change_jail player false  in
          let () = print_endline ("Congrats! You have rolled a double - you are out of jail!")
          in iterate playerlist sp (not_in_jail :: fst acc , snd acc))
    else 
      let () =  print_endline 
          ("You didn't roll a double. You are still in jail.") in 
      iterate playerlist sp (player :: fst acc , snd acc)
  end

(** [player_bankrupt player playerlist sp acc] returns the tuple of 
    the updated [playerlist] with [player] removed as they are bankrupt 
    and updated [sp] *)
and player_bankrupt player playerlist sp acc = 
  let () = print_endline ("Your balance is now $" ^ 
                          (string_of_int (balance (player)))) in
  let () = print_endline "You have gone bankrupt. You're out of the game!" in 
  let new_board = List.rev(delete_player_record sp (player) []) in
  iterate (remove_player player playerlist) new_board (fst acc, new_board)

(** [player_not_bankrupt current_player new_player playerlist sp acc roll] 
    returns the tuple of the updated [playerlist] and updated [sp] when [player]
    is not bankrupt (not yet eliminated)*)
and player_not_bankrupt current_player new_player playerlist sp acc roll = 
  if (snd roll) then 
    begin
      print_endline ("You rolled a double!");
      incr counter; 
      if !counter = 3 
      then 
        let () = print_endline ("You rolled 3 doubles! Go to Jail.") in
        let jail_player = (change_jail (set_location new_player 10) true )in 
        iterate playerlist (sp) (jail_player :: (fst acc), sp)
      else iterate (current_player :: playerlist) (sp) (fst acc, sp) 
      
    end 
  else begin
    counter := 0;
    iterate playerlist (sp) (current_player :: fst acc, sp) 
  end 

(** [end_game lst] iterates through the player list [lst] and sees 
    if there is only one player. If there is one player, they are declared 
    the winner. Otherwise, the game continues.*)
let end_game lst : unit = 
  match lst with 
  | [] -> print_endline ("No winner sorry."); 
    exit 0;
  | h :: t -> if List.length t = 0 then 
      (print_endline 
         (name h ^  " is the winner! Everyone else has gone bankrupt.Thank you for playing Cornopoly! Created by Amy Ouyang, Aaron Kang, Michelle Keoy, Meghana Avvaru."); 
       exit 0; ) 
    else ()

(** [play s player_lst space_lst] runs the game recursively if [s] is not 
    "quit" and continuously updates the [player_lst] and [space_lst] until
    there is a winner *)
let rec play s player_lst space_lst : unit = 
  match s with
  | "quit" -> exit 0;
  | _ -> ( 
      print_players player_lst space_lst;
      let new_lst = iterate player_lst space_lst ([], []) in
      let pl_lst = List.rev (fst new_lst) in
      let sp_lst = snd new_lst in 
      end_game pl_lst;
      update_board pl_lst sp_lst; 
      print_endline "Type 'quit' to quit. Type anything else to continue.";
      let s = read_line() in
      play s pl_lst (sp_lst);)

(**[print_board_types] prints the dark vs. classic game board descriptions. *)
let print_board_type_description () = 
  print_endline ("\nYou have a choice of which game board you would like to play.");
  print_endline ("Would you like to play the Classic Cornopoly game board? (Normal)");
  print_endline ("Classic features: A typical game of Cornolopoly with our favorite Cornell campus locations as main properties." );
  print_endline ("The properties include CKB, Duffield Hall, Mann Library, and more!");
  print_endline(" ");
  print_endline ("Or would you rather play the Dark Cornopoly gameboard? (Difficult)");
  print_endline ("Dark features: A darker game of Cornopoly with the nightmarish version of Cornell campus locations as the main properties.");
  print_endline ("The properties include Klarman Ghouls, The Deserted Goldwin Smith Hall, Becker Remains, and more! The rent prices and buy prices are higher in Dark mode.");
  print_endline(" ")

(**[choose_board] allows the user to select which board type they would like
   to play Cornopoly with. The users can choose between a Dark or a 
   Classic board. *)
let choose_board () = 
  print_board_type_description ();
  let rec try_board_command s = 
    try match parse_board_choice s with
      | Dark ->  Space.spacelist_dark
      | Classic ->  Space.spacelist
    with 
    | Malformed -> print_endline "Invalid command! Try Again"; 
      print_string "> "; try_board_command (read_line())
    | Empty -> print_endline "Please enter a command!"; 
      print_string "> "; 
      try_board_command (read_line())
  in print_endline ("Enter DARK or CLASSIC");
  print_string ("> "); try_board_command (read_line())

(** [main] begins the game of Cornopoly with instructions and allows the players
    to insert their own names and then starts the game*)
let main () = Random.self_init ();
  print_endline("Welcome to Cornopoly!! \nINSTRUCTIONS: The goal of this game is to win a full color set, or bankrupt the rest of your players. \nYou can do this by purchasing properties on the board, and staying out of jail. \n\nPlayer 1, please insert your name:");
  let p1_name = read_line () in
  let p1 = update_name (List.nth Player.playerlist 0) p1_name in
  print_endline("Player 2, please insert your name:");
  let p2_name = read_line () in
  let p2 = update_name (List.nth Player.playerlist 1) p2_name in
  print_endline("Player 3, please insert your name:");
  let p3_name = read_line () in
  let p3 = update_name (List.nth Player.playerlist 2) p3_name in
  print_endline("Player 4, please insert your name:");
  let p4_name = read_line () in  
  let p4 = update_name (List.nth Player.playerlist 3) p4_name in
  let chosen_b = choose_board () in
  print_endline("\nThe players are: "^p1_name^", "^p2_name^", "^p3_name^", " ^
                p4_name^".\nHere is the layout of the initial board: ");
  print_initial_board chosen_b [p1;p2;p3;p4];
  print_endline "Type quit to quit. Type anything else to play.";
  let s = read_line () in play s [p1;p2;p3;p4] chosen_b;
  match read_line() with | exception End_of_file -> ()|file_name -> failwith ""

(** [main ()] prompts for the game to play, then starts it. *)
let () = main ()