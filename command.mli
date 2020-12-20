(** Parses the player commands *)

(**[jail_command] is the type of command for a player who is currently
   in jail and is trying to exit the jail. *)
type jail_command = 
  | Pay 
  | Card 
  | Roll

(**[buy_command] is the type of command for a player who is deciding whether or 
   not to buy a property space *)
type buy_command = 
  | Yes 
  | No 

(**[board_choice] is the type of command for a player who is deciding whether or 
   not to play the classic board or a dark board *)
type board_choice = 
  | Dark
  | Classic


(** [Empty] is Raised when an empty command is parsed. *)
exception Empty

(** [Malformed] is Raised when a malformed or unrecognizable command is
    encountered. *)
exception Malformed

(**[parse_jail str] parses the player's input into a [jail_command].
   Raises: [Empty] if an empty command is encountered
   Raises: [Malformed] if an incorrect or a malformed command is parsed *)
val parse_jail : string -> jail_command

(**[parse_buy str] parses the player's input into a [jail_command].
   Raises: [Empty] if an empty command is encountered
   Raises: [Malformed] if an incorrect or a malformed command is parsed *)
val parse_buy : string -> buy_command

(**[parse_board_choice str] parses the player's input into a [board_choice].
   Raises: [Empty] if an empty command is encountered
   Raises: [Malformed] if an incorrect or a malformed command is parsed *)
val parse_board_choice: string -> board_choice

(**[parse_board_choice str] parses the player's input into an integer.
   Raises: [Empty] if an empty command is encountered
   Raises: [Malformed] if an incorrect or a malformed command is parsed *)
val parse_level_input : string -> int