
type action =
  | Change of int
  | Move of int
  | Get_out of bool

type card =
  {
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
  description = "Bank pays you dividend of $50.";
  act = [Change 50]
}

let card3 = {
  card_id = 3;
  description = "Advance to Goldwin Smith Hall- If you pass Go, gain $50.";
  act = [Move 7]
}

let card4 = {
  card_id = 4;
  description = "Advance to Go — Collect $50.";
  act = [Move 1; Change 50]
}

let card5 = {
  card_id = 5;
  description = "Advance to Botanical Gardens – If you pass Go, gain $50.";
  act = [Move 28]
}

let card6 = {
  card_id = 6;
  description = "Go directly to Jail – Do not pass Go, do not collect $50.";
  act = [Move 10]
}

let card7 = {
  card_id = 7;
  description = "Pay poor tax of $15.";
  act = [Change (-15)]
}

let card8 = {
  card_id = 8;
  description = "Take a walk on the Engineering Quad–Advance character 
  to Duffield Hall – If you pass Go, collect $200.";
  act = [Move 35]
}

let card9 = {
  card_id = 9;
  description = "You have won Big Red Hacks!—Collect $100.";
  act = [Change 100]
}

let card10 = {
  card_id = 10;
  description = "Take a trip to Rhodes Hall–If you pass Go, collect $50.";
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
  description = "Pay for your class textbooks!";
  act = [Change (-120)]
}

let card14 = {
  card_id = 14;
  description = "You got caught stealing from Cornell Dairy! Go to Jail";
  act = [Move 10]
}
let card15 = {
  card_id = 15;
  description = "You were robbed 100 dollars during slope festival.";
  act = [Change (-100)]
}
let card16 = {
  card_id = 16;
  description = "You paid another student to get into CS3110! Pay 50 dollars";
  act = [Change (-50)]
}


let cardlist = [|card1; card2; card3; card4; card5; card6; card7; 
                 card9; card10; card11; card12; card13; card14; card15; card16|]
