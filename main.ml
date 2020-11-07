(** [main ()] prompts for the game to play, then starts it. *)

open Board 
open Player
open Space
open Card

let rec print_locations playerlist acc = 
  match playerlist with
  | [] -> acc
  | h :: t -> 
    let player_location = space_name (get_space (current_location_id h) spacelist) in
    let complete_string = name h ^ " is currently at " ^ player_location ^ ".\n" in
    print_locations t (acc ^ complete_string)

let rec print_balances playerlist acc = 
  match playerlist with
  | [] -> acc
  | h :: t -> 
    let player_balance = string_of_int (balance h) in
    let complete_string = name h ^ " currently has a balance of $" ^ player_balance ^ ".\n" in
    print_balances t (acc ^ complete_string )

let rec print_properties (properties : property list) : unit = 
  match properties with
  | [] -> print_endline ""
  | h :: t -> 
    print_endline ("Name: " ^ property_name h);
    print_endline ("ID: " ^ string_of_int (property_id h));
    print_endline ("Color: " ^ property_color h);
    print_endline ("Rent Price: $" ^ string_of_int (rent_price h)^"\n");
    print_properties t 

(** get space is using Space.spacelist *)
let rec print_players players = 
  match players with
  | [] -> print_endline ""
  | h :: t -> let p_id = string_of_int (id h) in 
    let p_name = name h in 
    let p_current_loc = space_name (get_space (current_location_id h) spacelist) in 
    let p_balance = string_of_int (balance h )in 
    let p_properties = property_list h in 
    print_endline ("\n"^ p_name ^ "'s ID is " ^p_id ^ " and their current location is " ^ p_current_loc ^ ". Their balance is $" ^p_balance^ "." ^ " Their properties are:");
    print_properties p_properties;
    print_players t

let print_initial_board (spaces : space list) (player : player list) : unit = 
  let rec print_spaces lst = 
    match lst with
    | [] -> print_endline ""
    | h :: t -> let id = space_id h in 
      print_endline ((string_of_int id ) ^ ". " ^ space_name h); 
      print_spaces t
  in print_spaces spaces

let update_board playerlist  =
  print_endline ("\n"^print_locations playerlist "");
  print_endline (print_balances playerlist "") 

let main () = 
  print_endline("Welcome to Cornopoly");
  print_endline("There are four players: Meghana, Michelle, Aaron, Amy. \
                 Here is the layout of the initial board: ");

  print_initial_board Space.spacelist Player.playerlist;
  let rec play s player_lst space_lst : unit = 
    match s with
    | "quit" -> exit 0;
    | _ -> begin
        print_players player_lst;
        let new_lst = iterate player_lst space_lst ([], []) in
        let pl_lst = List.rev (fst new_lst) in
        update_board pl_lst;
        print_endline "Type quit to quit. Type anything else to continue.";
        let s = read_line() in
        play s pl_lst (snd new_lst);
      end
  in
  print_endline "Type quit to quit. Type anything else to play.";
  let s = read_line() in
  play s Player.playerlist Space.spacelist;


  (*1. Print the inital board  - print eveery space: the id's, desciption, board price
     2. Player 1.name goes first*)


  match read_line () with
  | exception End_of_file -> ()
  | file_name -> failwith "hi"

(* Execute the game engine. *)
let () = main ()