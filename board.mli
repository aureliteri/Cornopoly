(* type mainboard *)

(** [roll_dice] is the result of rolling two 6-sided die.
    If the player rolls doubles they have to roll again. 
    If the player rolls doubles three times in a row, 
    the player is sent to jail and their turn ends. 
*)
val roll_dice: int -> (int * bool)

(**[pick_card] is a random card selected from Card.cardlist. It takes in [x], 
   which is the length of cardlist *)
(* val pick_card: int -> Card.card  *)

(**[print_locations] prints the current locations of all of the players  *)
val print_locations: Player.player list -> string -> string

(**[print_balances] prints the current balances of all of the players  *)
val print_balances: Player.player list -> string -> string

(**[iterate playerlist] is the updated [playerlist] after each player runs through 
   their turn in the game. The die are rolled for each player and they are each 
   moved to new spaces according to die roll result. Each player will undergo 
   specific actions according to the space they land on *)
val iterate: Player.player list -> Player.player list -> Space.space list 
  -> Player.player list

(** [iterate1 is a helper for play to return the updated playerlist and spacelist] *)
val iterate1: Player.player list -> Space.space list 
  -> Player.player list * Space.space list -> Player.player list * Space.space list

(**[update_board] displays the players' current locations and balances after a turn*)
val update_board: Player.player list -> unit

(** [print_players] iterates through the [playerlist] and displays 
    the players'ID, balance, current location, and properties *)  
val print_players : Player.player list -> unit 

(** [print_initial_board] prints out the initial board that is to be 
    implemented at the beginning of the game when no changes have been made,
    by taking in [spacelist] and [playerlist] *)
val print_initial_board : Space.space list -> Player.player list -> unit

(**[check_space] takes in the space, player, and board and pattern-matches 
   the type of space the player lands on, and updates the player information 
   and board depending on the type of space the player has landed on.
   Outputs: (updated player, updated board)*)
val check_space: Space.space -> Player.player -> Space.space list -> (Player.player *Space.space list)  
