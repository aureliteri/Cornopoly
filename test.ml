open OUnit2
open Board
open Player
open Space

let space_list = spacelist
let player_list= playerlist

let player_tests =
  [

  ]

let it_1_player0 = check_space (List.nth space_list 2) (List.nth player_list 0)
let it_2_player1 = 

  let check_space_test name space player result =
    name >:: fun ctxt -> 
      let play = check_space space player in


      let board_tests = 
        [
          assert_equal "Test1" (List.nth space_list 2) (List.nth player_list 0) ; 
        ]


let suite =
  "tests for CORNOPOLY" >::: List.flatten [
    player_tests;
    board_tests;
  ]
