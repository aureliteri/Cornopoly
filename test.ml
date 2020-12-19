open OUnit2
open Board
open Player
open Space
open Command
open Card

(*----------------------------TEST PLAN--------------------------------------)
  Our testing plan consists of two parts: OUnit testing and Play Testing.

  1. OUnit Testing - Glassbox testing
  Our goal with the OUnit testing is to demonstrate that specific, testable
   functions in our Board, Player, Space, Command, and Card modules demonstrate
   accuracy and maintain their expected behaviors. It is important to note that
   all functions could not be tested via OUnit testing. The functions we could 
   not create OUnit tests were those that require user inputs and print strings.

  Specifically, the following functions (in their respective modules) could not
  be tested with OUnit:
   -[delete_player_board] (?), [land_someone_else_property] (?)
    Main:
      -[print_locations], [print_balances], [print_properties], [print_players],
      [print_initial_board], [update_board], [check_space_chance], 
      [check_space_jail], [check_space_penalty], [check_space_go], 
      [check_space_justvisiting], [check_space_property],[check_space],
      [try_command_buy_off_p], [print_buy_prices], [try_level_property],
      [print_prop_prices], [print_level_prices], [iterate], [double_rolled], 
      [player_in_jail], [jail_rules], [jail_pay_command], [jail_card_command],
      [jail_roll_command], [player_bankrupt], [player_not_bankrupt], [end_game],
      [play], [print_board_type_description],[choose_board], [main]

    Board: 
  - [try_command_level], [try_command_property], [buy_property_helper],
     [yes_buy_property], [compare_lvl], [yes_level_up], [level_up_prop]



  -We constructed OUnit test suites for the functions that do not require user
  inputs.

  2. Manual/Play Testing - Blackbox testing
  -We play tested our game to mainly test the functions in the main and board
  modules.
  - For every command input to be parsed, we inputed valid inputs and checked 
    if the outputs were correct and expected. We also tested invalid commands such
    as empty strings, random strings, and other invalid inputs.
  - For invalid command inputs, exception Malformed or exception Empty are 
    caught and an apprpriate output print requests another command to be inputted
  - Bankrupt Win Scenario Condition - one player remains and everyone else is bankrupt 
    we tested this multiple times by setting everyone but one player's balance to be greater than 0 and by having all players bankrupt from paying rent, penalty spaces, and cards that decrease balance.
    only one player in the playerlist remains as players with a balance of less than 0 are removed from the list
  - Colorset Win Scenario Condtion - player has purchased all properties of the same colorset
    we tested this by having one player buy all the properties of a color set and all the other players not buy any properties

  3. Why our testing 
*)

(** [pp_string s] pretty-prints string [s]. *)
let pp_string s = "\"" ^ s ^ "\""

(** [pp_list pp_elt lst] pretty-prints list [lst], using [pp_elt]
    to pretty-print each element of [lst]. *)
