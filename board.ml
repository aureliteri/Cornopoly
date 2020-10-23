open Player
open Card
open Space

let roll_dice =
  let result = Random.int 10 +2 in
  result

let pick_card size =
  let ind = Random.int size in
  Array.get cardlist ind

