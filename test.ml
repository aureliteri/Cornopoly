open OUnit2
open Board
open Player
open Space
open Command

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
  let string_property_list = property_name_printer property_list [] in
  name >:: (fun ctxt -> 
      (* assert_equal true 
         (property_order expected_output (string_property_list) ) *)
      assert_equal ~printer:(pp_list pp_string) expected_output string_property_list
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
    player_balance_test "player1 initial balance" player1 300; 
    player_property_test "player1 intiial [] property" player1 [];
    current_location_test "sample player curr loc id" sample_player 11;
    player_name_test "sample player name - catpotato" sample_player "catpotato";
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

(* let space_getproperty_test name space expected_output =
   name >:: (fun ctxt -> 
      assert_equal expected_output (get_property space))

   let space_getcardspace_test name space expected_output =
   name >:: (fun ctxt -> 
      assert_equal expected_output (get_cardspace space)) *)

let space_tests=
  [
    space_getname_test "Space name Low Rise 5" space2 "Low Rise 5";
    space_getname_test "Space name Jail" space10 "Jail";
    space_getname_test "Space name of Chance" space9 "Chance";
    space_getname_test "Space name of Penalty" space36 "Penalty";
    space_getname_test "Space name of Go" space1 "Go";
    space_getid_test "Space_id test: Cafe Jennie" space8 8;
    space_getid_test "Jail id" space10 10;


  ]

let property_getter_test name funcname prop ex_out =
  name >:: (fun ctxt -> 
      assert_equal ex_out (funcname prop))

let ex_prop = get_property space3
let new_ex_prop = change_owner ex_prop "ME"

let property_tests=
  [
    property_getter_test "Property name of Donlon" property_name ex_prop 
      "Donlon";
    property_getter_test "Property id of Donlon" property_id ex_prop 3;
    property_getter_test "Property rent price of Donlon" rent_price ex_prop 24;
    property_getter_test "Original property owner of Donlon" property_owner 
      ex_prop "";
    property_getter_test "New property owner of Donlon" property_owner 
      new_ex_prop "ME";
    property_getter_test "Property color of Donlon" property_color ex_prop 
      "green";
    property_getter_test "Buy price of Donlon" buy_price ex_prop 17;
  ]

let penalty_getter_test name funcname pen ex_out =
  name >:: (fun ctxt -> 
      assert_equal ex_out (funcname pen))

let ex1_pen = get_penalty space36
let ex2_pen = get_penalty space18

let penalty_tests =
  [
    penalty_getter_test "Name of Penalty" penalty_name ex1_pen "Penalty";
    penalty_getter_test "Description of Penalty" penalty_description ex1_pen
      "$60 Student activity fee..."; 
    penalty_getter_test "Price of Penalty" penalty_price ex2_pen 40; 
  ]

(** <---------------------------TEST FOR BOARD ----------------> *)


let board_tests = 
  [
    (* test roll dice *)
    (* test check_space *)
    (* check_space_test "player lands on unowned property" space2 player1 space_list 
       ?? *)

  ]

(**<-----------------TEST FOR COMMAND---------------> *)

let jail_command_test name str ex_out =
  name >:: (fun ctxt -> 
      assert_equal ex_out (parse_jail str))

let buy_command_test name str ex_out =
  name >:: (fun ctxt -> 
      assert_equal ex_out (parse_buy str))

let command_tests = 
  [
    jail_command_test "Jail pay" "PAY" Pay;
    jail_command_test "Jail card" "CaRd" Card;
    jail_command_test "Jail roll" "ROll" Roll;
    (* jail_command_test "Jail command not" "Not" raise Malformed *)
    buy_command_test "Buy yes" "Yes" Yes;
    buy_command_test "Buy no" "NO" No;
  ]

let suite =
  "tests for CORNOPOLY" >::: List.flatten [
    player_tests;
    board_tests;
    space_tests;
    property_tests;
    penalty_tests;
  ]

let _ = run_test_tt_main suite