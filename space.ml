open Card

type property = {
  space_id: int;
  name : string;
  rent_price : int array; 
  owner : string;
  buy_price : int array;
  color : string; 
  level : int; (* 0, 1, 2*)
}

let property_name property = 
  property.name

let property_id property = 
  property.space_id

let rent_price property =
  property.rent_price

let property_owner property = 
  property.owner

let property_color property = 
  property.color

let buy_price property = 
  property.buy_price

let property_level property = 
  property.level

let change_owner property new_owner = 
  {property with owner = new_owner}

(* 0, 1, 2 *)
let change_level property new_level = 
  {property with level = new_level}

let get_level_price property = 
  let level = property_level property in
  let rent_arr = rent_price property in
  rent_arr.(level)

type penalty = {
  space_id: int;
  name: string;
  description : string;
  penalty_price : int
}

let penalty_name penalty = 
  penalty.name

let penalty_description penalty = 
  penalty.description

let penalty_price penalty = 
  penalty.penalty_price

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
    rent_price = [|2;15;30|];
    owner = "";
    buy_price = [|60;110;160|];
    color = "green";
    level = 0;
  }

let space3 : space = Property { 
    space_id = 3;
    name = "Donlon";
    rent_price = [|3;16;32|];
    owner = "";
    buy_price = [|70;120;170|];
    color = "green";
    level = 0;
  }

let space4 : space = Property { 
    space_id = 4;
    name = "CKB";
    rent_price = [|3;17;35|];
    owner = "";
    buy_price = [|80;130;180|];
    color = "green";
    level = 0;
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
    rent_price = [|4;20;40|];
    owner = "";
    buy_price = [|100;150;200|];
    color = "yellow";
    level = 0;
  }

let space7 : space = Property { 
    space_id = 7;
    name = "Goldwin Smith Hall";
    rent_price = [|5;22;50|];
    owner = "";
    buy_price = [|110;180;240|];
    color = "yellow";
    level = 0;
  }

let space8 : space = Property { 
    space_id = 8;
    name = "Cafe Jennie";
    rent_price = [|6;30;90|];
    owner = "";
    buy_price = [|120;210;280|];
    color = "yellow";
    level = 0;
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
    rent_price = [|6;30;90|];
    owner = "";
    buy_price = [|140;240;340|];
    color = "orange";
    level = 0;
  }

let space12 : space = Property { 
    space_id = 12;
    name = "Bethe Hall";
    rent_price = [|7;32;92|];
    owner = "";
    buy_price =[|150;250;340|];
    color = "orange";
    level = 0;
  }

let space13 : space = Property { 
    space_id = 13;
    name = "Baker Flagpole";
    rent_price = [|7;34;94|];
    owner = "";
    buy_price = [|160;270;340|];
    color = "orange";
    level = 0;
  }

let space14 : space = Property { 
    space_id = 14;
    name = "Physical Sciences Building";
    rent_price = [|8;40;100|];
    owner = ""; 
    buy_price = [|180;280;380|];
    color = "red";
    level = 0;
  }

let space15 : space = CardSpace { 
    space_id = 15;
    name = "Chance";
  }

let space16 : space = Property { 
    space_id = 16;
    name = "Rockefeller Hall";
    rent_price = [|8;42;115|];
    owner = "";
    buy_price = [|190;310;380|];
    color = "red";
    level = 0;
  }

let space17 : space = Property { 
    space_id = 17;
    name = "Baker Lab";
    rent_price = [|8;44;130|];
    owner = "";
    buy_price = [|200;340;380|];
    color = "red";
    level = 0;
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
    rent_price = [|10;50;150|];
    owner = "";
    buy_price = [|220;370;520|];
    color = "purple";
    level = 0;
  }

let space20 : space = JustVisiting { 
    space_id = 20;
    name = "Just Visiting"
  }

