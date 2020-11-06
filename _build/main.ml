(** [main ()] prompts for the game to play, then starts it. *)

open Board 

let main () = 
  print_endline("Welcome to Cornopoly");
  print_endline("There are four players: Meghana, Michelle, Aaron, Amy. \
                 Here is the layout of the initial board: ");

  print_initial_board Space.spacelist Player.playerlist;
  let rec play s player_lst : unit= 
    match s with
    | "quit" -> exit 0;
    | _ -> begin
        print_players player_lst;
        let new_lst = List.rev(iterate player_lst []) in
        update_board new_lst;
        print_endline "Type quit to quit. Type anything else to continue.";
        let s = read_line() in
        play s new_lst;
      end
  in
  print_endline "Type quit to quit. Type anything else to play.";
  let s = read_line() in
  play s Player.playerlist;


  (*1. Print the inital board  - print eveery space: the id's, desciption, board price
     2. Player 1.name goes first*)


  match read_line () with
  | exception End_of_file -> ()
  | file_name -> failwith "hi"

(* Execute the game engine. *)
let () = main ()