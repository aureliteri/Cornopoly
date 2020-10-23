(**The Space module represents a space/slot on the gameboard  *)

open Card

type property = {
  id: int;
  description : string;
  rent_price : float;
  owner : string;
  buy_price : float;
  color : string
}

type penalty = {
  id: int;
  description : string;
  penalty_price : float
}

type cardspace = {
  id: int;
  card_description : string;
}

type go = {
  id: int;
  description: string;
}

type justvisiting = {
  id: int;
  visiting: string;
}


type space = 
  | Property of property 
  | CardSpace of Card.card
  | Jail 
  | Penalty of penalty 
  | Go
  | JustVisiting 

let space1 = {id = 1; description = "Go";}
let space2 = { 
  id = 2;
  description = "Low Rise 5";
  rent_price = 20.0;
  owner = "";
  buy_price = 15.0;
  color = "green"
}

let space3 = { 
  id = 3;
  description = "Donlon";
  rent_price = 24.0;
  owner = "";
  buy_price = 17.0;
  color = "green"
}

let space4 = { 
  id = 4;
  description = "CKB";
  rent_price = 27.0;
  owner = "";
  buy_price = 20.0;
  color = "green"
}

let space5 = { 
  id = 5;
  description = "Pay your Bursar bill :(";
  penalty_price = 30.0
}

let space6 = { 
  id = 6;
  description = "Klarman Hall";
  rent_price = 28.0;
  owner = "";
  buy_price = 24.0;
  color = "yellow"
}

let space7 = { 
  id = 7;
  description = "Goldwin Smith Hall";
  rent_price = 28.0;
  owner = "";
  buy_price = 24.0;
  color = "yellow"
}

let space8 = { 
  id = 8;
  description = "Cafe Jennie";
  rent_price = 29.0;
  owner = "";
  buy_price = 25.0;
  color = "yellow"
}

let space9 = { 
  id = 9;
  card_description = "CHANCE";
}

let space10 = Jail 

let space11 = { 
  id = 11;
  description = "Becker";
  rent_price = 30.0;
  owner = "";
  buy_price = 25.0;
  color = "orange"
}

let space12 = { 
  id = 12;
  description = "Bethe";
  rent_price = 30.0;
  owner = "";
  buy_price = 25.0;
  color = "orange"
}

let space13 = { 
  id = 13;
  description = "Baker Flagpole";
  rent_price = 32.0;
  owner = "";
  buy_price = 28.0;
  color = "orange"
}

let space14 = { 
  id = 14;
  description = "Physical Sciences Buidling";
  rent_price = 34.0;
  owner = "";
  buy_price = 30.0;
  color = "red"
}

let space15 = { 
  id = 15;
  card_description = "CHANCE";
}

let space16 = { 
  id = 16;
  description = "Rockefeller Hall";
  rent_price = 35.0;
  owner = "";
  buy_price = 30.0;
  color = "red"
}

let space17 = { 
  id = 17;
  description = "Baker Lab";
  rent_price = 35.0;
  owner = "";
  buy_price = 30.0;
  color = "red"
}

let space18 = { 
  id = 18;
  description = "Flu season! Pay for your flu shot";
  penalty_price = 40.0
}

let space19 = { 
  id = 19;
  description = "Kennedy Hall";
  rent_price = 35.0;
  owner = "";
  buy_price = 30.0;
  color = "purple"
}
