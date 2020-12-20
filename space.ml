
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

let space1 : space= Go {
    space_id = 1; 
    name = "Go";
  }

let space2 : space= Property { 
    space_id = 2;
    name = "Low Rise 5";
    rent_price = [|8;20;36|];
    owner = "";
    buy_price = [|60;110;160|];
    color = "green";
    level = 0;
  }

let space3 : space = Property { 
    space_id = 3;
    name = "Donlon";
    rent_price = [|12;30;38|];
    owner = "";
    buy_price = [|70;120;170|];
    color = "green";
    level = 0;
  }

let space4 : space = Property { 
    space_id = 4;
    name = "CKB";
    rent_price = [|12;30;42|];
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
    rent_price = [|16;40;48|];
    owner = "";
    buy_price = [|100;150;200|];
    color = "yellow";
    level = 0;
  }

let space7 : space = Property { 
    space_id = 7;
    name = "Goldwin Smith Hall";
    rent_price = [|20;50;60|];
    owner = "";
    buy_price = [|110;180;240|];
    color = "yellow";
    level = 0;
  }

let space8 : space = Property { 
    space_id = 8;
    name = "Cafe Jennie";
    rent_price = [|20;50;72|];
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
    rent_price = [|24;60;108|];
    owner = "";
    buy_price = [|140;240;340|];
    color = "orange";
    level = 0;
  }

let space12 : space = Property { 
    space_id = 12;
    name = "Bethe Hall";
    rent_price = [|28;70;110|];
    owner = "";
    buy_price =[|150;250;340|];
    color = "orange";
    level = 0;
  }

let space13 : space = Property { 
    space_id = 13;
    name = "Baker Flagpole";
    rent_price = [|28;70;113|];
    owner = "";
    buy_price = [|160;270;340|];
    color = "orange";
    level = 0;
  }

let space14 : space = Property { 
    space_id = 14;
    name = "Physical Sciences Building";
    rent_price = [|32;80;200|];
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
    rent_price = [|32;80;230|];
    owner = "";
    buy_price = [|190;310;380|];
    color = "red";
    level = 0;
  }

let space17 : space = Property { 
    space_id = 17;
    name = "Baker Lab";
    rent_price = [|32;80;260|];
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
    rent_price = [|40;100;300|];
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
    rent_price = [|44;110;320|];
    owner = "";
    buy_price = [|230;400;520|];
    color = "purple";
    level = 0;
  }

let space22 : space = Property { 
    space_id = 22;
    name = "Mann Library";
    rent_price = [|48;120;360|];
    owner = "";
    buy_price = [|240;420;520|];
    color = "purple";
    level = 0;
  }


let space23 : space = Property { 
    space_id = 23;
    name = "Statler Hall";
    rent_price = [|52;130;380|];
    owner = "";
    buy_price = [|260;440;560|];
    color = "light blue";
    level = 0;
  }

let space24 : space = Property { 
    space_id = 24;
    name = "Barton Hall";
    rent_price = [|56;140;400|];
    owner = "";
    buy_price = [|270;460;560|];
    color = "light blue";
    level = 0;
  }

let space25 : space = Property { 
    space_id = 25;
    name = "Uris Hall";
    rent_price = [|60;150;420|];
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
    rent_price = [|64;160;440|];
    owner = "";
    buy_price = [|300;500;700|];
    color = "pink";
    level = 0;
  }

let space28 : space = Property { 
    space_id = 28;
    name = "Botanical Gardens";
    rent_price = [|68;170;460|];
    owner = "";
    buy_price = [|310;510;700|];
    color = "pink";
    level = 0;
  }

let space29 : space = Property { 
    space_id = 29;
    name = "Cow Land";
    rent_price = [|72;180;500|];
    owner = "";
    buy_price = [|310;515;700|];
    color = "pink";
    level = 0;
  }


let space30 : space = Property { 
    space_id = 30;
    name = "Cornell Health";
    rent_price = [|76;190;540|];
    owner = "";
    buy_price = [|320;520;720|];
    color = "cyan";
    level = 0;
  }


let space31 : space = Property { 
    space_id = 31;
    name = "McGraw Clock Tower";
    rent_price = [|80;200;560|];
    owner = "";
    buy_price = [|320;530;720|];
    color = "cyan";
    level = 0;
  }

let space32 : space = Property { 
    space_id = 32;
    name = "Willard Straight Hall";
    rent_price = [|80;200;600|];
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
    rent_price = [|84;210;640|];
    owner = "";
    buy_price = [|350;550;750|];
    color = "brown";
    level = 0;
  }

let space35 : space = Property { 
    space_id = 35;
    name = "Duffield Hall";
    rent_price = [|88;220;660|];
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
    rent_price = [|96;240;680|];
    owner = "";
    buy_price = [|350;590;750|];
    color = "brown";
    level = 0;
  }

