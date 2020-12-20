type jail_command = 
  | Pay 
  | Card 
  | Roll

type buy_command = 
  | Yes 
  | No 


type board_choice = 
  | Dark
  | Classic

exception Empty

exception Malformed


let parse_jail str =
  let convert_lst = 
    str |> String.lowercase_ascii |> String.split_on_char ' '
    |> List.filter (fun x -> x <> "") in 
  match convert_lst with
  | h :: t -> begin
      if h = "pay" && t == [] then Pay
      else if h = "card" && t == [] then Card
      else if h = "roll" && t == [] then Roll
      else raise Malformed
    end
  | [] -> raise Empty

let parse_buy str =
  let convert_lst = 
    str |> String.lowercase_ascii |> String.split_on_char ' '
    |> List.filter (fun x -> x <> "") in 
  match convert_lst with
  | h :: t -> begin
      if h = "yes" && t == [] then Yes
      else if h = "no" && t == [] then No
      else raise Malformed
    end
  | [] -> raise Empty

let parse_board_choice str =
  let convert_lst = 
    str |> String.lowercase_ascii |> String.split_on_char ' '
    |> List.filter (fun x -> x <> "") in 
  match convert_lst with
  | h :: t -> begin
      if h = "dark" && t == [] then Dark
      else if h = "classic" && t == [] then Classic
      else raise Malformed
    end
  | [] -> raise Empty

let parse_level_input str = 
  let convert_lst = 
    str |> String.lowercase_ascii |> String.split_on_char ' '
    |> List.filter (fun x -> x <> "") in 
  match convert_lst with
  | h :: t -> begin
      if h = "0" && t == [] then 0
      else if h = "1" && t == [] then 1
      else if h = "2" && t == [] then 2
      else raise Malformed
    end
  | [] -> raise Empty