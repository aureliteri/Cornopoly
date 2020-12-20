open Space

exception UnknownPlayer of string

type player = {
  id : int;
  name : string;
  current_location_id : int; 
  balance : int;
  property_list: (property * int) list;
  in_jail: bool;
  jail_card: bool;
  jail_count: int ref;
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

let jail_card player =
  player.jail_card

let jail_count player = 
  player.jail_count 

let change_jail_card player bool=
  {player with jail_card = bool}

let change_jail player value =
  {player with in_jail = value}

let set_location player location_id =
  {player with current_location_id = location_id} 

let move player int' = 
  if (player.current_location_id + int') > 39 then 
    begin
      print_endline "You have passed go! $200 has been added to your balance.";
      {player with current_location_id = 
                     (player.current_location_id + int') mod 39;
                   balance = player.balance + 200}
    end
  else {player with current_location_id = (player.current_location_id + int')} 

let move_to_space player int' =
  if (int' = 10) then 
    {player with current_location_id = int'; in_jail = true}
  else {player with current_location_id = int'}

let is_bankrupt player =
  player.balance <= 0

let update_name player new_name = 
  {player with name = new_name }

let update_balance player amount = 
  {player with balance = player.balance + amount}

let add_property player level property = 
  if List.mem_assoc property (property_list player) then
    let new_lst = List.map (fun (prop,lev) ->
        if property_name prop = property_name property
        then (property, level) else (prop, lev)) (property_list player) in
    {player with property_list = new_lst}
  else
    {player with property_list = (property, level) :: (property_list player)}

let remove_property player property =
  let new_property_list = List.filter 
      (fun (prop,lev) -> property_id property != property_id prop) 
      (property_list player)
  in {player with property_list = new_property_list}

let replace_player playerlist new_player =
  List.map(fun x -> if id x = id new_player then new_player else x) playerlist

let rec find_player find playerlist =
  match playerlist with
  | [] -> raise (UnknownPlayer find)
  | h :: t -> if String.equal h.name find 
    then h else find_player find t


let player1 : player = {
  id = 1;
  name = "Meghana";
  current_location_id = 1;
  balance = 3000;
  property_list = [];
  in_jail = false;
  jail_card = false;
  jail_count = ref 0;
}

let player2 = {player1 with id =2}
let player3 = {player1 with id =3}
let player4 = {player1 with id = 4}

let sample_player = {
  id = 4;
  name = "catpotato";
  current_location_id = 11;
  balance = 400;
  property_list = [(get_property space3, 0);(get_property space7,1);
                   (get_property space39, 2)];
  in_jail = false;
  jail_card = false;
  jail_count = ref 0;
}

let player_brown_full_test = {
  sample_player with 
  id = 7;
  property_list = [(get_property space34,0);(get_property space35,0);
                   (get_property space37,0)];
}

let player_pink_full_test = {
  sample_player with 
  id = 7;
  property_list = [(get_property space27,0);(get_property space28,0);
                   (get_property space29,0)];
}

let player_blue_full_test = {
  sample_player with 
  id = 6;
  property_list = [(get_property space38,0); (get_property space39,0)];
}

let player_yellow_full_test = {
  sample_player with
  id = 5;
  current_location_id = 11;
  balance = 400;
  property_list = [(get_property space6, 0);(get_property space7,1);
                   (get_property space8,1)];
}

let player_blood_full_test = {
  sample_player with
  id = 9;
  property_list = [(get_property space54,0);(get_property space56,0);
                   (get_property space57,0)];
}

let player_not_full_test = {
  sample_player with
  id = 5;
  property_list = [(get_property space7,1);(get_property space8,1)];
}

let playerlist = [player1; player2; player3; player4;]

let remove_player player plist=
  List.filter (fun x -> (x.id != player.id)) plist
