type player

exception UnknownPlayer of string

val id: player -> int

val name: player -> string

val current_location_id: player -> int

val balance: player -> int

val property_list: player -> Space.property list

val jail_card : player-> bool

val change_jail_card: player -> bool -> player

val in_jail: player -> bool

val change_jail: player -> bool -> player

val set_location: player -> int -> player

val move: player -> int -> player

val move_to_space : player -> int -> player

val is_bankrupt: player -> bool

val update_balance : player -> int -> player

val add_property : player -> Space.property -> player

val remove_property: player -> Space.property -> player

val replace_player: player list -> player -> player list

val find_player: String.t -> player list -> player

val player1 : player

val player2 : player

val player3 : player

val player4 : player

val playerlist: player list

val remove_player: player -> player list -> player list


(* CAN BE DELETED LATER, USED FOR TESTING PURPOSES FOR NOW*)
(* val sample_player_test : player

   val player6 : player *)