let space21 : space = Property { 
    space_id = 21;
    name = "Malott Hall";
    rent_price = [|11;52;160|];
    owner = "";
    buy_price = [|230;400;520|];
    color = "purple";
    level = 0;
  }

let space22 : space = Property { 
    space_id = 22;
    name = "Mann Library";
    rent_price = [|12;60;180|];
    owner = "";
    buy_price = [|240;420;520|];
    color = "purple";
    level = 0;
  }


let space23 : space = Property { 
    space_id = 23;
    name = "Statler Hall";
    rent_price = [|13;65;190|];
    owner = "";
    buy_price = [|260;440;560|];
    color = "light blue";
    level = 0;
  }

let space24 : space = Property { 
    space_id = 24;
    name = "Barton Hall";
    rent_price = [|14;70;200|];
    owner = "";
    buy_price = [|270;460;560|];
    color = "light blue";
    level = 0;
  }

let space25 : space = Property { 
    space_id = 25;
    name = "Uris Hall";
    rent_price = [|15;75;210|];
    owner = "";
    buy_price = [|280;480;560|];
    color = "light blue";
    level = 0;
  }

let space26 : space = CardSpace { 
    space_id = 26;
    name = "Chance";
  }

let space27 : space = Property { 
    space_id = 27;
    name = "Cornell Dairy";
    rent_price = [|16;80;220|];
    owner = "";
    buy_price = [|300;500;700|];
    color = "pink";
    level = 0;
  }

let space28 : space = Property { 
    space_id = 28;
    name = "Botanical Gardens";
    rent_price = [|17;83;230|];
    owner = "";
    buy_price = [|310;510;700|];
    color = "pink";
    level = 0;
  }

let space29 : space = Property { 
    space_id = 29;
    name = "Cow Land";
    rent_price = [|18;90;250|];
    owner = "";
    buy_price = [|310;515;700|];
    color = "pink";
    level = 0;
  }


let space30 : space = Property { 
    space_id = 30;
    name = "Cornell Health";
    rent_price = [|19;95;270|];
    owner = "";
    buy_price = [|320;520;720|];
    color = "cyan";
    level = 0;
  }


let space31 : space = Property { 
    space_id = 31;
    name = "McGraw Clock Tower";
    rent_price = [|20;97;280|];
    owner = "";
    buy_price = [|320;530;720|];
    color = "cyan";
    level = 0;
  }

let space32 : space = Property { 
    space_id = 32;
    name = "Willard Straight Hall";
    rent_price = [|20;100;300|];
    owner = "";
    buy_price = [|320;540;720|];
    color = "cyan";
    level = 0;
  }

let space33 : space = CardSpace { 
    space_id = 33;
    name = "Chance";
  }

let space34 : space = Property { 
    space_id = 34;
    name = "Hollister Hall";
    rent_price = [|21;105;330|];
    owner = "";
    buy_price = [|350;550;750|];
    color = "brown";
    level = 0;
  }

let space35 : space = Property { 
    space_id = 35;
    name = "Duffield Hall";
    rent_price = [|22;110;330|];
    owner = "";
    buy_price = [|350;580;750|];
    color = "brown";
    level = 0;
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
    rent_price = [|24;115;340|];
    owner = "";
    buy_price = [|350;590;750|];
    color = "brown";
    level = 0;
  }

let space38 : space = Property { 
    space_id = 38;
    name = "Schwartz Center for the Performing Arts";
    rent_price = [|26;130;390|];
    owner = "";
    buy_price = [|400;600;800|];
    color = "blue";
    level = 0;
  }

let space39 : space = Property { 
    space_id = 39;
    name = "Collegetown Bagels";
    rent_price = [|28;150;450|];
    owner = "";
    buy_price = [|400;600;800|];
    color = "blue";
    level = 0;
  }

let property1 = {
  space_id = 2;
  name = "Low Rise 5";
  rent_price = [|20;10;10|];
  owner = "";
  buy_price = [|20;10;10|];
  color = "green";
  level = 0;
}


