(* Note: You may introduce new code anywhere in this file. *) 

(* type object_phrase = string list *)

type jail_command = 
  | Pay | Card | Roll

exception Empty

exception Malformed

let parse_jail str =
  let to_lst = 
    str |> String.lowercase_ascii |> String.split_on_char ' '|> List.filter (fun x -> x <> "") in 
  match to_lst with
  | h :: t -> begin
      if h = "pay" && t == [] then Pay
      else if h = "card" && t == [] then Card
      else if h = "roll" then Roll
      else raise Malformed
    end
  | [] -> raise Empty

