open Space

type player = {
  name : string;
  location_id : int;
  balance : int;
  prop_list: property list;
  in_jail: bool;
}

let move play int' = 
  let player' = { play with location_id = play.location_id + int' } in
  player'

let is_bankrupt player =
  if player.balance < 0 then true else false