let space38 : space = Property { 
    space_id = 38;
    name = "Schwartz Center for the Performing Arts";
    rent_price = [|104;260;700|];
    owner = "";
    buy_price = [|400;600;800|];
    color = "blue";
    level = 0;
  }

let space39 : space = Property { 
    space_id = 39;
    name = "Collegetown Bagels";
    rent_price = [|112;280;750|];
    owner = "";
    buy_price = [|400;600;800|];
    color = "blue";
    level = 0;
  }

let property1 = {
  space_id = 2;
  name = "Low Rise 5";
  rent_price = [|8;20;36|];
  owner = "";
  buy_price = [|60;110;160|];
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

(* THE LIST OF SPACES FOR EACH COLOR SET *)
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
    name = "The Dark Basement of Low Rise 5";
    rent_price = [|18;30;76|];
    owner = "";
    buy_price = [|70;120;170|];
    color = "moss green";
    level = 0;
  }

let space43 : space = Property { 
    space_id = 3;
    name = "Donlon Towers";
    rent_price = [|22;40;74|];
    owner = "";
    buy_price = [|90;140;190|];
    color = "moss green";
    level = 0;
  }

let space44 : space = Property { 
    space_id = 4;
    name = "The Haunted CKB Dungeons";
    rent_price = [|22;40;80|];
    owner = "";
    buy_price = [|100;150;200|];
    color = "moss green";
    level = 0;
  }

let space45 : space = Penalty { 
    space_id = 5;
    name = "Penalty";
    description = "Pay $30 for your Spooky Costume";
    penalty_price = 30
  }

let space46 : space = Property { 
    space_id = 6;
    name = "Klarman Ghouls";
    rent_price = [|26;50;90|];
    owner = "";
    buy_price = [|120;170;220|];
    color = "gold";
    level = 0;
  }

let space47 : space = Property { 
    space_id = 7;
    name = "The Deserted Goldwin Smith Hall";
    rent_price = [|30;60;110|];
    owner = "";
    buy_price = [|110;180;240|];
    color = "gold";
    level = 0;
  }

let space48 : space = Property { 
    space_id = 8;
    name = "Cafe Jennie Kim";
    rent_price = [|30;60;130|];
    owner = "";
    buy_price = [|130;230;310|];
    color = "gold";
    level = 0;
  }

let space49 : space = CardSpace { 
    space_id = 9;
    name = "Chance? or not ;)";
  }

let space50 : space = Jail {
    space_id = 10;
    name = "The Desolated Prison"
  }

let space51 : space = Property { 
    space_id = 11;
    name = "Becker Remains";
    rent_price = [|34;70;190|];
    owner = "";
    buy_price = [|160;260;360|];
    color = "amber";
    level = 0;
  }

let space52 : space = Property { 
    space_id = 12;
    name = "Bethe Screams";
    rent_price = [|38;80;194|];
    owner = "";
    buy_price =[|170;270;360|];
    color = "amber";
    level = 0;
  }

let space53 : space = Property { 
    space_id = 13;
    name = "Lonely Baker Flagpole";
    rent_price = [|43;85;203|];
    owner = "";
    buy_price = [|185;295;365|];
    color = "amber";
    level = 0;
  }

let space54 : space = Property { 
    space_id = 14;
    name = "Physical Silences Building";
    rent_price = [|47;95;215|];
    owner = ""; 
    buy_price = [|205;305;405|];
    color = "blood";
    level = 0;
  }

let space55 : space = CardSpace { 
    space_id = 15;
    name = "Chance? or not ;)";
  }

let space56 : space = Property { 
    space_id = 16;
    name = "Eerie Rockefeller Hall";
    rent_price = [|47;95;245|];
    owner = "";
    buy_price = [|215;335;410|];
    color = "blood";
    level = 0;
  }

let space57 : space = Property { 
    space_id = 17;
    name = "Experimental Baker Lab";
    rent_price = [|47;95;275|];
    owner = "";
    buy_price = [|225;365;410|];
    color = "blood";
    level = 0;
  }

let space58 : space = Penalty { 
    space_id = 18;
    name = "Penalty";
    description = "Zombie bite! Pay $100 to prevent turning into a zombie!!";
    penalty_price = 100
  }

let space59 : space = Property { 
    space_id = 19;
    name = "The Sinister Kennedy Hall";
    rent_price = [|60;120;320|];
    owner = "";
    buy_price = [|250;400;550|];
    color = "opal";
    level = 0;
  }

let space60 : space = JustVisiting { 
    space_id = 20;
    name = "Just Visiting"
  }

let space61 : space = Property { 
    space_id = 21;
    name = "The Silent Malott Hall";
    rent_price = [|64;130;350|];
    owner = "";
    buy_price = [|260;430;550|];
    color = "opal";
    level = 0;
  }

let space62 : space = Property { 
    space_id = 22;
    name = "Empty Mann Library";
    rent_price = [|68;140;380|];
    owner = "";
    buy_price = [|270;450;550|];
    color = "opal";
    level = 0;
  }


