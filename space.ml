open Card

type property = {
  space_id: int;
  name : string;
  rent_price : int;
  owner : string;
  buy_price : int;
  color : string
}

let property_name property = property.name

let property_id property = property.space_id

let rent_price property = property.rent_price

let property_owner property = property.owner

let property_color property = property.color

let buy_price property = property.buy_price

let change_owner property new_owner = 
  {property with owner=new_owner}


type penalty = {
  space_id: int;
  name: string;
  description : string;
  penalty_price : int
}

let penalty_name penalty = penalty.name

let penalty_description penalty = penalty.description

let penalty_price penalty = penalty.penalty_price

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

(*[space_name] returns the name of the space depending on what type it is
  eg. property, cardspace, jail...*)
let space_name = function
  | Property property -> property.name
  | CardSpace cardspace -> cardspace.name
  | Jail jail -> jail.name
  | Penalty penalty -> penalty.name
  | Go go -> go.name
  | JustVisiting justvisiting -> justvisiting.name

let space_id = function
  | Property property -> property.space_id
  | CardSpace cardspace -> cardspace.space_id
  | Jail jail -> jail.space_id
  | Penalty penalty -> penalty.space_id
  | Go go -> go.space_id
  | JustVisiting justvisiting -> justvisiting.space_id

let get_property = function
  | Property property -> property 
  | _ -> failwith "Not a Property"

let get_cardspace  = function 
  | CardSpace cardspace -> cardspace
  | _ -> failwith "Not a Cardspace"

let get_jail = function
  | Jail jail -> jail 
  | _ -> failwith "Not a Jail space"

let get_go = function
  | Go go -> go
  | _ -> failwith "Not a Go space"

let get_penalty = function
  | Penalty penalty -> penalty
  | _ -> failwith "Not a penalty"

let get_justvisiting = function
  | JustVisiting justvisiting -> justvisiting
  | _ -> failwith "Not a JustVisiting space"

let space1 : space = Go {
    space_id = 1; 
    name = "Go";
  }


let space2 : space = Property { 
    space_id = 2;
    name = "Low Rise 5";
    rent_price = 20;
    owner = "";
    buy_price = 15;
    color = "green"
  }

let space3 : space = Property { 
    space_id = 3;
    name = "Donlon";
    rent_price = 24;
    owner = "";
    buy_price = 17;
    color = "green"
  }

let space4 : space = Property { 
    space_id = 4;
    name = "CKB";
    rent_price = 27;
    owner = "";
    buy_price = 20;
    color = "green"
  }

let space5 : space = Penalty { 
    space_id = 5;
    name = "Penalty";
    description = "Pay $30 for your Bursar Bill :(";
    penalty_price = 30
  }

let space6 : space = Property { 
    space_id = 6;
    name = "Klarman Hall";
    rent_price = 28;
    owner = "";
    buy_price = 24;
    color = "yellow"
  }

let space7 : space = Property { 
    space_id = 7;
    name = "Goldwin Smith Hall";
    rent_price = 28;
    owner = "";
    buy_price = 24;
    color = "yellow"
  }

let space8 : space = Property { 
    space_id = 8;
    name = "Cafe Jennie";
    rent_price = 29;
    owner = "";
    buy_price = 25;
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
    name = "Becker Hall";
    rent_price = 30;
    owner = "";
    buy_price = 25;
    color = "orange"
  }

let space12 : space = Property { 
    space_id = 12;
    name = "Bethe Hall";
    rent_price = 30;
    owner = "";
    buy_price = 25;
    color = "orange"
  }

let space13 : space = Property { 
    space_id = 13;
    name = "Baker Flagpole";
    rent_price = 32;
    owner = "";
    buy_price = 28;
    color = "orange"
  }

let space14 : space = Property { 
    space_id = 14;
    name = "Physical Sciences Building";
    rent_price = 34;
    owner = ""; 
    buy_price = 30;
    color = "red"
  }

let space15 : space = CardSpace { 
    space_id = 15;
    name = "Chance";
  }

let space16 : space = Property { 
    space_id = 16;
    name = "Rockefeller Hall";
    rent_price = 35;
    owner = "";
    buy_price = 30;
    color = "red"
  }

