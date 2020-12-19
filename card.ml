open Space
type action =
  | Change of int
  | Move of int
  | Get_out of bool

type card = {
  card_id: int;
  description: string;
  act: action list;
}

let empty = {
  card_id = 0;
  description = "";
  act = [];
} 

let card_id card = card.card_id

let card_description card = card.description

let card_act card = card.act

let choose cardlist = 
  match cardlist with
  | [] -> empty
  | h :: t -> h

let card1 = {
  card_id = 1;
  description = "Pay your Bursar Bill! You owe Cornell $200.";
  act = [Change (-200)]
}

let card2 = {
  card_id = 2;
  description = "The bank has paid you a dividend of $50!!";
  act = [Change 50]
}

let card3 = {
  card_id = 3;
  description = "Advance to " ^ property_name (get_property space7) ^
                " - If you pass Go, gain $200.";
  act = [Move 7]
}


let card4 = {
  card_id = 4;
  description = "Go directly to Jail – Do not pass Go, do not collect $200.";
  act = [Move 10]
}


let card5 = {
  card_id = 5;
  description = "Advance to " ^ property_name (get_property space28) ^
                " – If you pass Go, gain $200." ;
  act = [Move 28]
}

let card6 = {
  card_id = 6;
  description = "Go directly to Jail – Do not pass Go, do not collect $200.";
  act = [Move 10]
}

let card7 = {
  card_id = 7;
  description = "Pay poor tax of $15.";
  act = [Change (-15)]
}

let card8 = {
  card_id = 8;
  description = "Take a walk on the Engineering Quad – You advance to " 
                ^ property_name (get_property space37) 
                ^ " – If you pass Go, collect $200.";
  act = [Move 35]
}

let card9 = {
  card_id = 9;
  description = "You have won Big Red Hacks! — Collect $100.";
  act = [Change 100]
}

let card10 = {
  card_id = 10;
  description = "Take a trip to " ^ property_name (get_property space37) 
                ^ " – If you pass Go, collect $200.";
  act = [Move 37]
}

let card11 = {
  card_id = 11;
  description = "You have a Get Out of Jail Free card!";
  act = [Get_out true]
}

let card12 = {
  card_id = 12;
  description = "You need to get tested for Covid! Pay 10 Dollars";
  act = [Change (-10)]
}

let card13 = {
  card_id = 13;
  description = "Pay $120 for your Vital Source textbooks!";
  act = [Change (-120)]
}

let card14 = {
  card_id = 14;
  description = "You got caught stealing from Cornell Dairy! Go to Jail";
  act = [Move 10]
}

let card15 = {
  card_id = 15;
  description = "You were robbed 100 dollars during Slope Day.";
  act = [Change (-100)]
}

let card16 = {
  card_id = 16;
  description = "You paid another student to get into CS3110! Pay 50 dollars";
  act = [Change (-50)]
}


let card17 = {
  card_id = 17;
  description = "Go directly to Jail – Do not pass Go, do not collect $200.";
  act = [Move 10]
}

let card18 = {
  card_id = 18;
  description = "You missed doing the Daily Check! CUPD is after you! Pay $40 and go to Jail.";
  act = [Change (-40); Move 10]
}

let card19 = {
  card_id = 19;
  description = "You got an internship for the summer! Collect $150 in stipend!";
  act = [Change 150]
}

let card20 = {
  card_id = 20;
  description = "Your friends threw you a surprise birthday party! Collect $100!";
  act = [Change 100]
}


let card21 = {
  card_id = 21;
  description = "Your friend borrowed $60 from you and never returned it.";
  act = [Change (-60)]
}


let card22 = {
  card_id = 22;
  description = "Cafe Jennie's $15 cheesecake is just that good. You went for seconds.";
  act = [Change (-15)]
}

let card23 = {
  card_id = 23;
  description = "$30 Wings Over Ithaca for the classic prelim stress eating.";
  act = [Change (-30)]
}

let card23 = {
  card_id = 23;
  description = "You found $20 lying around in the snow. It's yours now.";
  act = [Change (20)]
}

let card24 = {
  card_id = 24;
  description = "Go directly to Jail – Do not pass Go, do not collect $200.";
  act = [Move 10]
}


let card25 = {
  card_id = 25;
  description = "You have to buy an iClicker for class... $100";
  act = [Change (-100)]
}

let card26 = {
  card_id = 26;
  description = "You have a Get Out of Jail Free card!";
  act = [Get_out true]
}

let card27 = {
  card_id = 27;
  description = "You advance to " ^ property_name (get_property space39) 
                ^ " – If you pass Go, collect $200.";
  act = [Move 39]
}

let card28 = {
  card_id = 28;
  description = "Go directly to Jail – Do not pass Go, do not collect $200.";
  act = [Move 10]
}

let card29 = {
  card_id = 29;
  description = "Advance to Go — Collect $200.";
  act = [Move 1; Change 200]
}

let card30 = {
  card_id = 30;
  description = "You helped Matha Pollack across the street! She gave you a Get Out of Jail Free card!";
  act = [Get_out true]
}



let cardlist = [|
  card1; card2; card3; card4; card5; card6; card7; 
  card9; card10; card11; card12; card13; card14; card15; card16;
  card17; card18; card19; card20; card21; card22; card23; card24;
  card25; card26; card27; card28; card29; card30;|]
