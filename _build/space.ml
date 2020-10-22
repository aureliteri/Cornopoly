(**The Space module represents a space on the gameboard  *)
type property = {
  description : string;
  rent_price : float;
  buy_price : float;
  color : string
}

type t = Property of property | CardSpace | Jail | Penalty | Go




