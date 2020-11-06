type amount = int

type action =
  | Change of amount
  | Move of amount

type card 

val empty : card

val card_id : card -> int 

val card_description : card -> string

val card_act : card -> action list

val choose : card list -> card

val card1: card

val card2: card

val card3: card

val card4: card

val card5: card

val card6: card

val card7: card

val card8: card

val card9: card

val card10: card

val cardlist: card array