let space17 : space = Property { 
    space_id = 17;
    name = "Baker Lab";
    rent_price = 35;
    owner = "";
    buy_price = 30;
    color = "red"
  }

let space18 : space = Penalty { 
    space_id = 18;
    name = "Penalty";
    description = "Flu season! Pay $40 for your flu shot";
    penalty_price = 40
  }

let space19 : space = Property { 
    space_id = 19;
    name = "Kennedy Hall";
    rent_price = 35;
    owner = "";
    buy_price = 30;
    color = "purple"
  }

let space20 : space = JustVisiting { 
    space_id = 20;
    name = "Just Visiting"
  }

let space21 : space = Property { 
    space_id = 21;
    name = "Malott Hall";
    rent_price = 37;
    owner = "";
    buy_price = 32;
    color = "purple"
  }

let space22 : space = Property { 
    space_id = 22;
    name = "Mann Library";
    rent_price = 38;
    owner = "";
    buy_price = 35;
    color = "purple"
  }


let space23 : space = Property { 
    space_id = 23;
    name = "Statler Hall";
    rent_price = 38;
    owner = "";
    buy_price = 35;
    color = "light blue"
  }

let space24 : space = Property { 
    space_id = 24;
    name = "Barton Hall";
    rent_price = 38;
    owner = "";
    buy_price = 35;
    color = "light blue"
  }

let space25 : space = Property { 
    space_id = 25;
    name = "Uris Hall";
    rent_price = 40;
    owner = "";
    buy_price = 35;
    color = "light blue"
  }

let space26 : space = CardSpace { 
    space_id = 26;
    name = "Chance";
  }


let space27 : space = Property { 
    space_id = 27;
    name = "Cornell Dairy";
    rent_price = 42;
    owner = "";
    buy_price = 37;
    color = "pink"
  }

let space28 : space = Property { 
    space_id = 28;
    name = "Botanical Gardens";
    rent_price = 42;
    owner = "";
    buy_price = 37;
    color = "pink"
  }

let space29 : space = Property { 
    space_id = 29;
    name = "Cow Land";
    rent_price = 42;
    owner = "";
    buy_price = 37;
    color = "pink"
  }


let space30 : space = Property { 
    space_id = 30;
    name = "Cornell Health";
    rent_price = 45;
    owner = "";
    buy_price = 38;
    color = "cyan"
  }


let space31 : space = Property { 
    space_id = 31;
    name = "McGraw Clock Tower";
    rent_price = 45;
    owner = "";
    buy_price = 38;
    color = "cyan"
  }

let space32 : space = Property { 
    space_id = 32;
    name = "Willard Straight Hall";
    rent_price = 50;
    owner = "";
    buy_price = 40;
    color = "cyan"
  }

let space33 : space = CardSpace { 
    space_id = 33;
    name = "Chance";
  }

let space34 : space = Property { 
    space_id = 34;
    name = "Hollister Hall";
    rent_price = 53;
    owner = "";
    buy_price = 40;
    color = "brown"
  }

let space35 : space = Property { 
    space_id = 35;
    name = "Duffield Hall";
    rent_price = 55;
    owner = "";
    buy_price = 40;
    color = "brown"
  }


let space36 : space = Penalty { 
    space_id = 36;
    name = "Penalty";
    description = "$60 Student activity fee...";
    penalty_price = 60
  }


let space37 : space = Property { 
    space_id = 37;
    name = "Rhodes Hall";
    rent_price = 60;
    owner = "";
    buy_price = 45;
    color = "brown"
  }

let space38 : space = Property { 
    space_id = 38;
    name = "Schwartz Center for the Performing Arts";
    rent_price = 70;
    owner = "";
    buy_price = 50;
    color = "blue"
  }

let space39 : space = Property { 
    space_id = 39;
    name = "Collegetown Bagels";
    rent_price = 100;
    owner = "";
    buy_price = 60;
    color = "blue"
  }

let property1 = {
  space_id = 2;
  name = "Low Rise 5";
  rent_price = 20;
  owner = "";
  buy_price = 15;
  color = "green"
}


let cardspace1 = {
  space_id = 26;
  name = "Chance";
}

