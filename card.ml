type amount = int

type action =
  | Change of amount
  | Move of amount

type card =
  {
    description: string;
    act: action list;
  }

let card1 = {
  description = "Pay your Bursar Bill! You owe Cornell $200.";
  act = [Change ~-200]
}

let card2 = {
  description = "Bank pays you dividend of $50.";
  act = [Change 50]
}

let card3 = {
  description = "Advance to Goldwin Smith Hall- If you pass Go, gain $200.";
  act = [Move 7]
}

let card4 = {
  description = "Advance to Go — Collect $200.";
  act = [Move 1; Change 200]
}