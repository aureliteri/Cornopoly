(* type mainboard *)

(** [roll_dice] is the result of rolling two 6-sided die.
    If the player rolls doubles they have to roll again. 
    If the player rolls doubles three times in a row, 
    the player is sent to jail and their turn ends. 
*)
val roll_dice: int -> (int * bool)



val buy_property : Command.buy_command ->
  Player.player -> Player.player list -> Space.space list -> Space.property-> Player.player list * Space.space list

val if_full_set : Player.player -> Space.property -> unit
(**[pick_card] is a random card selected from Card.cardlist. It takes in [x], 
   which is the length of cardlist *)
val pick_card : int -> Card.card 

val card_action : Card.action list -> Player.player -> Player.player
(** [iterate1 is a helper for play to return the updated playerlist and spacelist] *)
(* val iterate: Player.player list -> Space.space list 
   -> Player.player list * Space.space list -> Player.player list * Space.space list *)

(**[check_space] takes in the space, player, and board and pattern-matches 
   the type of space the player lands on, and updates the player information 
   and board depending on the type of space the player has landed on.
   Outputs: (updated player, updated board)*)
(* val check_space: Space.space -> Player.player -> Space.space list -> (Player.player *Space.space list)   *)
