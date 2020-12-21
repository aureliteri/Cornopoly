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
  description = "You loved 3110 so much you bought a 3110 T-shirt for $15!";
  act = [Change (-15)]
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
  description = "You missed your Daily Check! CUPD is after you! Pay $40 and go to Jail.";
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

(* --------------------DARK -------------------- *)
let card31 = {
  card_id = 31;
  description = "You have been rewarded $100 for defeating the zombies!";
  act = [Change 100]
}

let card32 = {
  card_id = 32;
  description = "Your food was stolen by killer bears. That'll cost you $30";
  act = [Change (-30)]
}

let card33 = {
  card_id = 33;
  description = "You have a Get out of The Desolate Prison card!";
  act = [Get_out true]
}

let card34 = {
  card_id = 34;
  description = "You saved Martha Pollack out of a trap and she has rewarded you $200!";
  act = [Change 200]
}

let card35 = {
  card_id = 35;
  description = "You fell into booby trap. Go straight to The Desolate Prison.";
  act = [Move 10]
}

let card36 = {
  card_id = 36;
  description = "You have been poisoned by your backstabbing teammate. Go straight to The Desolate Prison.";
  act = [Move 10]
}

let card37 = {
  card_id = 37;
  description = "Your teammate sacrificed their life for you - Advance to Go Dark, collect $200.";
  act = [Move 1; Change 200]
}

let card38 = {
  card_id = 38;
  description = "You were distracted by the Cornell Dairy Ice Cream and was robbed of $50.";
  act = [Change (-50)]
}

let card39 = {
  card_id = 39;
  description = "You were spooked by the Klarman Ghouls and lost your $200 weapons.";
  act = [Change (-200)]
}

let card40 = {
  card_id = 40;
  description = "You killed the Howling Beasts and earned $200!";
  act = [Change 200]
}

let card40 = {
  card_id = 40;
  description = "You landed a solid punch on the AI Robot Machine. Advance to Go Dark, collect $200.";
  act = [Move 1; Change 200]
}

let card41 = {
  card_id = 41;
  description = "You fought the Ultimate Boss Martha and defeated her. Advance to Go Dark, collect $200.";
  act = [Move 1; Change 200]
}

let card42 = {
  card_id = 42;
  description = "A terrifying wizard has caught you cheating on your duel! \nYou are tossed into the Desolate Prison and a fine of $100.";
  act = [Move 10; Change (-100)]
}

let card43 = {
  card_id = 43;
  description = "Your parents are severly disappointed in your failure in honoring the family. \nYou lose your allowance of $100 and you lose your honor.";
  act = [Change (-100)]
}

let card44 = {
  card_id = 44;
  description = "You slipped on black ice and dropped $100.";
  act = [Change (-100)]
}

let card45 = {
  card_id = 45;
  description = "You're a nuisance. The Desolate Prison is tired of you. \nGet out. Please take this Get Out of Jail Free card";
  act = [Get_out true]
}


let card46 = {
  card_id = 46;
  description = "You are trapped underground in the Sunken Uris Hall. Go straight to the Desolate Prison.";
  act = [Move 10]
}

let card47 = {
  card_id = 47;
  description = "The great sage Michael Clarkson recognizes your contributions to The Cause. \nYou have earned $150 for your wisdom.";
  act = [Change 150]
}

let card48 = {
  card_id = 48;
  description = "You snuck into the Chimes tower and accidentally set off the bells.\nRun to the Poisonous Botanical Gardens to avoid getting caught. \nCollect $200 is you pass Go.";
  act = [Move 28]
}

let card49 = {
  card_id = 49;
  description = "The Jack O Lantern you carved is a bit ugly. You lose $200.";
  act = [Change (-200)]
}

let card50 = {
  card_id = 50;
  description = "Your pinky has been bitten by the Three Headed Dogs, pay $250 for the stitches";
  act = [Change (-250)]
}

let card51 = {
  card_id = 51;
  description = "After watching Get Out the movie, you have mastered the way to escape. But only once. You have recieved a Get Out of Jail Card.";
  act = [Get_out true]
}

let card52 = {
  card_id = 52;
  description = "You've mastered witchcraft and have finnesed $200 out of scholarships. Congrats!";
  act = [Change (200)]
}

let card53 = {
  card_id = 53;
  description = "You got trapped inside of Balch Hall's spooky elevator. \nYou lose $100 for not knowing how to operate elevators.";
  act = [Change (-100)]
}

let card54 = {
  card_id = 54;
  description = "You found a spooky bone in the Okenshield's stir fry. They pay you $100 to not post on reddit.";
  act = [Change (100)]
}

let card55 = {
  card_id = 55;
  description = "You opened a small hole to another world! Congrats! You have earned $100 ";
  act = [Change (100)]
}

let card56 = {
  card_id = 56;
  description = "Your bloody make up for your costume is falling off, pay $60 for more paint.";
  act = [Change (-60)]
}

let card57 = {
  card_id = 57;
  description = "You tripped on your long Ghost outfit and twisted your ankle. Pay $100 for the ice pack.";
  act = [Change (-100)]
}

let card58 = {
  card_id = 58;
  description = "You got hit by the invisible spooky TCAT bus, but the school decides not to compensate you. \nTake the L. You lose $150.";
  act = [Change (-150)]
}

let card59 = {
  card_id = 59;
  description = "You were attacked by the Big Red Bear. Pay for 100 dollars for hospital fees.";
  act = [Change (-100)]
}

let card60 = {
  card_id = 60;
  description = "The dark lord has blessed you. You get 200 dollars";
  act = [Change 200]
}


let cardlist = [|
  card1; card2; card3; card4; card5; card6; card7; 
  card9; card10; card11; card12; card13; card14; 
  card15; card16; card17; card18; card19; card20; card21; 
  card22; card23; card24; card25; card26; card27; card28; 
  card29; card30;
|]

let cardlist_dark = [|
  card31; card32; card33; card34; card35; card36; card37; 
  card38; card39; card40; card41; card42; card43; card44;
  card45; card46; card47; card48; card49; card50; card51;
  card52; card52; card53; card54; card55; card56; card57;
  card58; card59; card60;
|]