open OUnit2
open Board
open Player
open Space
open Command
open Card

(*----------------------------TEST PLAN--------------------------------------)
  Our testing plan consists of two parts: OUnit testing and Play Testing.

  1. OUnit Testing - Blackbox testing
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

  2. Manual/Play Testing - Glassbox testing
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

let player_test_getters name funcname player expected_out = 
  name >:: (fun ctxt -> 
      assert_equal expected_out (funcname player ))

let player_property_test (name : string ) (player : Player.player)
    (expected_output : string list) = 
  let property_list = property_list player in 
  let string_property_list = property_name_printer 
      (fst (List.split property_list)) [] in
  name >:: (fun ctxt -> 
      assert_equal expected_output string_property_list)

let bool_jail_test name func_name player ex_out = 
  name >:: (fun ctxt -> 
      assert_equal ex_out (func_name player))

let update_player_test name func player input ex_out = 
  name >:: (fun ctxt -> 
      assert_equal ex_out (func player input))

let add_property_test name player level property ex_out = 
  name >:: (fun ctxt -> 
      assert_equal ex_out (add_property player level property))

let replace_player_test name pl new_player ex_out = 
  name >:: (fun ctxt -> 
      assert_equal ex_out (replace_player pl new_player))

let remove_property_test name player property ex_out = 
  name >:: (fun ctxt -> 
      assert_equal ex_out (remove_property player property))

let find_player_test name pl_name p_list ex_out = 
  name >:: (fun ctxt -> 
      assert_equal ex_out (find_player pl_name p_list))

let space_list = spacelist
let player_list = playerlist
let player1 = List.nth playerlist 0
let sample_player = {
  id = 4;
  name = "catpotato";
  current_location_id = 11;
  balance = 400;
  property_list = [(get_property space3, 0);(get_property space7,1);
                   (get_property space39, 2);];
  in_jail = false;
  jail_card = false;
  jail_count = ref 0;
}
let player_brown_full_test = {
  sample_player with 
  property_list = [(get_property space34,0);(get_property space35,0);
                   (get_property space37,0)];
}
let player_pink_full_test = {
  sample_player with 
  property_list = [(get_property space27,0);(get_property space28,0);
                   (get_property space29,0)];
}

let player_blue_full_test = {
  sample_player with 
  property_list = [(get_property space38,0); (get_property space39,0)];
}

let player_yellow_full_test = {
  sample_player with

  property_list = [(get_property space6, 0);(get_property space7,1);
                   (get_property space8,1)];
}

let player_blood_full_test = {
  sample_player with
  id = 9;
  property_list = [(get_property space54,0);(get_property space56,0);
                   (get_property space57,0)];
}

let player_not_full_test = {
  sample_player with
  id = 5;
  property_list = [(get_property space7,1);(get_property space8,1)];
}
let move_player_18 = move sample_player 7
let move_player_wraparound_1 = move move_player_18 22
let move_player_wraparound_9 = move move_player_18 30

let player_in_jail_true = {sample_player with in_jail = true; jail_card = true}
let sample_player_bankrupt = {sample_player with balance = (-100)}
let player_at_20 = {sample_player with current_location_id = 20}
let player_catlover = {sample_player with name = "CATLUVER"}
let sample_player_100 = {sample_player with balance = 500}
let sample_player_with_prop1 = {sample_player with property_list = 
                                                     [(property1, 1);
                                                      (get_property space3, 0);
                                                      (get_property space7,1);
                                                      (get_property space39,2);]
                               }
let player_amy = {player3 with name = "Amy"}
let fake_playerlist = [player1;player2; player3; sample_player]

let player_tests = [ 
  player_test_getters "player1 curr loc id" id player1 1;
  player_test_getters "player1 name - Meghana" name player1 "Meghana";
  player_test_getters "player1 initial balance" balance player1 3000; 
  player_property_test "player1 intiial [] property" player1 [];
  player_test_getters "sample player curr loc id" current_location_id 
    sample_player 11;
  player_test_getters "sample player name catpotato" name sample_player 
    "catpotato";
  player_test_getters "sample player balance" balance sample_player 400;
  player_property_test "sample player property" sample_player 
    ["Donlon";  "Goldwin Smith Hall"; "Collegetown Bagels"]; 
  player_test_getters "sample player moved 7 to 18" current_location_id 
    move_player_18 18;
  player_test_getters "move function w/ mod wraparound" current_location_id
    move_player_wraparound_1 1;
  player_test_getters "move function w/ mod wraparound" current_location_id
    move_player_wraparound_9 9;
  bool_jail_test "in_jail for sample_player false" in_jail sample_players false;
  bool_jail_test "in_jail for sample_player true" in_jail player_in_jail_true 
    true;
  bool_jail_test "jail_card for sample_player true" jail_card sample_player 
    false;
  bool_jail_test "jail_card for sample_player false" jail_card 
    player_in_jail_true true;
  player_test_getters "sample_player is_bankrupt true" is_bankrupt 
    sample_player_bankrupt true;
  player_test_getters "sample_player is_bankrupt false" is_bankrupt 
    sample_player false;
  player_test_getters "sample_player jail_count" jail_count sample_player 
    (ref 0);
  update_player_test "move sample_player to space 20" move_to_space
    sample_player 20 player_at_20;
  update_player_test "update name of sample_player with CATLUVER" update_name
    sample_player "CATLUVER" player_catlover;
  update_player_test "update balance of sample_player with $100 more dollars" 
    update_balance sample_player 100 sample_player_100;
  add_property_test "add property 1 to sample_player" sample_player 1 property1
    sample_player_with_prop1;
  remove_property_test "remove property1 from sample player's property list"
    sample_player_with_prop1 property1 sample_player;
  replace_player_test "replace sample_player w/ player 4" fake_playerlist 
    player4 playerlist;
  find_player_test "find player1 in playerList" "Amy" 
    [player1; {player2 with name = "Aaron"}; player_amy;
     {player4 with name = "Michelle"}] player_amy;
  {|find_player raise UnknownPlayer|}
  >:: (fun _ -> assert_raises (UnknownPlayer "aerg")
          (fun () -> find_player "aerg" [player1; {player2 with name = "Aaron"};
                                         player_amy; 
                                         {player4 with name = "Michelle"}]));
]


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

let space_getlevelprice_test name property expected_output =
  name >:: (fun ctxt -> 
      assert_equal expected_output (get_level_price property) ~printer:string_of_int)

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
    space_getproperty_test "getting property Low Rise 5 from space2" space2 
      property1;
    space_getlevelprice_test "property1 level prive" property1 8;
    space_rentprice_test "property1 rent_price list" property1 [|8;20;36|];
    space_buyprice_test "property1 buy_price list" property1 [|60;110;160|];
    space_getcolor_test "property1 color test" property1 "green";
    space_getlevel_test "property1 level = 0" property1 0;
    space_getspace_test "get space3" 3 [space12; space14; space15; space29;
                                        space3] space3;
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
      change_owner ex_prop "ME" new_ex_prop;
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

let rec lots_rolls input num bool=  
  let dice_num = fst (roll_dice input)  in
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