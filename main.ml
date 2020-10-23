(** [main ()] prompts for the game to play, then starts it. *)

open Board 

let main () =
  print_endline("Welcome to Cornopoly");
  print_endline("There are four players: Meghana, Michelle, Aaron, Amy");



  (* match read_line () with
     | exception End_of_file -> ()
     | file_name -> play_game file_name *)

  (* Execute the game engine. *)
  let _ = main ()