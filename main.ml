(** [main ()] prompts for the game to play, then starts it. *)

open Board 

let main () = 
  print_endline("Welcome to Cornopoly");
  print_endline("There are four players: Meghana, Michelle, Aaron, Amy. \
                 Here is the layout of the initial board: ");
  (* print_initial_board Player.playerlist; *)
  (*1. Print the inital board  - print eveery space: the id's, desciption, board price
     2. Player 1.name goes first*)
  match read_line () with
  | exception End_of_file -> ()
  | file_name -> failwith "hi"

(* Execute the game engine. *)
let () = main ()