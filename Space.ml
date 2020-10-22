(**The Space module represents a space/slot on the gameboard  *)
type property = {
  description : string;
  rent_price : float;
  buy_price : float;
  color : string
}

type penalty = {
  description : string;
  penalty_price : float
}

type cardS = {
  name : string;
  card : string (*This field should be of TYPE CARD [Card.t] *)
}

type t = Property of property | CardSpace of cardS | 
         Jail | Penalty of penalty | Go