let cardspace1 = {
  space_id = 26;
  name = "Chance";
}

let spacelist : space list = [
  space1; space2; space3; space4;space5; space6; space7; space8;
  space9; space10; space11; space12; space13; space14; space15; space16; 
  space17; space18; space19; space20; space21; space22; space23; space24; 
  space25; space26; space27; space28; space29; space30; space31; space32; 
  space33; space34; space35; space36; space37; space38; space39; 
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
    name = "Go Dark!";
  }


let space42 : space = Property { 
    space_id = 2;
    name = "SPOOKY";
    rent_price = [|2;15;30|];
    owner = "";
    buy_price = [|60;110;160|];
    color = "green";
    level = 0;
  }

let space43 : space = Property { 
    space_id = 3;
    name = "BREH";
    rent_price = [|3;16;32|];
    owner = "";
    buy_price = [|70;120;170|];
    color = "green";
    level = 0;
  }

let space44 : space = Property { 
    space_id = 4;
    name = "YAS CKB";
    rent_price = [|3;17;35|];
    owner = "";
    buy_price = [|80;130;180|];
    color = "green";
    level = 0;
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
    rent_price = [|4;20;40|];
    owner = "";
    buy_price = [|100;150;200|];
    color = "yellow";
    level = 0;
  }

let space47 : space = Property { 
    space_id = 7;
    name = "Santa";
    rent_price = [|5;22;50|];
    owner = "";
    buy_price = [|110;180;240|];
    color = "yellow";
    level = 0;
  }

let space48 : space = Property { 
    space_id = 8;
    name = "Cafe Jennie Kim ~";
    rent_price = [|5;24;60|];
    owner = "";
    buy_price = [|120;210;280|];
    color = "yellow";
    level = 0;
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
    name = "Statler Hall Room 1103";
    rent_price = [|10;20;30|];
    owner = "";
    buy_price = [|10;20;30|];
    color = "orange";
    level = 0;
  }

let space52 : space = Property { 
    space_id = 12;
    name = "Cornell Ice Cream Factory";
    rent_price = [|10;20;30|];
    owner = "";
    buy_price = [|10;20;30|];
    color = "orange";
    level = 0;
  }

let space53 : space = Property { 
    space_id = 13;
    name = "The Dungeons Under Gates Hall";
    rent_price = [|10;20;30|];
    owner = "";
    buy_price = [|10;20;30|];
    color = "orange";
    level = 0;
  }

let space54 : space = Property { 
    space_id = 14;
    name = "Physical Sciences Building BREH SUCKS";
    rent_price = [|10;20;30|];
    owner = ""; 
    buy_price = [|10;20;30|];
    color = "red";
    level = 0;
  }

let space55 : space = CardSpace { 
    space_id = 15;
    name = "Chance";
  }

let space56 : space = Property { 
    space_id = 16;
    name = "Rockefeller Hall IS OLD AS FK";
    rent_price = [|10;20;30|];
    owner = "";
    buy_price = [|10;20;30|];
    color = "red";
    level = 0;
  }

let space57 : space = Property { 
    space_id = 17;
    name = "Baker Lab IS HELL";
    rent_price = [|10;20;30|];
    owner = "";
    buy_price = [|10;20;30|];
    color = "red";
    level = 0;
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
    rent_price = [|10;20;30|];
    owner = "";
    buy_price = [|10;20;30|];
    color = "purple";
    level = 0;
  }

let space60 : space = JustVisiting { 
    space_id = 20;
    name = "Just Visiting"
  }

let space61 : space = Property { 
    space_id = 21;
    name = "Malott Hall  MATH SUCKS";
    rent_price = [|10;20;30|];
    owner = "";
    buy_price = [|10;20;30|];
    color = "purple";
    level = 0;
  }

