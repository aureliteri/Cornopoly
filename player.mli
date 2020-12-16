
(**Representation of a player in the Cornolpoly game *)

(**[player] is the type of a single player *)
type player
(**[UnknownPlayer] is raised when an unknown player is encountered *)
exception UnknownPlayer of string

(**[id player] is the id of a specific player *)
val id: player -> int

(**[name player] is the name of a specific player *)
val name: player -> string

(**[current_location_id player] is the space id of where the player is currently
   located at. *)
val current_location_id: player -> int

(**[balance player] is the amount of money in the player's current balance. *)
val balance: player -> int

(**[property_list player] is the list of property the player currently owns.*)
val property_list: player -> Space.property list

(**[jail_card player] is true if the player currenlty has a "get out jail for
   free" card. It is false if the player does not own that specific card. *)
val jail_card : player-> bool

(**[change_jail_card player value] is a new player with the jail_card 
   attribute set to value  *)
val change_jail_card: player -> bool -> player

(**[in_jail player] is true if the player is currently in jail and false
   the player is not currently in jail. *)
val in_jail: player -> bool

(**[change_jail player value] is a new player with the in_jail 
   attribute set to value *)
val change_jail: player -> bool -> player

(**[set_location player location_id] is a new player with
   the current_location_id attribute set to [location_id]. 
   [location_id] represents the new space id of the players new location. *)
val set_location: player -> int -> player

(**[move player int'] is the new player with their current_location_id updated
   after moving [int'] number of spaces.*)
val move: player -> int -> player

(**[move_to_space player int'] is the new player with their current_location_id
   updated after moving to a specific space.*)
val move_to_space : player -> int -> player

(**[is_bankrupt player] is true if the player's current balance is <= 0.
   It is false otherwise. *)
val is_bankrupt: player -> bool

(**[update_name player new_name] is the player with their name updated to
   [new_name] *)
val update_name : player -> string -> player

(**[updated_balance player amount] is the player with their current balance 
   updated to [amount] *)
val update_balance : player -> int -> player

(**[add_property player property] is the player with an updated property list 
   that includes [property].  *)
val add_property : player -> Space.property -> player

(**[remove_propert player property] is the player with an updated property 
   list with [property] removed from it *)
val remove_property: player -> Space.property -> player

(**[replace_player playerList new_player] replaces a player already in
   [playerList] with [new_player].
   Requires: [new_player] must have the same id as a single player 
   in [playerlist].*)
val replace_player: player list -> player -> player list

(** [find_player find playerList] is a player with name [find] in [playerList].
    Raises: Unknownplayer if the player with name [find] does not exist in
    [playerList]*)
val find_player: String.t -> player list -> player

(**[player1] is a player in the game. *)
val player1 : player

(**[player2] is a player in the game. *)
val player2 : player

(**[player3] is a player in the game. *)
val player3 : player

(**[player4] is a player in the game. *)
val player4 : player

(**[sample_player] is a sample player used for testing *)
val sample_player : player

(**[playerlist] is the list of player in the game. *)
val playerlist: player list

(**[remove_player player plist] is the same list of players as [plist] except 
   with [player] removed.*)
val remove_player: player -> player list -> player list


(* CAN BE DELETED LATER, USED FOR TESTING PURPOSES FOR NOW*)
(* val sample_player_test : player *)
(* val player6 : player *)