let pp_list pp_elt lst =
  let pp_elts lst =
    let rec loop n acc = function
      | [] -> acc
      | [h] -> acc ^ pp_elt h
      | h1 :: (h2 :: t as t') ->
        if n = 100 then acc ^ "..."  (* stop printing long list *)
        else loop (n + 1) (acc ^ (pp_elt h1) ^ "; ") t'
    in loop 0 "" lst
  in "[" ^ pp_elts lst ^ "]"

(** [property_order list1 list2] compares two lists to see whether
    they are equivalent lists. list1 and list2 must contain the same elements,
    though not necessarily in the same order. *)
let property_order list1 list2 =
  let uniq1 = List.sort_uniq compare list1 in
  let uniq2 = List.sort_uniq compare list2 in
  List.length list1 = List.length uniq1
  &&
  List.length list2 = List.length uniq2
  &&
  uniq1 = uniq2

let rec property_name_printer (property_list : Space.property list)
    (acc : string list) = 
  match property_list with
  | [] -> acc
  | h :: t -> property_name_printer t (acc @ [(property_name h)])

let current_location_test name player expected_output = 
  name >:: (fun ctxt -> 
      assert_equal expected_output (current_location_id player)
        ~printer: string_of_int )

let player_name_test fun_name player expected_output = 
  fun_name >:: (fun ctxt -> 
      assert_equal expected_output (name player)~printer: String.escaped)

let player_balance_test 
    name
    player 
    expected_output = 
  name >:: (fun ctxt -> 
      assert_equal expected_output (balance player)~printer: string_of_int)

let player_property_test 
    (name : string )
    (player : Player.player)
    (expected_output : string list) = 
  let property_list = property_list player in 
  let string_property_list = property_name_printer 
      (fst (List.split property_list)) [] in
  name >:: (fun ctxt -> 
      assert_equal ~printer:(pp_list pp_string)
        expected_output string_property_list
    )


let space_list = spacelist
let player_list = playerlist
let player1 = List.nth playerlist 0

let move_player_18 = move sample_player 7
let move_player_wraparound_1 = move move_player_18 22
let move_player_wraparound_9 = move move_player_18 30



let player_tests =
  [ current_location_test "player1 curr loc id" player1 1;
    player_name_test "player1 name - Meghana" player1 "Meghana";
    player_balance_test "player1 initial balance" player1 3000; 
    player_property_test "player1 intiial [] property" player1 [];
    current_location_test "sample player curr loc id" sample_player 11;
    player_name_test "sample player name catpotato" sample_player "catpotato";
    player_balance_test "sample player balance" sample_player 400;
    player_property_test "sample player property" sample_player 
      ["Donlon";  "Goldwin Smith Hall"; "Collegetown Bagels"]; 
    current_location_test "sample player moved 7 to 18" move_player_18 18;
    current_location_test "move function w/ mod wraparound" 
      move_player_wraparound_1 1;
    current_location_test "move function w/ mod wraparound" 
      move_player_wraparound_9 9;
  ]


(* let check_space_test 
    (name : string)
    (space: Space.space)
    (player: Player.player)
    (spacelist : Space.space list)
    (expected_output : Player.player * Space.space list) = 
   name >:: (fun ctxt -> 
      assert_equal expected_output (check_space space player spacelist))

    (* let buy_property command player board property=  *)
    (space: Space.space)
    (player: Player.player)
    (spacelist : Space.space list)
    (expected_output : Player.player * Space.space list) = 
   name >:: (fun ctxt -> 
      assert_equal expected_output (check_space space player spacelist)) *)

(** <----------------TEST FOR SPACE --------------------> *)

let space_getname_test name space expected_output =
  name >:: (fun ctxt -> 
      assert_equal expected_output (space_name space))

let space_getid_test name space expected_output =
  name >:: (fun ctxt -> 
      assert_equal expected_output (space_id space))

let space_getproperty_test name space expected_output =
  name >:: (fun ctxt -> 
      assert_equal expected_output (get_property space))

let space_getcardspace_test name space expected_output =
  name >:: (fun ctxt -> 
      assert_equal expected_output (get_cardspace space))

let space_getlevelprice_test name property expected_output =
  name >:: (fun ctxt -> 
      assert_equal expected_output (get_level_price property))

let space_rentprice_test name property expected_output = 
  name >:: (fun ctxt -> 
      assert_equal expected_output (rent_price property))

let space_buyprice_test name property expected_output = 
  name >:: (fun ctxt -> 
      assert_equal expected_output (buy_price property))

let space_getcolor_test name property expected_output =
  name >:: (fun ctxt -> 
      assert_equal expected_output (property_color property))

let space_getlevel_test name property expected_output =
  name >:: (fun ctxt -> 
      assert_equal expected_output (property_level property))

let space_getspace_test name id space_lst expected_output =
  name >:: (fun ctxt -> 
      assert_equal expected_output (get_space id space_lst))

let space_tests=
  [
    space_getname_test "Space name Low Rise 5" space2 "Low Rise 5";
    space_getname_test "Space name Jail" space10 "Jail";
    space_getname_test "Space name of Chance" space9 "Chance";
    space_getname_test "Space name of Penalty" space36 "Penalty";
    space_getname_test "Space name of Go" space1 "Go";
    space_getid_test "Space_id test: Cafe Jennie" space8 8;
    space_getid_test "Jail id" space10 10;
    (* space_getproperty_test  "Check if space 5 is property" space5  (Property space2); *)
    space_getlevelprice_test "property1 level is 2" property1 10; (**FAIL *)
    space_rentprice_test "property1 rent_price list" property1 [|20;10;10|];
    space_buyprice_test "property1 buy_price list" property1 [|20;10;10|];
    space_getcolor_test "property1 color test" property1 "green";
    space_getlevel_test "property1 level = 2" property1 2;
    space_getspace_test "get space3" 3 [space12; space14; space15; space29; space3] space3;
  ]

let property_getter_test name funcname prop ex_out =
  name >:: (fun ctxt -> 
      assert_equal ex_out (funcname prop))

let property_change_test name funcname prop new_owner ex_out =
  name >:: (fun ctxt -> 
      assert_equal ex_out (funcname prop new_owner)) 

let property_change_level name prop level ex_out =
  name >:: (fun ctxt -> 
      assert_equal ex_out (property_level (change_level prop level)))

let ex_prop = get_property space3
let new_ex_prop = change_owner ex_prop "ME"
let new_level_prop =  change_level property1 2

let property_tests=
  [
    property_getter_test "Property name of Donlon" property_name ex_prop 
      "Donlon";
    property_getter_test "Property id of Donlon" property_id ex_prop 3;
    property_getter_test "Property rent price of Donlon" 
      rent_price ex_prop [|12;30;38|]; 
    property_getter_test "Original property owner of Donlon" property_owner 
      ex_prop "";
    property_getter_test "New property owner of Donlon" property_owner 
      new_ex_prop "ME";
    property_getter_test "Property color of Donlon" property_color ex_prop 
      "green";
    property_getter_test "Buy price of Donlon" buy_price 
      ex_prop [|70;120;170|]; 
    property_change_test "changeowner of donlon to me" 
      change_owner ex_prop "ME" 
      new_ex_prop;
    property_getter_test "Property level of donlon" property_level ex_prop 0;
    property_change_level "change level to 2" (get_property space3) 2 2;
  ]

let penalty_getter_test name funcname pen ex_out =
  name >:: (fun ctxt -> 
      assert_equal ex_out (funcname pen))

let ex1_pen = get_penalty space18
let ex2_pen = get_penalty space36

let penalty_tests =
  [
    penalty_getter_test "Name of Penalty" penalty_name ex1_pen "Penalty";
    penalty_getter_test "Description of Penalty" penalty_description ex1_pen
      "Flu season! Pay $40 for your flu shot"; 
    penalty_getter_test "Price of Penalty" penalty_price ex1_pen 40; 
    penalty_getter_test "Name of Penalty" penalty_name ex2_pen "Penalty";
    penalty_getter_test "Description of Penalty" penalty_description ex2_pen
      "$60 Student activity fee..."; 
    penalty_getter_test "Price of Penalty" penalty_price ex2_pen 60; 
  ]

(** <---------------------------TEST FOR BOARD ----------------> *)

(** ADD PICK CARD TEST -> Can't do pick card test because it is random. We cannot expect anything *)

let rec lots_rolls input num bool=  
  let dice_num = fst (roll_dice input)  in
  (* print_endline (string_of_int  dice_num); *)
  match num with 
  | 0 -> bool
  | _ -> if dice_num <= (12) && dice_num >= (0) 
    then lots_rolls input (num -1) true else false

let roll_dice_test name num input output = 
  let roll_bool =  lots_rolls input num true in
  name >:: (fun ctxt -> 
      assert_equal output (roll_bool))

let card_action_test name act_lst player output = 
  name >:: (fun ctxt -> 
      assert_equal output (card_action act_lst player))


(* let bursar_player = update_balance sample_player (-200)
   let duffield_player = move_to_space sample_player 35 *)
let bursar_player = {sample_player with balance = 200}
let duffield_player = {sample_player with current_location_id = 35}
let go_player = {sample_player with current_location_id = 1; balance = 450;}

let player_if_full_set
    (name : string)
    (player : Player.player)  
    (property : Space.property) 
    (output : bool) = 
  name >:: (fun ctxt -> 
      assert_equal output (if_full_set_test_helper player property))


let board_tests = 
  [
    roll_dice_test "roll dice valid 6-sided die 100 times" 100 6 true;
    roll_dice_test "invalid roll dice on 20-sided dice roll number 100 times" 
      100 20 false;
    card_action_test "card1 change balance due to bursar on sample player" 
      [Change (-200)] sample_player bursar_player;
    card_action_test "card8 aciton lst move to duffield on sample player" 
      [Move 35] sample_player duffield_player;
    card_action_test "card4 aciton lst go to go on sample player" 
      [Move 1; Change 50] sample_player go_player;
    (* test roll dice *)
    (* test check_space *)
    (* check_space_test "player lands on unowned property" space2 player1 space_list 
       ?? *)
    player_if_full_set "player buys the last yellow property to become a
    full set" player_yellow_full_test (get_property space8) true;
    player_if_full_set "player buys the last blue property to become a
    full set" player_blue_full_test (get_property space39) true;
    player_if_full_set "player buys the last brown property to become a
    full set" player_brown_full_test (get_property space37) true;
    player_if_full_set "player buys the last pink property to become a
    full set" player_pink_full_test (get_property space29) true;
    player_if_full_set "player buys the last blood property to become a
    full set" player_blood_full_test (get_property space57) true;


    player_if_full_set "player not full" player_not_full_test 
      (get_property space39) false;


  ]
(**<-----------------TESTS FOR COMMAND-------------------------------------> *)

let jail_command_test (name : string) (str : string) (ex_out) : test = 
  name >:: (fun ctxt -> 
      assert_equal ex_out (parse_jail str))

let jail_exn_test (name : string) (str : string) (ex_out) : test = 
  name >:: (fun _ -> 
      assert_raises ex_out (fun () -> parse_jail str))

let buy_command_test (name : string) (str : string) (ex_out) : test = 
  name >:: (fun ctxt -> 
      assert_equal ex_out (parse_buy str))

let buy_exn_test (name : string)  (str : string) (ex_out) : test = 
  name >:: (fun _ -> 
      assert_raises ex_out (fun () -> parse_buy str))

let board_choice_test  (name : string) (str : string)  (ex_out) : test =
  name >:: (fun ctxt -> 
      assert_equal ex_out (parse_board_choice str))

let board_exn_test (name : string) (str : string) (ex_out) : test = 
  name >:: (fun _ -> 
      assert_raises ex_out (fun () -> parse_board_choice str))

let level_up_test (name : string) (str : string) (ex_out) : test = 
  name >:: (fun _ -> 
      assert_equal ex_out (parse_level_input str))

let level_up_exn_test (name : string) (str : string) (ex_out) : test = 
  name >:: (fun _ -> 
      assert_raises ex_out (fun () -> parse_level_input str))

let command_tests = 
  [
    jail_command_test "Jail pay" "PAY" Pay;
    jail_command_test "Jail pay case not sensitive" "pay" Pay;
    jail_command_test "Jail card" "CaRd" Card;
    jail_command_test "Jail roll" "ROll" Roll;
    jail_exn_test "Jail empty" "      " Empty;
    jail_exn_test "Jail malformed" "Let ME OUT!" Malformed;
    buy_command_test "Buy yes" "Yes" Yes;
    buy_command_test "Buy no" "NO" No;
    buy_exn_test "Buy empty" "         " Empty;
    buy_exn_test "Buy EVERYTHING" "everything" Malformed;
    board_choice_test "Choose dark theme" "dARK" Dark;
    board_choice_test "Choose dark theme case not sensitive" "dark" Dark;
    board_choice_test "Choose classic theme" "classic" Classic;
    board_exn_test "Choose _____ theme" "       " Empty;
    board_exn_test "Choose light theme" "light" Malformed;
    level_up_test "Level up to 2" "2" 2;
    level_up_exn_test "Level up to 100 malformed" "100" Malformed;
    level_up_exn_test "Level up to 3 malformed" "3" Malformed;
    level_up_exn_test "Level up to empty level!!" "       " Empty;
  ]


(*-------------------------- CARD OUNIT TESTS ------------------------------- *)

let card_id_test (name : string) (card : Card.card) (ex_out : int) = 
  name >:: (fun ctxt -> 
      assert_equal ex_out (card_id card))

let card_description_test (name : string) (card : Card.card) 
    (ex_out : string) = 
  name >:: (fun ctxt -> 
      assert_equal ex_out (card_description card)~printer: String.escaped) 

let card_act_test (name : string) (card : Card.card) (ex_out : action list) = 
  name >:: (fun ctxt -> 
      assert_equal ex_out (card_act card))

let card_choose_test (name : string) (cardlst : card list) (ex_out : card) = 
  name >:: (fun ctxt -> 
      assert_equal ex_out (choose cardlst))

let card_tests = [
  card_id_test "Empty card test" empty 0;
  card_id_test "Card 3 test" card3 3;
  card_description_test "Empty card description" empty "";
  card_description_test "card description with get property name function" 
    card10 "Take a trip to Rhodes Hall – If you pass Go, collect $200.";
  card_description_test "Card 20 description" card20 
    "Your friends threw you a surprise birthday party! Collect $100!";
  card_act_test "Empty card actions" empty [];
  card_act_test "Card 10 actions" card10 [Move 37];
  card_choose_test "Card_choose empty" [] empty;
  card_choose_test "Card_choose test 1" [card11; card15; card6] card11;
]


(*----------------------------------- Main Tests ---------------------------- *)

(**check if we can test [delete_player_board] (?), [land_someone_else_property] (?) *)

let suite =
  "tests for CORNOPOLY" >::: List.flatten [
    player_tests; 
    board_tests;
    space_tests;
    property_tests;
    penalty_tests;
    command_tests;
    card_tests;
  ]

let _ = run_test_tt_main suite 