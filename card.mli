(** Builds the mystery card deck *)


(** [action] represents a card command that is decomposed into a command 
    and either a relating amount (int) or bool*)
type action =
  | Change of int
  | Move of int
  | Get_out of bool

(**[card] is the type of indivdual card in the card deck*)
type card 

(**[empty] is the empty card (for testing) *)
val empty : card

(**[card_id card] is the id number for a specific card *)
val card_id : card -> int 

(** [card_description card] is a string describing the action of the card*)
val card_description : card -> string

(** [card_act card] is a list of actions that the chance card can enact*)
val card_act : card -> action list

(** [choose cardList] is the first card in the deck of cards*)
val choose : card list -> card

(**[card1] is a unique chance card in the mystery card deck *)
val card1 : card

(**[card2] is a unique chance card in the mystery card deck *)
val card2 : card

(**[card3] is a unique chance card in the mystery card deck *)
val card3 : card

(**[card4] is a unique chance card in the mystery card deck *)
val card4 : card

(**[card5] is a unique chance card in the mystery card deck *)
val card5 : card

(**[card6] is a unique chance card in the mystery card deck *)
val card6 : card

(**[card7] is a unique chance card in the mystery card deck *)
val card7 : card

(**[card8] is a unique chance card in the mystery card deck *)
val card8 : card

(**[card9] is a unique chance card in the mystery card deck *)
val card9 : card

(**[card10] is a unique chance card in the mystery card deck *)
val card10 : card

(**[card11] is a unique chance card in the mystery card deck *)
val card11 : card

(**[card12] is a unique chance card in the mystery card deck *)
val card12 : card

(**[card13] is a unique chance card in the mystery card deck *)
val card13 : card

(**[card14] is a unique chance card in the mystery card deck *)
val card14 : card

(**[card15] is a unique chance card in the mystery card deck *)
val card15 : card

(**[card16] is a unique chance card in the mystery card deck *)
val card16 : card

(**[card17] is a unique chance card in the mystery card deck *)
val card17 : card

(**[card18] is a unique chance card in the mystery card deck *)
val card18 : card

(**[card19] is a unique chance card in the mystery card deck *)
val card19 : card

(**[card20] is a unique chance card in the mystery card deck *)
val card20 : card

(** [cardlist] is the mystery card deck made of chance cards*)
val cardlist: card array