let space62 : space = Property { 
    space_id = 22;
    name = "Mann Library YO DNAK";
    rent_price = [|10;20;30|];
    owner = "";
    buy_price = [|10;20;30|];
    color = "purple";
    level = 0;
  }


let space63 : space = Property { 
    space_id = 23;
    name = "Statler Hall IS FANCY";
    rent_price = [|10;20;30|];
    owner = "";
    buy_price = [|10;20;30|];
    color = "light blue";
    level = 0;
  }

let space64 : space = Property { 
    space_id = 24;
    name = "Barton Hall BREH NO ";
    rent_price = [|10;20;30|];
    owner = "";
    buy_price = [|10;20;30|];
    color = "light blue";
    level = 0;
  }

let space65 : space = Property { 
    space_id = 25;
    name = "Uris Hall COOL";
    rent_price = [|10;20;30|];
    owner = "";
    buy_price = [|10;20;30|];
    color = "light blue";
    level = 0;
  }

let space66 : space = CardSpace { 
    space_id = 26;
    name = "Chance";
  }


let space67 : space = Property { 
    space_id = 27;
    name = "Cornell Dairy";
    rent_price = [|10;20;30|];
    owner = "";
    buy_price = [|10;20;30|];
    color = "pink";
    level = 0;
  }

let space68 : space = Property { 
    space_id = 28;
    name = "Botanical Gardens";
    rent_price = [|10;20;30|];
    owner = "";
    buy_price = [|10;20;30|];
    color = "pink";
    level = 0;
  }

let space69 : space = Property { 
    space_id = 29;
    name = "Moo";
    rent_price = [|10;20;30|];
    owner = "";
    buy_price = [|10;20;30|];
    color = "pink";
    level = 0;
  }


let space70 : space = Property { 
    space_id = 30;
    name = "Cornell Health";
    rent_price = [|10;20;30|];
    owner = "";
    buy_price = [|10;20;30|];
    color = "cyan";
    level = 0;
  }


let space71 : space = Property { 
    space_id = 31;
    name = "McGraw Clock Tower";
    rent_price = [|10;20;30|];
    owner = "";
    buy_price = [|10;20;30|];
    color = "cyan";
    level = 0;
  }

let space72 : space = Property { 
    space_id = 32;
    name = "Willard Straight Hall";
    rent_price = [|10;20;30|];
    owner = "";
    buy_price = [|10;20;30|];
    color = "cyan";
    level = 0;
  }

let space73 : space = CardSpace { 
    space_id = 33;
    name = "Chance";
  }

let space74 : space = Property { 
    space_id = 34;
    name = "Hollister Hall";
    rent_price = [|10;20;30|];
    owner = "";
    buy_price = [|10;20;30|];
    color = "brown";
    level = 0;
  }

let space75 : space = Property { 
    space_id = 35;
    name = "Duffield Hall Nerds";
    rent_price = [|10;20;30|];
    owner = "";
    buy_price = [|10;20;30|];
    color = "brown";
    level = 0;
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
    rent_price = [|10;20;30|];
    owner = "";
    buy_price = [|10;20;30|];
    color = "brown";
    level = 0;
  }

let space78 : space = Property { 
    space_id = 38;
    name = "Schwartz Center for the Performing Arts";
    rent_price = [|10;20;30|];
    owner = "";
    buy_price = [|10;20;30|];
    color = "blue";
    level = 0;
  }

let space79 : space = Property { 
    space_id = 39;
    name = "Large penis";
    rent_price = [|10;20;30|];
    owner = "";
    buy_price = [|10;20;30|];
    color = "blue";
    level = 0;
  }

let spacelist_dark : space list = [
  space41; space42; space43; space44; space45; space46; space47; space48;
  space49; space50; space51; space52; space53; space54; space55; space56; 
  space57; space58; space59; space60; space61; space62; space63; space64; 
  space65; space66; space67; space68; 
  space69; space70; space71; space72; 
  space73; space74; space75; space76; 
  space77; space78; space79; 
]
