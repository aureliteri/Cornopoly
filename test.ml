open OUnit2
open Board
open Player
open Space

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

let space_list = spacelist
let player_list = playerlist
let player1 = List.nth playerlist 0

let rec property_name_printer (property_list : Space.property list) (acc : string list) = 
  match property_list with
  | [] -> acc
  | h :: t -> property_name_printer t ((property_name h)::acc)

let current_location_test name player expected_output = 
  name >:: (fun ctxt -> 
      assert_equal expected_output (current_location_id player)~printer: string_of_int )

let player_name_test fun_name player expected_output = 
  fun_name >:: (fun ctxt -> 
      assert_equal expected_output (name player)~printer: String.escaped)

let player_balance_test name player expected_output = 
  name >:: (fun ctxt -> 
      assert_equal expected_output (balance player)~printer: string_of_int)

let update_balance_test name inplayer amount expected_output = 
  name >:: (fun ctxt -> 
      assert_equal expected_output (update_balance inplayer amount))

let player_property_test name player expected_output = 
  let property_list = property_list player in 
  let string_property_list = property_name_printer property_list [] in
  name >:: (fun ctxt -> 
      assert_equal true 
        (property_order expected_output (string_property_list)))

let sample_player = sample_player_test
let move_player_18 = move sample_player 7 
let move_player_wraparound_1 = move move_player_18 22
let move_player_wraparound_9 = move move_player_18 30
let go_twice = move move_player_wraparound_9 40
let player_6 = player6

let player_tests =
  [
    current_location_test "player1 curr loc id" player1 1;
    player_name_test "player1 name - Meghana" player1 "Meghana";
    player_balance_test "player1 initial balance" player1 1500;
    player_property_test "player1 intiial [] property" player1 [];
    current_location_test "sample player curr loc id" sample_player 11;
    player_name_test "sample player name - catpotato" sample_player "catpotato";
    player_balance_test "sample player balance" sample_player 400;
    player_property_test "sample player property" sample_player ["Donlon"; "Goldwin Smith Hall"; "Collegetown Bagels"];
    current_location_test "sample player moved 7 to 18" move_player_18 18;
    current_location_test "move function w/ mod wraparound" move_player_wraparound_1 1;
    current_location_test "move function w/ mod wraparound" move_player_wraparound_9 9;
    player_balance_test "move function w new GO balance" move_player_wraparound_1 600;
    player_balance_test "move function w new GO balance" move_player_wraparound_9 600;
    player_balance_test "Go twice" go_twice 800;
    current_location_test "go twice w/ mod wraparound" go_twice 10;

    update_balance_test "update balance negative number" player1 (-200) player_6;


  ]

let board_tests = 
  [

  ]

let suite =
  "tests for CORNOPOLY" >::: List.flatten [
    player_tests;
    board_tests;
  ]

let _ = run_test_tt_main suite