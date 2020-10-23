open Space

type player = {
  name : string;
  current_location_id : int; 
  balance : int;
  prop_list: property list;
  in_jail: bool;
}

let move play int' = 
  let player' = { play with current_location_id = play.current_location_id + int' } in
  player'

let is_bankrupt player =
  if player.balance < 0 then true else false

