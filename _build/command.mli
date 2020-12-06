
type jail_command = 
  | Pay | Card | Roll

type buy_command = 
  | Yes | No 

(** Raised when an empty command is parsed. *)
exception Empty

(** Raised when a malformed command is encountered. *)
exception Malformed

val parse_jail : string -> jail_command

val parse_buy : string -> buy_command