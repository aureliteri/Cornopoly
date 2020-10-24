open OUnit2
open Board
open Player
open Space

let space_list = spacelist
let player_list = playerlist

let first_player = List.nth playerlist 0




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
