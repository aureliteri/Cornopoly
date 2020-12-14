(**The Space module represents a space/slot on the gameboard  *)

(** [property] is a unique type of a property on the board*)
type property

(** [property_name property] is the name [name] of [property]*)
val property_name : property -> string

(** [property_id property] is the numberic identifier [space_id] of [property] *)
val property_id : property -> int

(** [rent_price property] is the amount of rent [rent_price] associated with [property] *)
val rent_price : property -> int

(** [property_owner property] is the name of the owner [owner] of [property] *)
val property_owner : property -> string

(** [property_color property] is the colorset of [property] *)
val property_color : property -> string

(** [buy_price property] is the amount that a player can buy [property] for*)
val buy_price : property -> int

(** [change_owner property new_owner] is a [property] with the new owner 
    name [new_owner] associated with it*)
val change_owner: property -> string -> property

(** [penalty] is a unique space of type penalty*)
type penalty

(** [penalty_name penalty] is the name of the penalty space [penalty]*)
val penalty_name : penalty -> string

(** [penalty_description penalty] is the description of [penalty] *)
val penalty_description : penalty -> string

(** [penalty_price penalty] is the amount to be deducted of space [penalty]*)
val penalty_price : penalty -> int

(** [cardspace] is the unique type of the card space where the player can 
    recieve a mystery card*)
type cardspace

(** [go] is unique type of the starting space on the game board and every time
    a player passes this space they revieve a constant amount of money *)
type go

(** [justvisiting] is the unique type of the visiting space on the game board*)
type justvisiting

(** [jail] is the unique jail space on the game board*)
type jail

(** [space] is the type of an individual space on the game board*)
type space = 
  | Property of property 
  | CardSpace of cardspace
  | Jail of jail
  | Penalty of penalty 
  | Go of go
  | JustVisiting of justvisiting

(** [space_name space] is the string name associated with [space]*)
val space_name : space -> string

(** [space_id space] is the unique identifying integer of [space] *)
val space_id : space -> int

(** [get_property space] identifies the property type of [space] *)
val get_property : space -> property 

(** [get_cardspace space] identifies the card type of [space]*)
val get_cardspace  : space -> cardspace

(** [get_jail space] identifies the jail type of [space]*)
val get_jail : space -> jail

(** [get_go space] identifies the go type of [space]*)
val get_go : space -> go

(** [get_penalty space] identifies the penalty type of [space]*)
val get_penalty : space -> penalty

(** [get_justvisting space] identifies the justvisiting type of [space]*)
val get_justvisiting : space -> justvisiting

(** [space1] is the unique space in the board that is of type go *)
val space1: space

(** [space2] is the unique space in the board that is of type property *)
val space2: space

(** [space3] is the unique space in the board that is of type property *)
val space3: space

(** [space4] is the unique space in the board that is of type property *)
val space4: space

(** [space5] is the unique space in the board that is of type penalty *)
val space5: space

(** [space6] is the unique space in the board that is of type property *)
val space6: space

(** [space7] is the unique space in the board that is of type property *)
val space7: space

(** [space8] is the unique space in the board that is of type property *)
val space8: space

(** [space9] is the unique space in the board that is of type card *)
val space9: space

(** [space10] is the unique space in the board that is of type jail *)
val space10: space

(** [space11] is the unique space in the board that is of type property *)
val space11: space

(** [space12] is the unique space in the board that is of type property *)
val space12: space

(** [space13] is the unique space in the board that is of type property *)
val space13: space

(** [space14] is the unique space in the board that is of type property *)
val space14: space

(** [space15] is the unique space in the board that is of type card *)
val space15: space

(** [space16] is the unique space in the board that is of type property *)
val space16: space

(** [space17] is the unique space in the board that is of type property *)
val space17: space

(** [space18] is the unique space in the board that is of type penalty *)
val space18: space

(** [space19] is the unique space in the board that is of type property *)
val space19: space

(** [space20] is the unique space in the board that is of type justvisiting *)
val space20: space

(** [space21] is the unique space in the board that is of type property *)
val space21: space

(** [space22] is the unique space in the board that is of type property *)
val space22: space

(** [space23] is the unique space in the board that is of type property *)
val space23: space

(** [space24] is the unique space in the board that is of type property *)
val space24: space

(** [space25] is the unique space in the board that is of type property *)
val space25: space

(** [space26] is the unique space in the board that is of type card *)
val space26: space

(** [space27] is the unique space in the board that is of type property *)
val space27: space

(** [space28] is the unique space in the board that is of type property *)
val space28: space

(** [space29] is the unique space in the board that is of type property *)
val space29: space

(** [space30] is the unique space in the board that is of type property *)
val space30: space

(** [space31] is the unique space in the board that is of type property *)
val space31: space

(** [space32] is the unique space in the board that is of type property *)
val space32: space

(** [space33] is the unique space in the board that is of type card *)
val space33: space

(** [space34] is the unique space in the board that is of type property *)
val space34: space

(** [space35] is the unique space in the board that is of type property *)
val space35: space

(** [space36] is the unique space in the board that is of type penalty *)
val space36: space

(** [space37] is the unique space in the board that is of type property *)
val space37: space

(** [space38] is the unique space in the board that is of type property *)
val space38: space

(** [space39] is the unique space in the board that is of type property *)
val space39: space


(** [spacelist] is the board composed of spaces *)
val spacelist: space list

(** [get_space id spacelst] is the unique space from the [spacelst] associated 
    with the integer identifier [id] *)
val get_space : int -> space list ->space

