(* type mainboard *)

val roll_dice: int

val pick_card: int -> Card.card 

val print_locations: Player.player list -> string -> string

val print_balances: Player.player list -> string -> string

val iterate: Player.player list -> Player.player list -> Player.player list

val update_board: Player.player list -> unit

val check_space: Space.space -> Player.player -> unit