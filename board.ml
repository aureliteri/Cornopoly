open Player
open Card
open Space

let roll_dice =
  let d1 = Random.int 6 +1 in
  let d2 = Random.int 6 +1 in
  d1+d2

let pick_card size =
  let ind = Random.int size in
  Array.get cardlist ind

let update_board playerlist =
  let rec iterate (lst: Player.player list) =
    match playerlist with 
    | [] -> lst
    | h :: t -> begin
        iterate ((move h roll_dice) :: lst)
      end
  in iterate []

let check_space (space1: space) player =
  match space1 with 
  | Property p -> begin
      if String.equal p.owner "" 
      then  
      else begin
        update_balance player (-1.0 *.p.rent);
        update_balance (find_player p.owner playerlist) p.rent

      end 
    end
  | CardSpace c-> ""
  | Jail j-> ""
  | Penalty p-> ""
  | Go g-> ""
  | JustVisiting jv-> ""
