type jail_command = 
  | Pay 
  | Card 
  | Roll

type buy_command = 
  | Yes 
  | No 

type board_choice = 
  | Dark
  | Normal

exception Empty

exception Malformed


let parse_jail str =
  let to_lst = 
    str |> String.lowercase_ascii |> String.split_on_char ' '
    |> List.filter (fun x -> x <> "") in 
  match to_lst with
  | h :: t -> begin
      if h = "pay" && t == [] then Pay
      else if h = "card" && t == [] then Card
      else if h = "roll" && t == [] then Roll
      else raise Malformed
    end
  | [] -> raise Empty

let parse_buy str =
  let to_lst = 
    str |> String.lowercase_ascii |> String.split_on_char ' '
    |> List.filter (fun x -> x <> "") in 
  match to_lst with
  | h :: t -> begin
      if h = "yes" && t == [] then Yes
      else if h = "no" && t == [] then No
      else raise Malformed
    end
  | [] -> raise Empty

let parse_board_choice str =
  let to_lst = 
    str |> String.lowercase_ascii |> String.split_on_char ' '
    |> List.filter (fun x -> x <> "") in 
  match to_lst with
  | h :: t -> begin
      if h = "dark" && t == [] then Dark
      else if h = "normal" && t == [] then Normal
      else raise Malformed
    end
  | [] -> raise Empty

let parse_level_input str = 
  let to_lst = 
    str |> String.lowercase_ascii |> String.split_on_char ' '
    |> List.filter (fun x -> x <> "") in
  try
    let num = int_of_string_opt (List.hd to_lst) in
    match num with
    | None -> raise Malformed
    | Some x -> if x < 0 || x > 3 then raise Malformed else x
  with _ -> raise Empty
