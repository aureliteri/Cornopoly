open Space

exception UnknownPlayer of string

type player = {
  id : int;
  name : string;
  current_location_id : int; 
  balance : int;
  property_list: property list;
  in_jail: bool;
}

let id player =
  player.id

let name player =
  player.name

let current_location_id player =
  player.current_location_id

let balance player =
  player.balance

let property_list player =
  player.property_list

let in_jail player =
  player.in_jail

let change_jail player value =
  {player with in_jail = value}

let set_location player location_id =
  {player with current_location_id=location_id} 

let move player int' = 
  if (player.current_location_id + int') > 39 then 
    {player with current_location_id = (player.current_location_id + int') mod 39;
                 balance = player.balance + 200} 
  else 
    {player with current_location_id = (player.current_location_id + int') } 

let is_bankrupt player =
  player.balance <= 0

let update_balance player amount = 
  {player with balance = player.balance + amount}

let add_property player property = 
  {player with property_list =  property :: property_list player}

(**[find_player] returns player with name [find] in [playerlist] *)
let rec find_player find playerlist =
  match playerlist with
  | [] -> raise (UnknownPlayer find)
  | h :: t -> if String.equal h.name find then h else find_player find t

let player1 : player = {
  id = 1;
  name = "Meghana";
  current_location_id = 1;
  balance = 1500;
  property_list = [];
  in_jail = false
}

let player2 : player = {
  id = 2;
  name = "Michelle";
  current_location_id = 1;
  balance = 1500;
  property_list = [];
  in_jail = false
}

let player3 : player = {
  id = 3;
  name = "Aaron";
  current_location_id = 1;
  balance = 1500;
  property_list = [];
  in_jail = false
}

let player4 : player = {
  id = 4;
  name = "Amy";
  current_location_id = 1;
  balance = 1500;
  property_list = [];
  in_jail = false
}

let playerlist = [player1; player2; player3; player4;]

(* TEST CASES *)
let sample_player_test : player = {
  id = 5;
  name = "catpotato";
  current_location_id = 11;
  balance = 400;
  property_list = [get_property space3; get_property space7;get_property space39];
  in_jail = false
}

let player6 : player = {
  id = 1;
  name = "Meghana";
  current_location_id = 1;
  balance = 1300;
  property_list = [];
  in_jail = false
}