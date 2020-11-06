
type property

val property_name : property -> string

val property_id : property -> int

val rent_price : property -> int

val property_owner : property -> string

val property_color : property -> string

val buy_price : property -> int

val change_owner: property -> string -> property

type penalty

val penalty_name : penalty -> string

val penalty_description : penalty -> string

val penalty_price : penalty -> int

type cardspace

type go

type justvisiting

type jail

type space = 
  | Property of property 
  | CardSpace of cardspace
  | Jail of jail
  | Penalty of penalty 
  | Go of go
  | JustVisiting of justvisiting

val space_name : space -> string

val space_id : space -> int

val get_property : space -> property 

val get_cardspace  : space -> cardspace

val get_jail : space -> jail

val get_go : space -> go

val get_penalty : space -> penalty

val get_justvisiting : space -> justvisiting

val space1: space
val space2: space
val space3: space
val space4: space
val space5: space
val space6: space
val space7: space
val space8: space
val space9: space
val space10: space
val space11: space
val space12: space
val space13: space
val space14: space
val space15: space
val space16: space
val space17: space
val space18: space
val space19: space
val space20: space
val space21: space
val space22: space
val space23: space
val space24: space
val space25: space
val space26: space
val space27: space
val space28: space
val space29: space
val space30: space
val space31: space
val space32: space
val space33: space
val space34: space
val space35: space
val space36: space
val space37: space
val space38: space
val space39: space

val spacelist: space list

val get_space : int -> space list ->space

