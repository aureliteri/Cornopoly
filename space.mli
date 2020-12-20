(**The Space module represents a space/slot on the gameboard  *)

(** [property] is a unique type of a property on the board*)
type property

(** [property_name property] is the name [name] of [property]*)
val property_name : property -> string

(** [property_level property] is the level [l] of [property]*)
val property_level : property -> int

(** [property_id property] is the numberic identifier [space_id] of [property] *)
val property_id : property -> int

(** [rent_price property] is the amount of rent [rent_price] associated with [property] *)
val rent_price : property -> int array

(** [property_owner property] is the name of the owner [owner] of [property] *)
val property_owner : property -> string

(** [property_color property] is the colorset of [property] *)
val property_color : property -> string

(** [buy_price property] is the amount that a player can buy [property] for*)
val buy_price : property -> int array

(** [change_level property new_level] is a [property] with the new owner 
    [new_level] associated with it*)
val change_level: property -> int -> property

(**[get_level_price] returns the level price from a property *)
val get_level_price : property -> int

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

(** [card_name chance] is the name [name] of [chance]*)
val card_name : cardspace -> string


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

(** [get_penalty space] identifies the penalty type of [space]*)
val get_penalty : space -> penalty

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

(**[property1] is the property associated with space 2 *)
val property1 : property

(** [spacelist] is the board composed of spaces 1-39 *)
val spacelist: space list

(** [get_space id spacelst] is the unique space from the [spacelst] associated 
    with the integer identifier [id] 
    Requires: [id] belongs to a space already in [spacelst]. *)
val get_space : int -> space list ->space

(** [space41] is the unique space in the dark board that is of type go *)
val space41: space

(** [space42] is the unique space in the dark board that is of type property *)
val space42: space

(** [space43] is the unique space in the dark board that is of type property *)
val space43: space

(** [space44] is the unique space in the dark board that is of type property *)
val space44: space

(** [space45] is the unique space in the dark board that is of type penalty *)
val space45: space

(** [space46] is the unique space in the dark board that is of type property *)
val space46: space

(** [space47] is the unique space in the dark board that is of type property *)
val space47: space

(** [space48] is the unique space in the dark board that is of type property *)
val space48: space

(** [space49] is the unique space in the dark board that is of type card *)
val space49: space

(** [space50] is the unique space in the dark board that is of type jail *)
val space50: space

(** [space51] is the unique space in the dark board that is of type property *)
val space51: space

(** [space52] is the unique space in the dark board that is of type property *)
val space52: space

(** [space53] is the unique space in the dark board that is of type property *)
val space53: space

(** [space54] is the unique space in the dark board that is of type property *)
val space54: space

(** [space55] is the unique space in the dark board that is of type card *)
val space55: space

(** [space56] is the unique space in the dark board that is of type property *)
val space56: space

(** [space57] is the unique space in the dark board that is of type property *)
val space57: space

(** [space58] is the unique space in the dark board that is of type penalty *)
val space58: space

(** [space59] is the unique space in the dark board that is of type property *)
val space59: space

(** [space60] is the unique space in the dark board that is of type justvisiting *)
val space60: space

(** [space61] is the unique space in the dark board that is of type property *)
val space61: space

(** [space62] is the unique space in the dark board that is of type property *)
val space62: space

(** [space63] is the unique space in the dark board that is of type property *)
val space63: space

(** [space64] is the unique space in the dark board that is of type property *)
val space64: space

(** [space65] is the unique space in the dark board that is of type property *)
val space65: space

(** [space66] is the unique space in the dark board that is of type card *)
val space66: space

(** [space67] is the unique space in the dark board that is of type property *)
val space67: space

(** [space68] is the unique space in the dark board that is of type property *)
val space68: space

(** [space69] is the unique space in the dark board that is of type property *)
val space69: space

(** [space70] is the unique space in the dark board that is of type property *)
val space70: space

(** [space71] is the unique space in the dark board that is of type property *)
val space71: space

(** [space72] is the unique space in the dark board that is of type property *)
val space72: space

(** [space73] is the unique space in the dark board that is of type card *)
val space73: space

(** [space74] is the unique space in the dark board that is of type property *)
val space74: space

(** [space75] is the unique space in the dark board that is of type property *)
val space75: space

(** [space76] is the unique space in the dark board that is of type penalty *)
val space76: space

(** [space77] is the unique space in the dark board that is of type property *)
val space77: space

(** [space78] is the unique space in the dark board that is of type property *)
val space78: space

(** [space79] is the unique space in the dark board that is of type property *)
val space79: space

(** [spacelist_dark] is the dark board composed of spaces 41-79 *)
val spacelist_dark : space list 