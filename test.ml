open OUnit2
open Board
open Player
open Space



let player_tests =
  [

  ]

let board_tests = 
  [

  ]

let suite =
  "tests for CORNOPOLY" >::: List.flatten [
    player_tests;
    board_tests;
  ]
