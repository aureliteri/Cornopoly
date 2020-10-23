open Player
open Card
open Space

let roll_dice =
  let d1 = Random.int 6 +1 in
  let d2 = Random.int 6 +1 in
  d1 + d2

let pick_card size =
  let ind = Random.int size in
  Array.get cardlist ind

let rec iterate playerlist (lst: Player.player list) =
  match playerlist with 
  | [] -> lst
  | h :: t -> begin
      iterate playerlist ((move h roll_dice) :: lst)
    end

let update_board playerlist =
  iterate playerlist []


