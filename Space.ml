(**The Space module represents a space on the gameboard  *)
<<<<<<< HEAD

type t = {
=======
type property = {
>>>>>>> d4b7acbada1770f212da02ecd6cf9b790de946fc
  description : string;
  rent_price : float;
  buy_price : float;
  color : string
}

type t = Property of property | CardSpace | Jail | Penalty | Go




