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

(**[card21] is a unique chance card in the mystery card deck *)
val card21 : card

(**[card22] is a unique chance card in the mystery card deck *)
val card22 : card

(**[card23] is a unique chance card in the mystery card deck *)
val card23 : card

(**[card24] is a unique chance card in the mystery card deck *)
val card24 : card

(**[card25] is a unique chance card in the mystery card deck *)
val card25 : card

(**[card26] is a unique chance card in the mystery card deck *)
val card26 : card

(**[card27] is a unique chance card in the mystery card deck *)
val card27 : card

(**[card28] is a unique chance card in the mystery card deck *)
val card28 : card

(**[card29] is a unique chance card in the mystery card deck *)
val card29 : card

(**[card30] is a unique chance card in the mystery card deck *)
val card30 : card

(**[card31] is a unique chance card in the dark mystery card deck *)
val card31 : card

(**[card32] is a unique chance card in the dark mystery card deck *)
val card32 : card

(**[card33] is a unique chance card in the dark mystery card deck *)
val card33 : card

(**[card34] is a unique chance card in the dark mystery card deck *)
val card34 : card

(**[card35] is a unique chance card in the dark mystery card deck *)
val card35 : card

(**[card36] is a unique chance card in the dark mystery card deck *)
val card36 : card

(**[card37] is a unique chance card in the dark mystery card deck *)
val card37 : card

(**[card38] is a unique chance card in the dark mystery card deck *)
val card38 : card

(**[card39] is a unique chance card in the dark mystery card deck *)
val card39 : card

(**[card40] is a unique chance card in the dark mystery card deck *)
val card40 : card

(**[card41] is a unique chance card in the dark mystery card deck *)
val card41 : card

(**[card42] is a unique chance card in the dark mystery card deck *)
val card42 : card

(**[card43] is a unique chance card in the dark mystery card deck *)
val card43 : card

(**[card44] is a unique chance card in the dark mystery card deck *)
val card44 : card

(**[card45] is a unique chance card in the dark mystery card deck *)
val card45 : card

(**[card46] is a unique chance card in the dark mystery card deck *)
val card46 : card

(**[card47] is a unique chance card in the dark mystery card deck *)
val card47 : card

(**[card48] is a unique chance card in the dark mystery card deck *)
val card48 : card

(**[card49] is a unique chance card in the dark mystery card deck *)
val card49 : card

(**[card50] is a unique chance card in the dark mystery card deck *)
val card50 : card

(**[card51] is a unique chance card in the dark mystery card deck *)
val card51 : card

(**[card52] is a unique chance card in the dark mystery card deck *)
val card52 : card

(**[card53] is a unique chance card in the dark mystery card deck *)
val card53 : card

(**[card54] is a unique chance card in the dark mystery card deck *)
val card54 : card

(**[card55] is a unique chance card in the dark mystery card deck *)
val card55 : card

(**[card56] is a unique chance card in the dark mystery card deck *)
val card56 : card

(**[card57] is a unique chance card in the dark mystery card deck *)
val card57 : card

(**[card58] is a unique chance card in the dark mystery card deck *)
val card58 : card

(**[card59] is a unique chance card in the dark mystery card deck *)
val card59 : card

(**[card60] is a unique chance card in the dark mystery card deck *)
val card60 : card

(** [cardlist] is the mystery card deck made of chance cards for the 
    Classic board.*)
val cardlist: card array

(** [cardlist] is the mystery card deck made of dark chance cards for the 
    Dark board.*)
val cardlist_dark: card array