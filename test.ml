open OUnit2
open Board
open Player
open Space

let space_list = spacelist
let player_list = playerlist
let player1 = List.nth playerlist 1

let current_location_test name player expected_output = 
  name >:: (fun ctxt -> 
      assert_equal expected_output (current_location_id player) ~printer:string_of_int )

let player_tests =
  [
    current_location_test "player1 curr loc id" player1 1;
  ]

let board_tests = 
  [

  ]

let suite =
  "tests for CORNOPOLY" >::: List.flatten [
    player_tests;
    board_tests;
  ]
