(* Note: You may introduce new code anywhere in this file. *) 

(* type object_phrase = string list *)

type jail_command = 
  | Pay | Card | Roll

type buy_command = 
  | Yes | No 

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