let space63 : space = Property { 
    space_id = 23;
    name = "Statler Prison Cells";
    rent_price = [|72;150;400|];
    owner = "";
    buy_price = [|290;470;590|];
    color = "earth";
    level = 0;
  }

let space64 : space = Property { 
    space_id = 24;
    name = "The Hollow Barton Hall";
    rent_price = [|76;160;420|];
    owner = "";
    buy_price = [|300;490;630|];
    color = "earth";
    level = 0;
  }

let space65 : space = Property { 
    space_id = 25;
    name = "The Sunken Uris Hall";
    rent_price = [|80;170;440|];
    owner = "";
    buy_price = [|310;510;660|];
    color = "earth";
    level = 0;
  }

let space66 : space = CardSpace { 
    space_id = 26;
    name = "Chance? or not ;)";
  }

let space67 : space = Property { 
    space_id = 27;
    name = "The Milk Farms";
    rent_price = [|84;180;460|];
    owner = "";
    buy_price = [|330;530;730|];
    color = "magenta";
    level = 0;
  }

let space68 : space = Property { 
    space_id = 28;
    name = "Poisonous Botanical Gardens";
    rent_price = [|88;190;480|];
    owner = "";
    buy_price = [|340;540;740|];
    color = "magenta";
    level = 0;
  }

let space69 : space = Property { 
    space_id = 29;
    name = "Possessed Cow Land";
    rent_price = [|92;200;520|];
    owner = "";
    buy_price = [|340;545;750|];
    color = "magenta";
    level = 0;
  }


let space70 : space = Property { 
    space_id = 30;
    name = "The Raided Cornell Health";
    rent_price = [|96;210;560|];
    owner = "";
    buy_price = [|350;555;755|];
    color = "cobalt";
    level = 0;
  }


let space71 : space = Property { 
    space_id = 31;
    name = "Fallen McGraw Clock Tower";
    rent_price = [|100;220;580|];
    owner = "";
    buy_price = [|350;560;760|];
    color = "cobalt";
    level = 0;
  }

let space72 : space = Property { 
    space_id = 32;
    name = "The Chilling Willard Straight Hall";
    rent_price = [|110;230;630|];
    owner = "";
    buy_price = [|360;580;760|];
    color = "cobalt";
    level = 0;
  }

let space73 : space = CardSpace { 
    space_id = 33;
    name = "Chance? or not ;)";
  }

let space74 : space = Property { 
    space_id = 34;
    name = "The Dungeons Under Gates Hall";
    rent_price = [|114;240;670|];
    owner = "";
    buy_price = [|390;590;790|];
    color = "brown";
    level = 0;
  }

let space75 : space = Property { 
    space_id = 35;
    name = "The CS majors of Duffield Hall";
    rent_price = [|118;250;690|];
    owner = "";
    buy_price = [|390;620;790|];
    color = "brown";
    level = 0;
  }

let space76 : space = Penalty { 
    space_id = 36;
    name = "Penalty";
    description = "$40 The Killer Cult Admissions Fee";
    penalty_price = 40
  }


let space77 : space = Property { 
    space_id = 37;
    name = "The Barren Schoellkopf Field";
    rent_price = [|126;270;710|];
    owner = "";
    buy_price = [|390;630;790|];
    color = "brown";
    level = 0;
  }

let space78 : space = Property { 
    space_id = 38;
    name = "Schwartz Center for the Dark Arts";
    rent_price = [|134;290;730|];
    owner = "";
    buy_price = [|450;650;850|];
    color = "black";
    level = 0;
  }

let space79 : space = Property { 
    space_id = 39;
    name = "Sunken Collegetown Bagels";
    rent_price = [|142;310;780|];
    owner = "";
    buy_price = [|450;650;850|];
    color = "black";
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

(* THE LIST OF SPACES FOR EACH COLOR SET *)
(**[moss_green] is the list of spaces with moss green property spaces *)
let moss_green : space list = [space42; space43; space44]

(**[gold] is the list of spaces with gold property spaces *)
let gold : space list = [space46; space47; space48]

(**[amber] is the list of spaces with amber property spaces *)
let amber : space list = [space51; space52; space53]

(**[blood] is the list of spaces with blood property spaces *)
let blood : space list = [space54; space56; space57]

(**[opal] is the list of spaces with opal property spaces *)
let opal : space list = [space59; space61; space62]

(** [earth] is the list of spaces with earth property spaces*)
let earth : space list = [space63; space64; space65]

(** [magenta] is the list of spaces with magenta property spaces*)
let magenta : space list = [space67; space68; space69]

(** [cobalt] is the list of spaces with cobalt property spaces*)
let colbalt : space list = [space70; space71; space72]

(** [brown] is the list of spaces with brown property spaces*)
let brown : space list = [space74; space75; space77]

(** [black] is the list of spaces with black property spaces*)
let black : space list = [space78; space79]
