(** Represents the game board of Cornopoly.*)

(** [roll_dice int] is the result of rolling two [int]-sided die. The result is 
    a tuple containing 1. the sum of the two [int]-sided die and 2. whether the 
    two die were identical (true) of different values (false).
    If the player rolls doubles they have to roll again. 
    If the player rolls doubles three times in a row, 
    the player is sent to jail and their turn ends. *)
val roll_dice: int -> (int * bool)

(** [buy_property command player playerList board property] is the tuple of 
    the updated [playerList] and [board] given from the player
    command [command] which may change the player [player]'s [proper] *)
(* val buy_property : Command.buy_command ->
  Player.player -> Player.player list -> Space.space list ->
  Space.property-> Player.player list * Space.space list *)

val try_command_property : string ->
  Player.player -> Player.player list -> Space.space list ->
  Space.property-> Player.player list * Space.space list

val buy_off_someone : 

  (* Command.buy_command ->
     Player.player -> Player.player list -> Space.space list ->
     Space.property-> int -> int -> Player.player list * Space.space list *)
  Command.buy_command ->
  Player.player ->
  Player.player list ->
  Space.space list ->
  Space.property -> int -> int -> Player.player list * Space.space list

(** [level_up_prop command player playerList board property] is the tuple of 
    the updated [playerList] and [board] given from the player
    command [command] which may change the player [player]'s [propery]*)
val level_up_prop : Command.buy_command ->
  Player.player -> Player.player list -> Space.space list ->
  Space.property-> Player.player list * Space.space list

(** [if_full_set player property_just_bought] checks if [player] possesses 
a full color set of properties and terminates the game if they do with 
the end game string. If [player] does not have a full color set, 
[if_full_set player] prints "" *)
val if_full_set : Player.player -> Space.property -> unit

(**[pick_card] is a random card selected from Card.cardlist. It takes in [x], 
   which is the length of cardlist *)
val pick_card : int -> Card.card 

(** [card_action act_lst player] takes in a list of commands in [act_lst] 
    and applies them to [player] then returns the updated player *)
val card_action : Card.action list -> Player.player -> Player.player



(** [if_full_set_test_helper player property_just_bought] checks if [player] possesses a full color set of 
    properties and returns true or false *)
val if_full_set_test_helper: Player.player -> Space.property -> bool