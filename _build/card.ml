type amount = int 


type action = 
  | Change of amount
  | Move of amount 

type card =
  {
    description: string;
    act: action;
  }