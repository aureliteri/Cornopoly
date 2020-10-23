open Space

type player = {
  id : int;
  name : string;
  current_location_id : int; 
  balance : int;
  prop_list: property list;
  in_jail: bool;
}

let pass_go player = 
  {player with balance = player.balance + 200}

let move player int' = 
  {player with current_location_id = player.current_location_id + int'} 

let is_bankrupt player =
  player.balance <= 0 

let update_balance player amount = 
  {player with balance = player.balance + amount}

let player1 : player = {
  id = 1;
  name = "Meghana";
  current_location_id = 1;
  balance = 1500;
  prop_list = [];
  in_jail = false
}

let player2 : player = {
  id = 2;
  name = "Michelle";
  current_location_id = 1;
  balance = 1500;
  prop_list = [];
  in_jail = false
}

let player3 : player = {
  id = 3;
  name = "Aaron";
  current_location_id = 1;
  balance = 1500;
  prop_list = [];
  in_jail = false
}

let player4 : player = {
  id = 4;
  name = "Amy";
  current_location_id = 1;
  balance = 1500;
  prop_list = [];
  in_jail = false
}