let spacelist : space list = [
  space1; space2; space3; space4; 
  space5; space6; space7; space8;
  space9; space10; space11; space12; 
  space13; space14; space15; space16; 
  space17; space18; space19; space20; 
  space21; space22; space23; space24; 
  space25; space26; space27; space28; 
  space29; space30; space31; space32; 
  space33; space34; space35; space36; 
  space37; space38; space39; 
]

let get_space id spacelst = 
  List.find (fun s -> (space_id s) = id) spacelst
(**[green] is the list of spaces with green property spaces *)
let green : space list = [space2; space3; space4]

(**[yellow] is the list of spaces with yellow property spaces *)
let yellow : space list = [space6; space7; space8]

(**[orange] is the list of spaces with orange property spaces *)
let orange : space list = [space11; space12; space13]

(**[red] is the list of spaces with red property spaces *)
let red : space list = [space14; space16; space17]

(**[purple] is the list of spaces with purple property spaces *)
let purple : space list = [space19; space21; space22]

(** [light_blue] is the list of spaces with light blue property spaces*)
let light_blue : space list = [space23; space24; space25]

(** [pink] is the list of spaces with pink property spaces*)
let pink : space list = [space27; space28; space29]

(** [cyan] is the list of spaces with cyan property spaces*)
let cyan : space list = [space30; space31; space32]

(** [brown] is the list of spaces with brown property spaces*)
let brown : space list = [space34; space35; space37]

(** [blue] is the list of spaces with blue property spaces*)
let blue : space list = [space38; space39]

(* Dark Theme Space List *)
let space41 : space = Go {
    space_id = 1; 
    name = "Go";
  }


let space42 : space = Property { 
    space_id = 2;
    name = "SPOOKY";
    rent_price = 20;
    owner = "";
    buy_price = 15;
    color = "green"
  }

let space43 : space = Property { 
    space_id = 3;
    name = "BREH";
    rent_price = 24;
    owner = "";
    buy_price = 17;
    color = "green"
  }

let space44 : space = Property { 
    space_id = 4;
    name = "YAS CKB";
    rent_price = 27;
    owner = "";
    buy_price = 20;
    color = "green"
  }

let space45 : space = Penalty { 
    space_id = 5;
    name = "THIS IS A PENALTY BOI";
    description = "Pay $30 for your Bursar Bill :(";
    penalty_price = 30
  }

let space46 : space = Property { 
    space_id = 6;
    name = "KLARMAN SUCKS";
    rent_price = 28;
    owner = "";
    buy_price = 24;
    color = "yellow"
  }

let space47 : space = Property { 
    space_id = 7;
    name = "Goldwin Smith Hall SUCKS";
    rent_price = 28;
    owner = "";
    buy_price = 24;
    color = "yellow"
  }

let space48 : space = Property { 
    space_id = 8;
    name = "CAFE JENNIE KIM";
    rent_price = 29;
    owner = "";
    buy_price = 25;
    color = "yellow"
  }

let space49 : space = CardSpace { 
    space_id = 9;
    name = "CHANCE BITCH";
  }

let space50 : space = Jail {
    space_id = 10;
    name = "GO TO JAIL BITCH"
  }

let space51 : space = Property { 
    space_id = 11;
    name = "Becker Hall SUCKS";
    rent_price = 30;
    owner = "";
    buy_price = 25;
    color = "orange"
  }

let space52 : space = Property { 
    space_id = 12;
    name = "Bethe Hall I WISH I GOT THIS";
    rent_price = 30;
    owner = "";
    buy_price = 25;
    color = "orange"
  }

let space53 : space = Property { 
    space_id = 13;
    name = "Baker Flagpole YO DANK";
    rent_price = 32;
    owner = "";
    buy_price = 28;
    color = "orange"
  }

let space54 : space = Property { 
    space_id = 14;
    name = "Physical Sciences Building BREH SUCKS";
    rent_price = 34;
    owner = ""; 
    buy_price = 30;
    color = "red"
  }

let space55 : space = CardSpace { 
    space_id = 15;
    name = "Chance";
  }

let space56 : space = Property { 
    space_id = 16;
    name = "Rockefeller Hall IS OLD AS FK";
    rent_price = 35;
    owner = "";
    buy_price = 30;
    color = "red"
  }

let space57 : space = Property { 
    space_id = 17;
    name = "Baker Lab IS HELL";
    rent_price = 35;
    owner = "";
    buy_price = 30;
    color = "red"
  }

