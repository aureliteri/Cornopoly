(**The Space module represents a space/slot on the gameboard  *)

open Card

type property = {
  description : string;
  rent_price : float;
  owner : string;
  buy_price : float;
  color : string
}

type penalty = {
  description : string;
  penalty_price : float
}

type space = 
  | Property of property 
  | CardSpace of Card.card
  | Jail 
  | Penalty of penalty 
  | Go