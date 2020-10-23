(**The Space module represents a space/slot on the gameboard  *)
open Card

type property = {
  space_id: int;
  name : string;
  rent_price : float;
  owner : string;
  buy_price : float;
  color : string
}

let property_name property =
  property.name

let rent_price property =
  property.rent_price

let property_owner property =
  property.owner

let property_color property =
  property.color

let buy_price property =
  property.buy_price

type penalty = {
  space_id: int;
  name: string;
  description : string;
  penalty_price : float
}

type cardspace = {
  space_id: int;
  name: string;
}

type go = {
  space_id: int;
  name: string;
}

type justvisiting = {
  space_id: int;
  name: string;
}

type jail = {
  space_id: int;
  name: string;
}

type space = 
  | Property of property 
  | CardSpace of cardspace
  | Jail of jail
  | Penalty of penalty 
  | Go of go
  | JustVisiting of justvisiting

let space1 : space = Go {
    space_id = 1; 
    name = "Go";
  }

let space2 : space = Property { 
    space_id = 2;
    name = "Low Rise 5";
    rent_price = 20.0;
    owner = "";
    buy_price = 15.0;
    color = "green"
  }

let space3 : space = Property { 
    space_id = 3;
    name = "Donlon";
    rent_price = 24.0;
    owner = "";
    buy_price = 17.0;
    color = "green"
  }

let space4 : space = Property { 
    space_id = 4;
    name = "CKB";
    rent_price = 27.0;
    owner = "";
    buy_price = 20.0;
    color = "green"
  }

let space5 : space = Penalty { 
    space_id = 5;
    name = "Penalty";
    description = "Pay $30 for your Bursar Bill :(";
    penalty_price = 30.0
  }

let space6 : space = Property { 
    space_id = 6;
    name = "Klarman Hall";
    rent_price = 28.0;
    owner = "";
    buy_price = 24.0;
    color = "yellow"
  }

let space7 : space = Property { 
    space_id = 7;
    name = "Goldwin Smith Hall";
    rent_price = 28.0;
    owner = "";
    buy_price = 24.0;
    color = "yellow"
  }

let space8 : space = Property { 
    space_id = 8;
    name = "Cafe Jennie";
    rent_price = 29.0;
    owner = "";
    buy_price = 25.0;
    color = "yellow"
  }

let space9 : space = CardSpace { 
    space_id = 9;
    name = "Chance";
  }

let space10 : space = Jail {
    space_id = 10;
    name = "Jail"
  }

let space11 : space = Property { 
    space_id = 11;
    name = "Becker";
    rent_price = 30.0;
    owner = "";
    buy_price = 25.0;
    color = "orange"
  }

let space12 : space = Property { 
    space_id = 12;
    name = "Bethe";
    rent_price = 30.0;
    owner = "";
    buy_price = 25.0;
    color = "orange"
  }

let space13 : space = Property { 
    space_id = 13;
    name = "Baker Flagpole";
    rent_price = 32.0;
    owner = "";
    buy_price = 28.0;
    color = "orange"
  }

let space14 : space = Property { 
    space_id = 14;
    name = "Physical Sciences Buspace_idling";
    rent_price = 34.0;
    owner = "";
    buy_price = 30.0;
    color = "red"
  }

let space15 : space = CardSpace { 
    space_id = 15;
    name = "Chance";
  }

let space16 : space = Property { 
    space_id = 16;
    name = "Rockefeller Hall";
    rent_price = 35.0;
    owner = "";
    buy_price = 30.0;
    color = "red"
  }

let space17 : space = Property { 
    space_id = 17;
    name = "Baker Lab";
    rent_price = 35.0;
    owner = "";
    buy_price = 30.0;
    color = "red"
  }

let space18 : space = Penalty { 
    space_id = 18;
    name = "Penalty";
    description = "Flu season! Pay $40 for your flu shot";
    penalty_price = 40.0
  }

let space19 : space = Property { 
    space_id = 19;
    name = "Kennedy Hall";
    rent_price = 35.0;
    owner = "";
    buy_price = 30.0;
    color = "purple"
  }