let space58 : space = Penalty { 
    space_id = 18;
    name = "Penalty YO";
    description = "Flu season! Pay $40 for your flu shot";
    penalty_price = 40
  }

let space59 : space = Property { 
    space_id = 19;
    name = "Kennedy Hall WHERE IS THIS";
    rent_price = 35;
    owner = "";
    buy_price = 30;
    color = "purple"
  }

let space60 : space = JustVisiting { 
    space_id = 20;
    name = "Just Visiting"
  }

let space61 : space = Property { 
    space_id = 21;
    name = "Malott Hall  MATH SUCKS";
    rent_price = 37;
    owner = "";
    buy_price = 32;
    color = "purple"
  }

let space62 : space = Property { 
    space_id = 22;
    name = "Mann Library YO DNAK";
    rent_price = 38;
    owner = "";
    buy_price = 35;
    color = "purple"
  }


let space63 : space = Property { 
    space_id = 23;
    name = "Statler Hall IS FANCY";
    rent_price = 38;
    owner = "";
    buy_price = 35;
    color = "light blue"
  }

let space64 : space = Property { 
    space_id = 24;
    name = "Barton Hall BREH NO ";
    rent_price = 38;
    owner = "";
    buy_price = 35;
    color = "light blue"
  }

let space65 : space = Property { 
    space_id = 25;
    name = "Uris Hall COOL";
    rent_price = 40;
    owner = "";
    buy_price = 35;
    color = "light blue"
  }

let space66 : space = CardSpace { 
    space_id = 26;
    name = "Chance";
  }


let space67 : space = Property { 
    space_id = 27;
    name = "Cornell Dairy";
    rent_price = 42;
    owner = "";
    buy_price = 37;
    color = "pink"
  }

let space68 : space = Property { 
    space_id = 28;
    name = "Botanical Gardens";
    rent_price = 42;
    owner = "";
    buy_price = 37;
    color = "pink"
  }

let space69 : space = Property { 
    space_id = 29;
    name = "Cow Land";
    rent_price = 42;
    owner = "";
    buy_price = 37;
    color = "pink"
  }


let space70 : space = Property { 
    space_id = 30;
    name = "Cornell Health";
    rent_price = 45;
    owner = "";
    buy_price = 38;
    color = "cyan"
  }


let space71 : space = Property { 
    space_id = 31;
    name = "McGraw Clock Tower";
    rent_price = 45;
    owner = "";
    buy_price = 38;
    color = "cyan"
  }

let space72 : space = Property { 
    space_id = 32;
    name = "Willard Straight Hall";
    rent_price = 50;
    owner = "";
    buy_price = 40;
    color = "cyan"
  }

let space73 : space = CardSpace { 
    space_id = 33;
    name = "Chance";
  }

let space74 : space = Property { 
    space_id = 34;
    name = "Hollister Hall";
    rent_price = 53;
    owner = "";
    buy_price = 40;
    color = "brown"
  }

let space75 : space = Property { 
    space_id = 35;
    name = "Duffield Hall";
    rent_price = 55;
    owner = "";
    buy_price = 40;
    color = "brown"
  }


let space76 : space = Penalty { 
    space_id = 36;
    name = "Penalty";
    description = "$60 Student activity fee...";
    penalty_price = 60
  }


let space77 : space = Property { 
    space_id = 37;
    name = "Rhodes Hall";
    rent_price = 60;
    owner = "";
    buy_price = 45;
    color = "brown"
  }

let space78 : space = Property { 
    space_id = 38;
    name = "Schwartz Center for the Performing Arts";
    rent_price = 70;
    owner = "";
    buy_price = 50;
    color = "blue"
  }

let space79 : space = Property { 
    space_id = 39;
    name = "FAT DIKCS";
    rent_price = 100;
    owner = "";
    buy_price = 60;
    color = "blue"
  }

let spacelist_dark : space list = [
  space41; space42; space43; space44; 
  space45; space46; space47; space48;
  space49; space50; space51; space52; 
  space53; space54; space55; space56; 
  space57; space58; space59; space60; 
  space61; space62; space63; space64; 
  space65; space66; space67; space68; 
  space69; space70; space71; space72; 
  space73; space74; space75; space76; 
  space77; space78; space79; 
]
