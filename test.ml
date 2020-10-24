open OUnit2
open Board
open Player
open Space

(** [cmp_set_like_lists lst1 lst2] compares two lists to see whether
    they are equivalent set-like lists.  That means checking two things.
    First, they must both be {i set-like}, meaning that they do not
    contain any duplicates.  Second, they must contain the same elements,
    though not necessarily in the same order. *)
let cmp_set_like_lists lst1 lst2 =
  let uniq1 = List.sort_uniq compare lst1 in
  let uniq2 = List.sort_uniq compare lst2 in
  List.length lst1 = List.length uniq1
  &&
  List.length lst2 = List.length uniq2
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

let player_property_test name player expected_output = 
  let property_list = property_list player in 
  let string_property_list = property_name_printer property_list [] in
  name >:: (fun ctxt -> 
      assert_equal true 
        (cmp_set_like_lists expected_output (string_property_list)))

let sample_player = sample_player_test

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