let space20 : space = JustVisiting { 
    space_id = 20;
    name = "Just Visiting"
  }

let space21 : space = Property { 
    space_id = 21;
    name = "Malott Hall";
    rent_price = 37.0;
    owner = "";
    buy_price = 32.0;
    color = "purple"
  }

let space22 : space = Property { 
    space_id = 22;
    name = "Mann Library";
    rent_price = 38.0;
    owner = "";
    buy_price = 35.0;
    color = "purple"
  }


let space23 : space = Property { 
    space_id = 23;
    name = "Statler Hall";
    rent_price = 38.0;
    owner = "";
    buy_price = 35.0;
    color = "light blue"
  }


let space24 : space = Property { 
    space_id = 24;
    name = "Barton Hall";
    rent_price = 38.0;
    owner = "";
    buy_price = 35.0;
    color = "light blue"
  }

let space25 : space = Property { 
    space_id = 25;
    name = "Uris Hall";
    rent_price = 40.0;
    owner = "";
    buy_price = 35.0;
    color = "light blue"
  }

let space26 : space = CardSpace { 
    space_id = 26;
    name = "Chance";
  }


let space27 : space = Property { 
    space_id = 27;
    name = "Cornell Dairy";
    rent_price = 42.0;
    owner = "";
    buy_price = 37.0;
    color = "pink"
  }

let space28 : space = Property { 
    space_id = 28;
    name = "Botanical Gardens";
    rent_price = 42.0;
    owner = "";
    buy_price = 37.0;
    color = "pink"
  }

let space29 : space = Property { 
    space_id = 29;
    name = "Cow Land";
    rent_price = 42.0;
    owner = "";
    buy_price = 37.0;
    color = "pink"
  }


let space30 : space = Property { 
    space_id = 30;
    name = "Cornell Health";
    rent_price = 45.0;
    owner = "";
    buy_price = 38.0;
    color = "cyan"
  }


let space31 : space = Property { 
    space_id = 31;
    name = "McGraw Clock Tower";
    rent_price = 45.0;
    owner = "";
    buy_price = 38.0;
    color = "cyan"
  }

let space32 : space = Property { 
    space_id = 32;
    name = "Willard Straight Hall";
    rent_price = 50.0;
    owner = "";
    buy_price = 40.0;
    color = "cyan"
  }

let space33 : space = CardSpace { 
    space_id = 33;
    name = "Chance";
  }

let space34 : space = Property { 
    space_id = 34;
    name = "Hollister Hall";
    rent_price = 53.0;
    owner = "";
    buy_price = 40.0;
    color = "brown"
  }

let space35 : space = Property { 
    space_id = 35;
    name = "Duffield Hall";
    rent_price = 55.0;
    owner = "";
    buy_price = 40.0;
    color = "brown"
  }


let space36 : space = Penalty { 
    space_id = 36;
    name = "Penalty";
    description = "$60 Student activity fee...";
    penalty_price = 60.0
  }


let space37 : space = Property { 
    space_id = 37;
    name = "Rhodes Hall";
    rent_price = 60.0;
    owner = "";
    buy_price = 45.0;
    color = "brown"
  }

let space38 : space = Property { 
    space_id = 38;
    name = "Schwartz Center for the Performing Arts";
    rent_price = 70.0;
    owner = "";
    buy_price = 50.0;
    color = "blue"
  }

let space39 : space = Property { 
    space_id = 39;
    name = "Collegetown Bagels";
    rent_price = 100.0;
    owner = "";
    buy_price = 60.0;
    color = "blue"
  }

let spacelist : space list = [
  space1; space2; space3; space4; 
  space5; space6; space7; space8; space9; space10; space11; 
  space12; space13; space14; space15; space16; space17; space18; 
  space19; space20; space21; space22; space23; space24; space25; 
  space26; space27; space28; space29; space30; space31; space32; 
  space33; space34; space35; space36; space37; space38; space39; 
]