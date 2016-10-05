module Config = Config_bspp
module Terminfo : sig 
#1 "terminfo.mli"
(***********************************************************************)
(*                                                                     *)
(*                                OCaml                                *)
(*                                                                     *)
(*            Xavier Leroy, projet Cristal, INRIA Rocquencourt         *)
(*                                                                     *)
(*  Copyright 1996 Institut National de Recherche en Informatique et   *)
(*  en Automatique.  All rights reserved.  This file is distributed    *)
(*  under the terms of the Q Public License version 1.0.               *)
(*                                                                     *)
(***********************************************************************)

(* Basic interface to the terminfo database *)

type status =
  | Uninitialised
  | Bad_term
  | Good_term of int  (* number of lines of the terminal *)
;;
external setup : out_channel -> status = "caml_terminfo_setup";;
external backup : int -> unit = "caml_terminfo_backup";;
external standout : bool -> unit = "caml_terminfo_standout";;
external resume : int -> unit = "caml_terminfo_resume";;

end = struct
#1 "terminfo.ml"
(***********************************************************************)
(*                                                                     *)
(*                                OCaml                                *)
(*                                                                     *)
(*            Xavier Leroy, projet Cristal, INRIA Rocquencourt         *)
(*                                                                     *)
(*  Copyright 1996 Institut National de Recherche en Informatique et   *)
(*  en Automatique.  All rights reserved.  This file is distributed    *)
(*  under the terms of the Q Public License version 1.0.               *)
(*                                                                     *)
(***********************************************************************)

(* Basic interface to the terminfo database *)

type status =
  | Uninitialised
  | Bad_term
  | Good_term of int
;;
external setup : out_channel -> status = "caml_terminfo_setup";;
external backup : int -> unit = "caml_terminfo_backup";;
external standout : bool -> unit = "caml_terminfo_standout";;
external resume : int -> unit = "caml_terminfo_resume";;

end
module Warnings : sig 
#1 "warnings.mli"
(***********************************************************************)
(*                                                                     *)
(*                                OCaml                                *)
(*                                                                     *)
(*            Pierre Weis && Damien Doligez, INRIA Rocquencourt        *)
(*                                                                     *)
(*  Copyright 1998 Institut National de Recherche en Informatique et   *)
(*  en Automatique.  All rights reserved.  This file is distributed    *)
(*  under the terms of the Q Public License version 1.0.               *)
(*                                                                     *)
(***********************************************************************)

open Format

type t =
  | Comment_start                           (*  1 *)
  | Comment_not_end                         (*  2 *)
  | Deprecated of string                    (*  3 *)
  | Fragile_match of string                 (*  4 *)
  | Partial_application                     (*  5 *)
  | Labels_omitted                          (*  6 *)
  | Method_override of string list          (*  7 *)
  | Partial_match of string                 (*  8 *)
  | Non_closed_record_pattern of string     (*  9 *)
  | Statement_type                          (* 10 *)
  | Unused_match                            (* 11 *)
  | Unused_pat                              (* 12 *)
  | Instance_variable_override of string list (* 13 *)
  | Illegal_backslash                       (* 14 *)
  | Implicit_public_methods of string list  (* 15 *)
  | Unerasable_optional_argument            (* 16 *)
  | Undeclared_virtual_method of string     (* 17 *)
  | Not_principal of string                 (* 18 *)
  | Without_principality of string          (* 19 *)
  | Unused_argument                         (* 20 *)
  | Nonreturning_statement                  (* 21 *)
  | Preprocessor of string                  (* 22 *)
  | Useless_record_with                     (* 23 *)
  | Bad_module_name of string               (* 24 *)
  | All_clauses_guarded                     (* 25 *)
  | Unused_var of string                    (* 26 *)
  | Unused_var_strict of string             (* 27 *)
  | Wildcard_arg_to_constant_constr         (* 28 *)
  | Eol_in_string                           (* 29 *)
  | Duplicate_definitions of string * string * string * string (* 30 *)
  | Multiple_definition of string * string * string (* 31 *)
  | Unused_value_declaration of string      (* 32 *)
  | Unused_open of string                   (* 33 *)
  | Unused_type_declaration of string       (* 34 *)
  | Unused_for_index of string              (* 35 *)
  | Unused_ancestor of string               (* 36 *)
  | Unused_constructor of string * bool * bool (* 37 *)
  | Unused_extension of string * bool * bool   (* 38 *)
  | Unused_rec_flag                         (* 39 *)
  | Name_out_of_scope of string * string list * bool   (* 40 *)
  | Ambiguous_name of string list * string list * bool (* 41 *)
  | Disambiguated_name of string            (* 42 *)
  | Nonoptional_label of string             (* 43 *)
  | Open_shadow_identifier of string * string (* 44 *)
  | Open_shadow_label_constructor of string * string (* 45 *)
  | Bad_env_variable of string * string     (* 46 *)
  | Attribute_payload of string * string    (* 47 *)
  | Eliminated_optional_arguments of string list (* 48 *)
  | No_cmi_file of string                   (* 49 *)
  | Bad_docstring of bool                   (* 50 *)
;;

val parse_options : bool -> string -> unit;;

val is_active : t -> bool;;
val is_error : t -> bool;;

val defaults_w : string;;
val defaults_warn_error : string;;

val print : formatter -> t -> unit;;

exception Errors of int;;

val check_fatal : unit -> unit;;

val help_warnings: unit -> unit

type state
val backup: unit -> state
val restore: state -> unit

end = struct
#1 "warnings.ml"
(***********************************************************************)
(*                                                                     *)
(*                                OCaml                                *)
(*                                                                     *)
(*            Pierre Weis && Damien Doligez, INRIA Rocquencourt        *)
(*                                                                     *)
(*  Copyright 1998 Institut National de Recherche en Informatique et   *)
(*  en Automatique.  All rights reserved.  This file is distributed    *)
(*  under the terms of the Q Public License version 1.0.               *)
(*                                                                     *)
(***********************************************************************)

(* When you change this, you need to update the documentation:
   - man/ocamlc.m   in ocaml
   - man/ocamlopt.m in ocaml
   - manual/cmds/comp.etex   in the doc sources
   - manual/cmds/native.etex in the doc sources
*)

type t =
  | Comment_start                           (*  1 *)
  | Comment_not_end                         (*  2 *)
  | Deprecated of string                    (*  3 *)
  | Fragile_match of string                 (*  4 *)
  | Partial_application                     (*  5 *)
  | Labels_omitted                          (*  6 *)
  | Method_override of string list          (*  7 *)
  | Partial_match of string                 (*  8 *)
  | Non_closed_record_pattern of string     (*  9 *)
  | Statement_type                          (* 10 *)
  | Unused_match                            (* 11 *)
  | Unused_pat                              (* 12 *)
  | Instance_variable_override of string list (* 13 *)
  | Illegal_backslash                       (* 14 *)
  | Implicit_public_methods of string list  (* 15 *)
  | Unerasable_optional_argument            (* 16 *)
  | Undeclared_virtual_method of string     (* 17 *)
  | Not_principal of string                 (* 18 *)
  | Without_principality of string          (* 19 *)
  | Unused_argument                         (* 20 *)
  | Nonreturning_statement                  (* 21 *)
  | Preprocessor of string                  (* 22 *)
  | Useless_record_with                     (* 23 *)
  | Bad_module_name of string               (* 24 *)
  | All_clauses_guarded                     (* 25 *)
  | Unused_var of string                    (* 26 *)
  | Unused_var_strict of string             (* 27 *)
  | Wildcard_arg_to_constant_constr         (* 28 *)
  | Eol_in_string                           (* 29 *)
  | Duplicate_definitions of string * string * string * string (*30 *)
  | Multiple_definition of string * string * string (* 31 *)
  | Unused_value_declaration of string      (* 32 *)
  | Unused_open of string                   (* 33 *)
  | Unused_type_declaration of string       (* 34 *)
  | Unused_for_index of string              (* 35 *)
  | Unused_ancestor of string               (* 36 *)
  | Unused_constructor of string * bool * bool  (* 37 *)
  | Unused_extension of string * bool * bool    (* 38 *)
  | Unused_rec_flag                         (* 39 *)
  | Name_out_of_scope of string * string list * bool (* 40 *)
  | Ambiguous_name of string list * string list *  bool    (* 41 *)
  | Disambiguated_name of string            (* 42 *)
  | Nonoptional_label of string             (* 43 *)
  | Open_shadow_identifier of string * string (* 44 *)
  | Open_shadow_label_constructor of string * string (* 45 *)
  | Bad_env_variable of string * string     (* 46 *)
  | Attribute_payload of string * string    (* 47 *)
  | Eliminated_optional_arguments of string list (* 48 *)
  | No_cmi_file of string                   (* 49 *)
  | Bad_docstring of bool                   (* 50 *)
;;

(* If you remove a warning, leave a hole in the numbering.  NEVER change
   the numbers of existing warnings.
   If you add a new warning, add it at the end with a new number;
   do NOT reuse one of the holes.
*)

let number = function
  | Comment_start -> 1
  | Comment_not_end -> 2
  | Deprecated _ -> 3
  | Fragile_match _ -> 4
  | Partial_application -> 5
  | Labels_omitted -> 6
  | Method_override _ -> 7
  | Partial_match _ -> 8
  | Non_closed_record_pattern _ -> 9
  | Statement_type -> 10
  | Unused_match -> 11
  | Unused_pat -> 12
  | Instance_variable_override _ -> 13
  | Illegal_backslash -> 14
  | Implicit_public_methods _ -> 15
  | Unerasable_optional_argument -> 16
  | Undeclared_virtual_method _ -> 17
  | Not_principal _ -> 18
  | Without_principality _ -> 19
  | Unused_argument -> 20
  | Nonreturning_statement -> 21
  | Preprocessor _ -> 22
  | Useless_record_with -> 23
  | Bad_module_name _ -> 24
  | All_clauses_guarded -> 25
  | Unused_var _ -> 26
  | Unused_var_strict _ -> 27
  | Wildcard_arg_to_constant_constr -> 28
  | Eol_in_string -> 29
  | Duplicate_definitions _ -> 30
  | Multiple_definition _ -> 31
  | Unused_value_declaration _ -> 32
  | Unused_open _ -> 33
  | Unused_type_declaration _ -> 34
  | Unused_for_index _ -> 35
  | Unused_ancestor _ -> 36
  | Unused_constructor _ -> 37
  | Unused_extension _ -> 38
  | Unused_rec_flag -> 39
  | Name_out_of_scope _ -> 40
  | Ambiguous_name _ -> 41
  | Disambiguated_name _ -> 42
  | Nonoptional_label _ -> 43
  | Open_shadow_identifier _ -> 44
  | Open_shadow_label_constructor _ -> 45
  | Bad_env_variable _ -> 46
  | Attribute_payload _ -> 47
  | Eliminated_optional_arguments _ -> 48
  | No_cmi_file _ -> 49
  | Bad_docstring _ -> 50
;;

let last_warning_number = 50
(* Must be the max number returned by the [number] function. *)

let letter = function
  | 'a' ->
     let rec loop i = if i = 0 then [] else i :: loop (i - 1) in
     loop last_warning_number
  | 'b' -> []
  | 'c' -> [1; 2]
  | 'd' -> [3]
  | 'e' -> [4]
  | 'f' -> [5]
  | 'g' -> []
  | 'h' -> []
  | 'i' -> []
  | 'j' -> []
  | 'k' -> [32; 33; 34; 35; 36; 37; 38; 39]
  | 'l' -> [6]
  | 'm' -> [7]
  | 'n' -> []
  | 'o' -> []
  | 'p' -> [8]
  | 'q' -> []
  | 'r' -> [9]
  | 's' -> [10]
  | 't' -> []
  | 'u' -> [11; 12]
  | 'v' -> [13]
  | 'w' -> []
  | 'x' -> [14; 15; 16; 17; 18; 19; 20; 21; 22; 23; 24; 25; 30]
  | 'y' -> [26]
  | 'z' -> [27]
  | _ -> assert false
;;

type state =
  {
    active: bool array;
    error: bool array;
  }

let current =
  ref
    {
      active = Array.make (last_warning_number + 1) true;
      error = Array.make (last_warning_number + 1) false;
    }

let backup () = !current

let restore x = current := x

let is_active x = (!current).active.(number x);;
let is_error x = (!current).error.(number x);;

let parse_opt error active flags s =
  let set i = flags.(i) <- true in
  let clear i = flags.(i) <- false in
  let set_all i = active.(i) <- true; error.(i) <- true in
  let error () = raise (Arg.Bad "Ill-formed list of warnings") in
  let rec get_num n i =
    if i >= String.length s then i, n
    else match s.[i] with
    | '0'..'9' -> get_num (10 * n + Char.code s.[i] - Char.code '0') (i + 1)
    | _ -> i, n
  in
  let get_range i =
    let i, n1 = get_num 0 i in
    if i + 2 < String.length s && s.[i] = '.' && s.[i + 1] = '.' then
      let i, n2 = get_num 0 (i + 2) in
      if n2 < n1 then error ();
      i, n1, n2
    else
      i, n1, n1
  in
  let rec loop i =
    if i >= String.length s then () else
    match s.[i] with
    | 'A' .. 'Z' ->
       List.iter set (letter (Char.lowercase s.[i]));
       loop (i+1)
    | 'a' .. 'z' ->
       List.iter clear (letter s.[i]);
       loop (i+1)
    | '+' -> loop_letter_num set (i+1)
    | '-' -> loop_letter_num clear (i+1)
    | '@' -> loop_letter_num set_all (i+1)
    | c -> error ()
  and loop_letter_num myset i =
    if i >= String.length s then error () else
    match s.[i] with
    | '0' .. '9' ->
        let i, n1, n2 = get_range i in
        for n = n1 to min n2 last_warning_number do myset n done;
        loop i
    | 'A' .. 'Z' ->
       List.iter myset (letter (Char.lowercase s.[i]));
       loop (i+1)
    | 'a' .. 'z' ->
       List.iter myset (letter s.[i]);
       loop (i+1)
    | _ -> error ()
  in
  loop 0
;;

let parse_options errflag s =
  let error = Array.copy (!current).error in
  let active = Array.copy (!current).active in
  parse_opt error active (if errflag then error else active) s;
  current := {error; active}

(* If you change these, don't forget to change them in man/ocamlc.m *)
let defaults_w = "+a-4-6-7-9-27-29-32..39-41..42-44-45-48-50";;
let defaults_warn_error = "-a";;

let () = parse_options false defaults_w;;
let () = parse_options true defaults_warn_error;;

let message = function
  | Comment_start -> "this is the start of a comment."
  | Comment_not_end -> "this is not the end of a comment."
  | Deprecated s -> "deprecated: " ^ s
  | Fragile_match "" ->
      "this pattern-matching is fragile."
  | Fragile_match s ->
      "this pattern-matching is fragile.\n\
       It will remain exhaustive when constructors are added to type " ^ s ^ "."
  | Partial_application ->
      "this function application is partial,\n\
       maybe some arguments are missing."
  | Labels_omitted ->
      "labels were omitted in the application of this function."
  | Method_override [lab] ->
      "the method " ^ lab ^ " is overridden."
  | Method_override (cname :: slist) ->
      String.concat " "
        ("the following methods are overridden by the class"
         :: cname  :: ":\n " :: slist)
  | Method_override [] -> assert false
  | Partial_match "" -> "this pattern-matching is not exhaustive."
  | Partial_match s ->
      "this pattern-matching is not exhaustive.\n\
       Here is an example of a value that is not matched:\n" ^ s
  | Non_closed_record_pattern s ->
      "the following labels are not bound in this record pattern:\n" ^ s ^
      "\nEither bind these labels explicitly or add '; _' to the pattern."
  | Statement_type ->
      "this expression should have type unit."
  | Unused_match -> "this match case is unused."
  | Unused_pat   -> "this sub-pattern is unused."
  | Instance_variable_override [lab] ->
      "the instance variable " ^ lab ^ " is overridden.\n" ^
      "The behaviour changed in ocaml 3.10 (previous behaviour was hiding.)"
  | Instance_variable_override (cname :: slist) ->
      String.concat " "
        ("the following instance variables are overridden by the class"
         :: cname  :: ":\n " :: slist) ^
      "\nThe behaviour changed in ocaml 3.10 (previous behaviour was hiding.)"
  | Instance_variable_override [] -> assert false
  | Illegal_backslash -> "illegal backslash escape in string."
  | Implicit_public_methods l ->
      "the following private methods were made public implicitly:\n "
      ^ String.concat " " l ^ "."
  | Unerasable_optional_argument -> "this optional argument cannot be erased."
  | Undeclared_virtual_method m -> "the virtual method "^m^" is not declared."
  | Not_principal s -> s^" is not principal."
  | Without_principality s -> s^" without principality."
  | Unused_argument -> "this argument will not be used by the function."
  | Nonreturning_statement ->
      "this statement never returns (or has an unsound type.)"
  | Preprocessor s -> s
  | Useless_record_with ->
      "all the fields are explicitly listed in this record:\n\
       the 'with' clause is useless."
  | Bad_module_name (modname) ->
      "bad source file name: \"" ^ modname ^ "\" is not a valid module name."
  | All_clauses_guarded ->
      "bad style, all clauses in this pattern-matching are guarded."
  | Unused_var v | Unused_var_strict v -> "unused variable " ^ v ^ "."
  | Wildcard_arg_to_constant_constr ->
     "wildcard pattern given as argument to a constant constructor"
  | Eol_in_string ->
     "unescaped end-of-line in a string constant (non-portable code)"
  | Duplicate_definitions (kind, cname, tc1, tc2) ->
      Printf.sprintf "the %s %s is defined in both types %s and %s."
        kind cname tc1 tc2
  | Multiple_definition(modname, file1, file2) ->
      Printf.sprintf
        "files %s and %s both define a module named %s"
        file1 file2 modname
  | Unused_value_declaration v -> "unused value " ^ v ^ "."
  | Unused_open s -> "unused open " ^ s ^ "."
  | Unused_type_declaration s -> "unused type " ^ s ^ "."
  | Unused_for_index s -> "unused for-loop index " ^ s ^ "."
  | Unused_ancestor s -> "unused ancestor variable " ^ s ^ "."
  | Unused_constructor (s, false, false) -> "unused constructor " ^ s ^ "."
  | Unused_constructor (s, true, _) ->
      "constructor " ^ s ^
      " is never used to build values.\n\
        (However, this constructor appears in patterns.)"
  | Unused_constructor (s, false, true) ->
      "constructor " ^ s ^
      " is never used to build values.\n\
        Its type is exported as a private type."
  | Unused_extension (s, false, false) ->
      "unused extension constructor " ^ s ^ "."
  | Unused_extension (s, true, _) ->
      "extension constructor " ^ s ^
      " is never used to build values.\n\
        (However, this constructor appears in patterns.)"
  | Unused_extension (s, false, true) ->
      "extension constructor " ^ s ^
      " is never used to build values.\n\
        It is exported or rebound as a private extension."
  | Unused_rec_flag ->
      "unused rec flag."
  | Name_out_of_scope (ty, [nm], false) ->
      nm ^ " was selected from type " ^ ty ^
      ".\nIt is not visible in the current scope, and will not \n\
       be selected if the type becomes unknown."
  | Name_out_of_scope (_, _, false) -> assert false
  | Name_out_of_scope (ty, slist, true) ->
      "this record of type "^ ty ^" contains fields that are \n\
       not visible in the current scope: "
      ^ String.concat " " slist ^ ".\n\
       They will not be selected if the type becomes unknown."
  | Ambiguous_name ([s], tl, false) ->
      s ^ " belongs to several types: " ^ String.concat " " tl ^
      "\nThe first one was selected. Please disambiguate if this is wrong."
  | Ambiguous_name (_, _, false) -> assert false
  | Ambiguous_name (slist, tl, true) ->
      "these field labels belong to several types: " ^
      String.concat " " tl ^
      "\nThe first one was selected. Please disambiguate if this is wrong."
  | Disambiguated_name s ->
      "this use of " ^ s ^ " required disambiguation."
  | Nonoptional_label s ->
      "the label " ^ s ^ " is not optional."
  | Open_shadow_identifier (kind, s) ->
      Printf.sprintf
        "this open statement shadows the %s identifier %s (which is later used)"
        kind s
  | Open_shadow_label_constructor (kind, s) ->
      Printf.sprintf
        "this open statement shadows the %s %s (which is later used)"
        kind s
  | Bad_env_variable (var, s) ->
      Printf.sprintf "illegal environment variable %s : %s" var s
  | Attribute_payload (a, s) ->
      Printf.sprintf "illegal payload for attribute '%s'.\n%s" a s
  | Eliminated_optional_arguments sl ->
      Printf.sprintf "implicit elimination of optional argument%s %s"
        (if List.length sl = 1 then "" else "s")
        (String.concat ", " sl)
  | No_cmi_file s ->
      "no cmi file was found in path for module " ^ s
  | Bad_docstring unattached ->
      if unattached then "unattached documentation comment (ignored)"
      else "ambiguous documentation comment"
;;

let nerrors = ref 0;;

let print ppf w =
  let msg = message w in
  let num = number w in
  Format.fprintf ppf "%d: %s" num msg;
  Format.pp_print_flush ppf ();
  if (!current).error.(num) then incr nerrors
;;

exception Errors of int;;

let check_fatal () =
  if !nerrors > 0 then begin
    let e = Errors !nerrors in
    nerrors := 0;
    raise e;
  end;
;;

let descriptions =
  [
    1, "Suspicious-looking start-of-comment mark.";
    2, "Suspicious-looking end-of-comment mark.";
    3, "Deprecated feature.";
    4, "Fragile pattern matching: matching that will remain complete even\n\
   \    if additional constructors are added to one of the variant types\n\
   \    matched.";
    5, "Partially applied function: expression whose result has function\n\
   \    type and is ignored.";
    6, "Label omitted in function application.";
    7, "Method overridden.";
    8, "Partial match: missing cases in pattern-matching.";
    9, "Missing fields in a record pattern.";
   10, "Expression on the left-hand side of a sequence that doesn't have type\n\
   \    \"unit\" (and that is not a function, see warning number 5).";
   11, "Redundant case in a pattern matching (unused match case).";
   12, "Redundant sub-pattern in a pattern-matching.";
   13, "Instance variable overridden.";
   14, "Illegal backslash escape in a string constant.";
   15, "Private method made public implicitly.";
   16, "Unerasable optional argument.";
   17, "Undeclared virtual method.";
   18, "Non-principal type.";
   19, "Type without principality.";
   20, "Unused function argument.";
   21, "Non-returning statement.";
   22, "Proprocessor warning.";
   23, "Useless record \"with\" clause.";
   24, "Bad module name: the source file name is not a valid OCaml module \
        name.";
   25, "Pattern-matching with all clauses guarded.  Exhaustiveness cannot be\n\
   \    checked.";
   26, "Suspicious unused variable: unused variable that is bound\n\
   \    with \"let\" or \"as\", and doesn't start with an underscore (\"_\")\n\
   \    character.";
   27, "Innocuous unused variable: unused variable that is not bound with\n\
   \    \"let\" nor \"as\", and doesn't start with an underscore (\"_\")\n\
   \    character.";
   28, "Wildcard pattern given as argument to a constant constructor.";
   29, "Unescaped end-of-line in a string constant (non-portable code).";
   30, "Two labels or constructors of the same name are defined in two\n\
   \    mutually recursive types.";
   31, "A module is linked twice in the same executable.";
   32, "Unused value declaration.";
   33, "Unused open statement.";
   34, "Unused type declaration.";
   35, "Unused for-loop index.";
   36, "Unused ancestor variable.";
   37, "Unused constructor.";
   38, "Unused extension constructor.";
   39, "Unused rec flag.";
   40, "Constructor or label name used out of scope.";
   41, "Ambiguous constructor or label name.";
   42, "Disambiguated constructor or label name.";
   43, "Nonoptional label applied as optional.";
   44, "Open statement shadows an already defined identifier.";
   45, "Open statement shadows an already defined label or constructor.";
   46, "Error in environment variable.";
   47, "Illegal attribute payload.";
   48, "Implicit elimination of optional arguments.";
   49, "Missing cmi file when looking up module alias.";
   50, "Unexpected documentation comment.";
  ]
;;

let help_warnings () =
  List.iter (fun (i, s) -> Printf.printf "%3i %s\n" i s) descriptions;
  print_endline "  A all warnings";
  for i = Char.code 'b' to Char.code 'z' do
    let c = Char.chr i in
    match letter c with
    | [] -> ()
    | [n] ->
        Printf.printf "  %c warning %i\n" (Char.uppercase c) n
    | l ->
        Printf.printf "  %c warnings %s.\n"
          (Char.uppercase c)
          (String.concat ", " (List.map string_of_int l))
  done;
  exit 0
;;

end
module Location : sig 
#1 "location.mli"
(***********************************************************************)
(*                                                                     *)
(*                                OCaml                                *)
(*                                                                     *)
(*            Xavier Leroy, projet Cristal, INRIA Rocquencourt         *)
(*                                                                     *)
(*  Copyright 1996 Institut National de Recherche en Informatique et   *)
(*  en Automatique.  All rights reserved.  This file is distributed    *)
(*  under the terms of the Q Public License version 1.0.               *)
(*                                                                     *)
(***********************************************************************)

(* Source code locations (ranges of positions), used in parsetree. *)

open Format

type t = {
  loc_start: Lexing.position;
  loc_end: Lexing.position;
  loc_ghost: bool;
}

(* Note on the use of Lexing.position in this module.
   If [pos_fname = ""], then use [!input_name] instead.
   If [pos_lnum = -1], then [pos_bol = 0]. Use [pos_cnum] and
     re-parse the file to get the line and character numbers.
   Else all fields are correct.
*)

val none : t
(** An arbitrary value of type [t]; describes an empty ghost range. *)

val in_file : string -> t
(** Return an empty ghost range located in a given file. *)

val init : Lexing.lexbuf -> string -> unit
(** Set the file name and line number of the [lexbuf] to be the start
    of the named file. *)

val curr : Lexing.lexbuf -> t
(** Get the location of the current token from the [lexbuf]. *)

val symbol_rloc: unit -> t
val symbol_gloc: unit -> t

(** [rhs_loc n] returns the location of the symbol at position [n], starting
  at 1, in the current parser rule. *)
val rhs_loc: int -> t

val input_name: string ref
val input_lexbuf: Lexing.lexbuf option ref

val get_pos_info: Lexing.position -> string * int * int (* file, line, char *)
val print_loc: formatter -> t -> unit
val print_error: formatter -> t -> unit
val print_error_cur_file: formatter -> unit
val print_warning: t -> formatter -> Warnings.t -> unit
val formatter_for_warnings : formatter ref
val prerr_warning: t -> Warnings.t -> unit
val echo_eof: unit -> unit
val reset: unit -> unit

val warning_printer : (t -> formatter -> Warnings.t -> unit) ref
(** Hook for intercepting warnings. *)

val default_warning_printer : t -> formatter -> Warnings.t -> unit
(** Original warning printer for use in hooks. *)

val highlight_locations: formatter -> t list -> bool

type 'a loc = {
  txt : 'a;
  loc : t;
}

val mknoloc : 'a -> 'a loc
val mkloc : 'a -> t -> 'a loc

val print: formatter -> t -> unit
val print_filename: formatter -> string -> unit

val absolute_path: string -> string

val show_filename: string -> string
    (** In -absname mode, return the absolute path for this filename.
        Otherwise, returns the filename unchanged. *)


val absname: bool ref


(* Support for located errors *)

type error =
  {
    loc: t;
    msg: string;
    sub: error list;
    if_highlight: string; (* alternative message if locations are highlighted *)
  }

exception Error of error

val error: ?loc:t -> ?sub:error list -> ?if_highlight:string -> string -> error

val errorf: ?loc:t -> ?sub:error list -> ?if_highlight:string
            -> ('a, unit, string, error) format4 -> 'a

val raise_errorf: ?loc:t -> ?sub:error list -> ?if_highlight:string
            -> ('a, unit, string, 'b) format4 -> 'a

val error_of_printer: t -> (formatter -> 'a -> unit) -> 'a -> error

val error_of_printer_file: (formatter -> 'a -> unit) -> 'a -> error

val error_of_exn: exn -> error option

val register_error_of_exn: (exn -> error option) -> unit
  (* Each compiler module which defines a custom type of exception
     which can surface as a user-visible error should register
     a "printer" for this exception using [register_error_of_exn].
     The result of the printer is an [error] value containing
     a location, a message, and optionally sub-messages (each of them
     being located as well). *)

val report_error: formatter -> error -> unit

val error_reporter : (formatter -> error -> unit) ref
(** Hook for intercepting error reports. *)

val default_error_reporter : formatter -> error -> unit
(** Original error reporter for use in hooks. *)

val report_exception: formatter -> exn -> unit
  (* Reraise the exception if it is unknown. *)

end = struct
#1 "location.ml"
(***********************************************************************)
(*                                                                     *)
(*                                OCaml                                *)
(*                                                                     *)
(*            Xavier Leroy, projet Cristal, INRIA Rocquencourt         *)
(*                                                                     *)
(*  Copyright 1996 Institut National de Recherche en Informatique et   *)
(*  en Automatique.  All rights reserved.  This file is distributed    *)
(*  under the terms of the Q Public License version 1.0.               *)
(*                                                                     *)
(***********************************************************************)

open Lexing

let absname = ref false
    (* This reference should be in Clflags, but it would create an additional
       dependency and make bootstrapping Camlp4 more difficult. *)

type t = { loc_start: position; loc_end: position; loc_ghost: bool };;

let in_file name =
  let loc = {
    pos_fname = name;
    pos_lnum = 1;
    pos_bol = 0;
    pos_cnum = -1;
  } in
  { loc_start = loc; loc_end = loc; loc_ghost = true }
;;

let none = in_file "_none_";;

let curr lexbuf = {
  loc_start = lexbuf.lex_start_p;
  loc_end = lexbuf.lex_curr_p;
  loc_ghost = false
};;

let init lexbuf fname =
  lexbuf.lex_curr_p <- {
    pos_fname = fname;
    pos_lnum = 1;
    pos_bol = 0;
    pos_cnum = 0;
  }
;;

let symbol_rloc () = {
  loc_start = Parsing.symbol_start_pos ();
  loc_end = Parsing.symbol_end_pos ();
  loc_ghost = false;
};;

let symbol_gloc () = {
  loc_start = Parsing.symbol_start_pos ();
  loc_end = Parsing.symbol_end_pos ();
  loc_ghost = true;
};;

let rhs_loc n = {
  loc_start = Parsing.rhs_start_pos n;
  loc_end = Parsing.rhs_end_pos n;
  loc_ghost = false;
};;

let input_name = ref "_none_"
let input_lexbuf = ref (None : lexbuf option)

(* Terminal info *)

let status = ref Terminfo.Uninitialised

let num_loc_lines = ref 0 (* number of lines already printed after input *)

let print_updating_num_loc_lines ppf f arg =
  let open Format in
  let out_functions = pp_get_formatter_out_functions ppf () in
  let out_string str start len =
    let rec count i c =
      if i = start + len then c
      else if String.get str i = '\n' then count (succ i) (succ c)
      else count (succ i) c in
    num_loc_lines := !num_loc_lines + count start 0 ;
    out_functions.out_string str start len in
  pp_set_formatter_out_functions ppf
    { out_functions with out_string } ;
  f ppf arg ;
  pp_print_flush ppf ();
  pp_set_formatter_out_functions ppf out_functions

(* Highlight the locations using standout mode. *)

let highlight_terminfo ppf num_lines lb locs =
  Format.pp_print_flush ppf ();  (* avoid mixing Format and normal output *)
  (* Char 0 is at offset -lb.lex_abs_pos in lb.lex_buffer. *)
  let pos0 = -lb.lex_abs_pos in
  (* Do nothing if the buffer does not contain the whole phrase. *)
  if pos0 < 0 then raise Exit;
  (* Count number of lines in phrase *)
  let lines = ref !num_loc_lines in
  for i = pos0 to lb.lex_buffer_len - 1 do
    if Bytes.get lb.lex_buffer i = '\n' then incr lines
  done;
  (* If too many lines, give up *)
  if !lines >= num_lines - 2 then raise Exit;
  (* Move cursor up that number of lines *)
  flush stdout; Terminfo.backup !lines;
  (* Print the input, switching to standout for the location *)
  let bol = ref false in
  print_string "# ";
  for pos = 0 to lb.lex_buffer_len - pos0 - 1 do
    if !bol then (print_string "  "; bol := false);
    if List.exists (fun loc -> pos = loc.loc_start.pos_cnum) locs then
      Terminfo.standout true;
    if List.exists (fun loc -> pos = loc.loc_end.pos_cnum) locs then
      Terminfo.standout false;
    let c = Bytes.get lb.lex_buffer (pos + pos0) in
    print_char c;
    bol := (c = '\n')
  done;
  (* Make sure standout mode is over *)
  Terminfo.standout false;
  (* Position cursor back to original location *)
  Terminfo.resume !num_loc_lines;
  flush stdout

(* Highlight the location by printing it again. *)

let highlight_dumb ppf lb loc =
  (* Char 0 is at offset -lb.lex_abs_pos in lb.lex_buffer. *)
  let pos0 = -lb.lex_abs_pos in
  (* Do nothing if the buffer does not contain the whole phrase. *)
  if pos0 < 0 then raise Exit;
  let end_pos = lb.lex_buffer_len - pos0 - 1 in
  (* Determine line numbers for the start and end points *)
  let line_start = ref 0 and line_end = ref 0 in
  for pos = 0 to end_pos do
    if Bytes.get lb.lex_buffer (pos + pos0) = '\n' then begin
      if loc.loc_start.pos_cnum > pos then incr line_start;
      if loc.loc_end.pos_cnum   > pos then incr line_end;
    end
  done;
  (* Print character location (useful for Emacs) *)
  Format.fprintf ppf "Characters %i-%i:@."
                 loc.loc_start.pos_cnum loc.loc_end.pos_cnum;
  (* Print the input, underlining the location *)
  Format.pp_print_string ppf "  ";
  let line = ref 0 in
  let pos_at_bol = ref 0 in
  for pos = 0 to end_pos do
    match Bytes.get lb.lex_buffer (pos + pos0) with
    | '\n' ->
      if !line = !line_start && !line = !line_end then begin
        (* loc is on one line: underline location *)
        Format.fprintf ppf "@.  ";
        for _i = !pos_at_bol to loc.loc_start.pos_cnum - 1 do
          Format.pp_print_char ppf ' '
        done;
        for _i = loc.loc_start.pos_cnum to loc.loc_end.pos_cnum - 1 do
          Format.pp_print_char ppf '^'
        done
      end;
      if !line >= !line_start && !line <= !line_end then begin
        Format.fprintf ppf "@.";
        if pos < loc.loc_end.pos_cnum then Format.pp_print_string ppf "  "
      end;
      incr line;
      pos_at_bol := pos + 1
    | '\r' -> () (* discard *)
    | c ->
      if !line = !line_start && !line = !line_end then
        (* loc is on one line: print whole line *)
        Format.pp_print_char ppf c
      else if !line = !line_start then
        (* first line of multiline loc:
           print a dot for each char before loc_start *)
        if pos < loc.loc_start.pos_cnum then
          Format.pp_print_char ppf '.'
        else
          Format.pp_print_char ppf c
      else if !line = !line_end then
        (* last line of multiline loc: print a dot for each char
           after loc_end, even whitespaces *)
        if pos < loc.loc_end.pos_cnum then
          Format.pp_print_char ppf c
        else
          Format.pp_print_char ppf '.'
      else if !line > !line_start && !line < !line_end then
        (* intermediate line of multiline loc: print whole line *)
        Format.pp_print_char ppf c
  done

(* Highlight the location using one of the supported modes. *)

let rec highlight_locations ppf locs =
  match !status with
    Terminfo.Uninitialised ->
      status := Terminfo.setup stdout; highlight_locations ppf locs
  | Terminfo.Bad_term ->
      begin match !input_lexbuf with
        None -> false
      | Some lb ->
          let norepeat =
            try Sys.getenv "TERM" = "norepeat" with Not_found -> false in
          if norepeat then false else
            let loc1 = List.hd locs in
            try highlight_dumb ppf lb loc1; true
            with Exit -> false
      end
  | Terminfo.Good_term num_lines ->
      begin match !input_lexbuf with
        None -> false
      | Some lb ->
          try highlight_terminfo ppf num_lines lb locs; true
          with Exit -> false
      end

(* Print the location in some way or another *)

open Format

let absolute_path s = (* This function could go into Filename *)
  let open Filename in
  let s = if is_relative s then concat (Sys.getcwd ()) s else s in
  (* Now simplify . and .. components *)
  let rec aux s =
    let base = basename s in
    let dir = dirname s in
    if dir = s then dir
    else if base = current_dir_name then aux dir
    else if base = parent_dir_name then dirname (aux dir)
    else concat (aux dir) base
  in
  aux s

let show_filename file =
  if !absname then absolute_path file else file

let print_filename ppf file =
  Format.fprintf ppf "%s" (show_filename file)

let reset () =
  num_loc_lines := 0

let (msg_file, msg_line, msg_chars, msg_to, msg_colon) =
  ("File \"", "\", line ", ", characters ", "-", ":")

(* return file, line, char from the given position *)
let get_pos_info pos =
  (pos.pos_fname, pos.pos_lnum, pos.pos_cnum - pos.pos_bol)
;;

let print_loc ppf loc =
  let (file, line, startchar) = get_pos_info loc.loc_start in
  let endchar = loc.loc_end.pos_cnum - loc.loc_start.pos_cnum + startchar in
  if file = "//toplevel//" then begin
    if highlight_locations ppf [loc] then () else
      fprintf ppf "Characters %i-%i"
              loc.loc_start.pos_cnum loc.loc_end.pos_cnum
  end else begin
    fprintf ppf "%s%a%s%i" msg_file print_filename file msg_line line;
    if startchar >= 0 then
      fprintf ppf "%s%i%s%i" msg_chars startchar msg_to endchar
  end
;;

let print ppf loc =
  if loc.loc_start.pos_fname = "//toplevel//"
  && highlight_locations ppf [loc] then ()
  else fprintf ppf "%a%s@." print_loc loc msg_colon
;;

let print_error ppf loc =
  print ppf loc;
  fprintf ppf "Error: ";
;;

let print_error_cur_file ppf = print_error ppf (in_file !input_name);;

let default_warning_printer loc ppf w =
  if Warnings.is_active w then begin
    print ppf loc;
    fprintf ppf "Warning %a@." Warnings.print w
  end
;;

let warning_printer = ref default_warning_printer ;;

let print_warning loc ppf w =
  print_updating_num_loc_lines ppf (!warning_printer loc) w
;;

let formatter_for_warnings = ref err_formatter;;
let prerr_warning loc w = print_warning loc !formatter_for_warnings w;;

let echo_eof () =
  print_newline ();
  incr num_loc_lines

type 'a loc = {
  txt : 'a;
  loc : t;
}

let mkloc txt loc = { txt ; loc }
let mknoloc txt = mkloc txt none


type error =
  {
    loc: t;
    msg: string;
    sub: error list;
    if_highlight: string; (* alternative message if locations are highlighted *)
  }

let errorf ?(loc = none) ?(sub = []) ?(if_highlight = "") =
  Printf.ksprintf (fun msg -> {loc; msg; sub; if_highlight})

let error ?(loc = none) ?(sub = []) ?(if_highlight = "") msg =
  {loc; msg; sub; if_highlight}

let error_of_exn : (exn -> error option) list ref = ref []

let register_error_of_exn f = error_of_exn := f :: !error_of_exn

let error_of_exn exn =
  let rec loop = function
    | [] -> None
    | f :: rest ->
        match f exn with
        | Some _ as r -> r
        | None -> loop rest
  in
  loop !error_of_exn

let rec default_error_reporter ppf ({loc; msg; sub; if_highlight} as err) =
  let highlighted =
    if if_highlight <> "" then
      let rec collect_locs locs {loc; sub; if_highlight; _} =
        List.fold_left collect_locs (loc :: locs) sub
      in
      let locs = collect_locs [] err in
      highlight_locations ppf locs
    else
      false
  in
  if highlighted then
    Format.pp_print_string ppf if_highlight
  else begin
    print ppf loc;
    Format.pp_print_string ppf msg;
    List.iter (fun err -> Format.fprintf ppf "@\n@[<2>%a@]" default_error_reporter err)
              sub
  end

let error_reporter = ref default_error_reporter

let report_error ppf err =
  print_updating_num_loc_lines ppf !error_reporter err
;;

let error_of_printer loc print x =
  let buf = Buffer.create 64 in
  let ppf = Format.formatter_of_buffer buf in
  pp_print_string ppf "Error: ";
  print ppf x;
  pp_print_flush ppf ();
  let msg = Buffer.contents buf in
  errorf ~loc "%s" msg

let error_of_printer_file print x =
  error_of_printer (in_file !input_name) print x

let () =
  register_error_of_exn
    (function
      | Sys_error msg ->
          Some (errorf ~loc:(in_file !input_name) "Error: I/O error: %s" msg)
      | Warnings.Errors n ->
          Some
            (errorf ~loc:(in_file !input_name)
               "Error: Some fatal warnings were triggered (%d occurrences)" n)
      | _ ->
          None
    )


let rec report_exception_rec n ppf exn =
  try match error_of_exn exn with
  | Some err ->
      fprintf ppf "@[%a@]@." report_error err
  | None -> raise exn
  with exn when n > 0 ->
    report_exception_rec (n-1) ppf exn

let report_exception ppf exn = report_exception_rec 5 ppf exn


exception Error of error

let () =
  register_error_of_exn
    (function
      | Error e -> Some e
      | _ -> None
    )

let raise_errorf ?(loc = none) ?(sub = []) ?(if_highlight = "") =
  Printf.ksprintf (fun msg -> raise (Error ({loc; msg; sub; if_highlight})))

end
module Misc : sig 
#1 "misc.mli"
(***********************************************************************)
(*                                                                     *)
(*                                OCaml                                *)
(*                                                                     *)
(*            Xavier Leroy, projet Cristal, INRIA Rocquencourt         *)
(*                                                                     *)
(*  Copyright 1996 Institut National de Recherche en Informatique et   *)
(*  en Automatique.  All rights reserved.  This file is distributed    *)
(*  under the terms of the Q Public License version 1.0.               *)
(*                                                                     *)
(***********************************************************************)

(* Miscellaneous useful types and functions *)

val fatal_error: string -> 'a
exception Fatal_error

val try_finally : (unit -> 'a) -> (unit -> unit) -> 'a;;

val map_end: ('a -> 'b) -> 'a list -> 'b list -> 'b list
        (* [map_end f l t] is [map f l @ t], just more efficient. *)
val map_left_right: ('a -> 'b) -> 'a list -> 'b list
        (* Like [List.map], with guaranteed left-to-right evaluation order *)
val for_all2: ('a -> 'b -> bool) -> 'a list -> 'b list -> bool
        (* Same as [List.for_all] but for a binary predicate.
           In addition, this [for_all2] never fails: given two lists
           with different lengths, it returns false. *)
val replicate_list: 'a -> int -> 'a list
        (* [replicate_list elem n] is the list with [n] elements
           all identical to [elem]. *)
val list_remove: 'a -> 'a list -> 'a list
        (* [list_remove x l] returns a copy of [l] with the first
           element equal to [x] removed. *)
val split_last: 'a list -> 'a list * 'a
        (* Return the last element and the other elements of the given list. *)
val samelist: ('a -> 'a -> bool) -> 'a list -> 'a list -> bool
        (* Like [List.for_all2] but returns [false] if the two
           lists have different length. *)

val may: ('a -> unit) -> 'a option -> unit
val may_map: ('a -> 'b) -> 'a option -> 'b option

val find_in_path: string list -> string -> string
        (* Search a file in a list of directories. *)
val find_in_path_rel: string list -> string -> string
        (* Search a relative file in a list of directories. *)
val find_in_path_uncap: string list -> string -> string
        (* Same, but search also for uncapitalized name, i.e.
           if name is Foo.ml, allow /path/Foo.ml and /path/foo.ml
           to match. *)
val remove_file: string -> unit
        (* Delete the given file if it exists. Never raise an error. *)
val expand_directory: string -> string -> string
        (* [expand_directory alt file] eventually expands a [+] at the
           beginning of file into [alt] (an alternate root directory) *)

val create_hashtable: int -> ('a * 'b) list -> ('a, 'b) Hashtbl.t
        (* Create a hashtable of the given size and fills it with the
           given bindings. *)

val copy_file: in_channel -> out_channel -> unit
        (* [copy_file ic oc] reads the contents of file [ic] and copies
           them to [oc]. It stops when encountering EOF on [ic]. *)
val copy_file_chunk: in_channel -> out_channel -> int -> unit
        (* [copy_file_chunk ic oc n] reads [n] bytes from [ic] and copies
           them to [oc]. It raises [End_of_file] when encountering
           EOF on [ic]. *)
val string_of_file: in_channel -> string
        (* [string_of_file ic] reads the contents of file [ic] and copies
           them to a string. It stops when encountering EOF on [ic]. *)
val log2: int -> int
        (* [log2 n] returns [s] such that [n = 1 lsl s]
           if [n] is a power of 2*)
val align: int -> int -> int
        (* [align n a] rounds [n] upwards to a multiple of [a]
           (a power of 2). *)
val no_overflow_add: int -> int -> bool
        (* [no_overflow_add n1 n2] returns [true] if the computation of
           [n1 + n2] does not overflow. *)
val no_overflow_sub: int -> int -> bool
        (* [no_overflow_add n1 n2] returns [true] if the computation of
           [n1 - n2] does not overflow. *)
val no_overflow_lsl: int -> bool
        (* [no_overflow_add n] returns [true] if the computation of
           [n lsl 1] does not overflow. *)

val chop_extension_if_any: string -> string
        (* Like Filename.chop_extension but returns the initial file
           name if it has no extension *)

val chop_extensions: string -> string
        (* Return the given file name without its extensions. The extensions
           is the longest suffix starting with a period and not including
           a directory separator, [.xyz.uvw] for instance.

           Return the given name if it does not contain an extension. *)

val search_substring: string -> string -> int -> int
        (* [search_substring pat str start] returns the position of the first
           occurrence of string [pat] in string [str].  Search starts
           at offset [start] in [str].  Raise [Not_found] if [pat]
           does not occur. *)

val replace_substring: before:string -> after:string -> string -> string
        (* [search_substring ~before ~after str] replaces all occurences
           of [before] with [after] in [str] and returns the resulting string. *)

val rev_split_words: string -> string list
        (* [rev_split_words s] splits [s] in blank-separated words, and return
           the list of words in reverse order. *)

val get_ref: 'a list ref -> 'a list
        (* [get_ref lr] returns the content of the list reference [lr] and reset
           its content to the empty list. *)


val fst3: 'a * 'b * 'c -> 'a
val snd3: 'a * 'b * 'c -> 'b
val thd3: 'a * 'b * 'c -> 'c

val fst4: 'a * 'b * 'c * 'd -> 'a
val snd4: 'a * 'b * 'c * 'd -> 'b
val thd4: 'a * 'b * 'c * 'd -> 'c
val for4: 'a * 'b * 'c * 'd -> 'd

module LongString :
  sig
    type t = bytes array
    val create : int -> t
    val length : t -> int
    val get : t -> int -> char
    val set : t -> int -> char -> unit
    val blit : t -> int -> t -> int -> int -> unit
    val output : out_channel -> t -> int -> int -> unit
    val unsafe_blit_to_bytes : t -> int -> bytes -> int -> int -> unit
    val input_bytes : in_channel -> int -> t
  end

val edit_distance : string -> string -> int -> int option
(** [edit_distance a b cutoff] computes the edit distance between
    strings [a] and [b]. To help efficiency, it uses a cutoff: if the
    distance [d] is smaller than [cutoff], it returns [Some d], else
    [None].

    The distance algorithm currently used is Damerau-Levenshtein: it
    computes the number of insertion, deletion, substitution of
    letters, or swapping of adjacent letters to go from one word to the
    other. The particular algorithm may change in the future.
*)

val split : string -> char -> string list
(** [String.split string char] splits the string [string] at every char
    [char], and returns the list of sub-strings between the chars.
    [String.concat (String.make 1 c) (String.split s c)] is the identity.
    @since 4.01
 *)

val cut_at : string -> char -> string * string
(** [String.cut_at s c] returns a pair containing the sub-string before
   the first occurrence of [c] in [s], and the sub-string after the
   first occurrence of [c] in [s].
   [let (before, after) = String.cut_at s c in
    before ^ String.make 1 c ^ after] is the identity if [s] contains [c].

   Raise [Not_found] if the character does not appear in the string
   @since 4.01
*)

end = struct
#1 "misc.ml"
(***********************************************************************)
(*                                                                     *)
(*                                OCaml                                *)
(*                                                                     *)
(*            Xavier Leroy, projet Cristal, INRIA Rocquencourt         *)
(*                                                                     *)
(*  Copyright 1996 Institut National de Recherche en Informatique et   *)
(*  en Automatique.  All rights reserved.  This file is distributed    *)
(*  under the terms of the Q Public License version 1.0.               *)
(*                                                                     *)
(***********************************************************************)

(* Errors *)

exception Fatal_error

let fatal_error msg =
  prerr_string ">> Fatal error: "; prerr_endline msg; raise Fatal_error

(* Exceptions *)

let try_finally work cleanup =
  let result = (try work () with e -> cleanup (); raise e) in
  cleanup ();
  result
;;

(* List functions *)

let rec map_end f l1 l2 =
  match l1 with
    [] -> l2
  | hd::tl -> f hd :: map_end f tl l2

let rec map_left_right f = function
    [] -> []
  | hd::tl -> let res = f hd in res :: map_left_right f tl

let rec for_all2 pred l1 l2 =
  match (l1, l2) with
    ([], []) -> true
  | (hd1::tl1, hd2::tl2) -> pred hd1 hd2 && for_all2 pred tl1 tl2
  | (_, _) -> false

let rec replicate_list elem n =
  if n <= 0 then [] else elem :: replicate_list elem (n-1)

let rec list_remove x = function
    [] -> []
  | hd :: tl ->
      if hd = x then tl else hd :: list_remove x tl

let rec split_last = function
    [] -> assert false
  | [x] -> ([], x)
  | hd :: tl ->
      let (lst, last) = split_last tl in
      (hd :: lst, last)

let rec samelist pred l1 l2 =
  match (l1, l2) with
  | ([], []) -> true
  | (hd1 :: tl1, hd2 :: tl2) -> pred hd1 hd2 && samelist pred tl1 tl2
  | (_, _) -> false

(* Options *)

let may f = function
    Some x -> f x
  | None -> ()

let may_map f = function
    Some x -> Some (f x)
  | None -> None

(* File functions *)

let find_in_path path name =
  if not (Filename.is_implicit name) then
    if Sys.file_exists name then name else raise Not_found
  else begin
    let rec try_dir = function
      [] -> raise Not_found
    | dir::rem ->
        let fullname = Filename.concat dir name in
        if Sys.file_exists fullname then fullname else try_dir rem
    in try_dir path
  end

let find_in_path_rel path name =
  let rec simplify s =
    let open Filename in
    let base = basename s in
    let dir = dirname s in
    if dir = s then dir
    else if base = current_dir_name then simplify dir
    else concat (simplify dir) base
  in
  let rec try_dir = function
    [] -> raise Not_found
  | dir::rem ->
      let fullname = simplify (Filename.concat dir name) in
      if Sys.file_exists fullname then fullname else try_dir rem
  in try_dir path

let find_in_path_uncap path name =
  let uname = String.uncapitalize name in
  let rec try_dir = function
    [] -> raise Not_found
  | dir::rem ->
      let fullname = Filename.concat dir name
      and ufullname = Filename.concat dir uname in
      if Sys.file_exists ufullname then ufullname
      else if Sys.file_exists fullname then fullname
      else try_dir rem
  in try_dir path

let remove_file filename =
  try
    Sys.remove filename
  with Sys_error msg ->
    ()

(* Expand a -I option: if it starts with +, make it relative to the standard
   library directory *)

let expand_directory alt s =
  if String.length s > 0 && s.[0] = '+'
  then Filename.concat alt
                       (String.sub s 1 (String.length s - 1))
  else s

(* Hashtable functions *)

let create_hashtable size init =
  let tbl = Hashtbl.create size in
  List.iter (fun (key, data) -> Hashtbl.add tbl key data) init;
  tbl

(* File copy *)

let copy_file ic oc =
  let buff = Bytes.create 0x1000 in
  let rec copy () =
    let n = input ic buff 0 0x1000 in
    if n = 0 then () else (output oc buff 0 n; copy())
  in copy()

let copy_file_chunk ic oc len =
  let buff = Bytes.create 0x1000 in
  let rec copy n =
    if n <= 0 then () else begin
      let r = input ic buff 0 (min n 0x1000) in
      if r = 0 then raise End_of_file else (output oc buff 0 r; copy(n-r))
    end
  in copy len

let string_of_file ic =
  let b = Buffer.create 0x10000 in
  let buff = Bytes.create 0x1000 in
  let rec copy () =
    let n = input ic buff 0 0x1000 in
    if n = 0 then Buffer.contents b else
      (Buffer.add_subbytes b buff 0 n; copy())
  in copy()

(* Integer operations *)

let rec log2 n =
  if n <= 1 then 0 else 1 + log2(n asr 1)

let align n a =
  if n >= 0 then (n + a - 1) land (-a) else n land (-a)

let no_overflow_add a b = (a lxor b) lor (a lxor (lnot (a+b))) < 0

let no_overflow_sub a b = (a lxor (lnot b)) lor (b lxor (a-b)) < 0

let no_overflow_lsl a = min_int asr 1 <= a && a <= max_int asr 1

(* String operations *)

let chop_extension_if_any fname =
  try Filename.chop_extension fname with Invalid_argument _ -> fname

let chop_extensions file =
  let dirname = Filename.dirname file and basename = Filename.basename file in
  try
    let pos = String.index basename '.' in
    let basename = String.sub basename 0 pos in
    if Filename.is_implicit file && dirname = Filename.current_dir_name then
      basename
    else
      Filename.concat dirname basename
  with Not_found -> file

let search_substring pat str start =
  let rec search i j =
    if j >= String.length pat then i
    else if i + j >= String.length str then raise Not_found
    else if str.[i + j] = pat.[j] then search i (j+1)
    else search (i+1) 0
  in search start 0

let replace_substring ~before ~after str =
  let rec search acc curr =
    match search_substring before str curr with
      | next ->
         let prefix = String.sub str curr (next - curr) in
         search (prefix :: acc) (next + String.length before)
      | exception Not_found ->
        let suffix = String.sub str curr (String.length str - curr) in
        List.rev (suffix :: acc)
  in String.concat after (search [] 0)

let rev_split_words s =
  let rec split1 res i =
    if i >= String.length s then res else begin
      match s.[i] with
        ' ' | '\t' | '\r' | '\n' -> split1 res (i+1)
      | _ -> split2 res i (i+1)
    end
  and split2 res i j =
    if j >= String.length s then String.sub s i (j-i) :: res else begin
      match s.[j] with
        ' ' | '\t' | '\r' | '\n' -> split1 (String.sub s i (j-i) :: res) (j+1)
      | _ -> split2 res i (j+1)
    end
  in split1 [] 0

let get_ref r =
  let v = !r in
  r := []; v

let fst3 (x, _, _) = x
let snd3 (_,x,_) = x
let thd3 (_,_,x) = x

let fst4 (x, _, _, _) = x
let snd4 (_,x,_, _) = x
let thd4 (_,_,x,_) = x
let for4 (_,_,_,x) = x


module LongString = struct
  type t = bytes array

  let create str_size =
    let tbl_size = str_size / Sys.max_string_length + 1 in
    let tbl = Array.make tbl_size Bytes.empty in
    for i = 0 to tbl_size - 2 do
      tbl.(i) <- Bytes.create Sys.max_string_length;
    done;
    tbl.(tbl_size - 1) <- Bytes.create (str_size mod Sys.max_string_length);
    tbl

  let length tbl =
    let tbl_size = Array.length tbl in
    Sys.max_string_length * (tbl_size - 1) + Bytes.length tbl.(tbl_size - 1)

  let get tbl ind =
    Bytes.get tbl.(ind / Sys.max_string_length) (ind mod Sys.max_string_length)

  let set tbl ind c =
    Bytes.set tbl.(ind / Sys.max_string_length) (ind mod Sys.max_string_length)
              c

  let blit src srcoff dst dstoff len =
    for i = 0 to len - 1 do
      set dst (dstoff + i) (get src (srcoff + i))
    done

  let output oc tbl pos len =
    for i = pos to pos + len - 1 do
      output_char oc (get tbl i)
    done

  let unsafe_blit_to_bytes src srcoff dst dstoff len =
    for i = 0 to len - 1 do
      Bytes.unsafe_set dst (dstoff + i) (get src (srcoff + i))
    done

  let input_bytes ic len =
    let tbl = create len in
    Array.iter (fun str -> really_input ic str 0 (Bytes.length str)) tbl;
    tbl
end


let edit_distance a b cutoff =
  let la, lb = String.length a, String.length b in
  let cutoff =
    (* using max_int for cutoff would cause overflows in (i + cutoff + 1);
       we bring it back to the (max la lb) worstcase *)
    min (max la lb) cutoff in
  if abs (la - lb) > cutoff then None
  else begin
    (* initialize with 'cutoff + 1' so that not-yet-written-to cases have
       the worst possible cost; this is useful when computing the cost of
       a case just at the boundary of the cutoff diagonal. *)
    let m = Array.make_matrix (la + 1) (lb + 1) (cutoff + 1) in
    m.(0).(0) <- 0;
    for i = 1 to la do
      m.(i).(0) <- i;
    done;
    for j = 1 to lb do
      m.(0).(j) <- j;
    done;
    for i = 1 to la do
      for j = max 1 (i - cutoff - 1) to min lb (i + cutoff + 1) do
        let cost = if a.[i-1] = b.[j-1] then 0 else 1 in
        let best =
          (* insert, delete or substitute *)
          min (1 + min m.(i-1).(j) m.(i).(j-1)) (m.(i-1).(j-1) + cost)
        in
        let best =
          (* swap two adjacent letters; we use "cost" again in case of
             a swap between two identical letters; this is slightly
             redundant as this is a double-substitution case, but it
             was done this way in most online implementations and
             imitation has its virtues *)
          if not (i > 1 && j > 1 && a.[i-1] = b.[j-2] && a.[i-2] = b.[j-1])
          then best
          else min best (m.(i-2).(j-2) + cost)
        in
        m.(i).(j) <- best
      done;
    done;
    let result = m.(la).(lb) in
    if result > cutoff
    then None
    else Some result
  end


(* split a string [s] at every char [c], and return the list of sub-strings *)
let split s c =
  let len = String.length s in
  let rec iter pos to_rev =
    if pos = len then List.rev ("" :: to_rev) else
      match try
              Some ( String.index_from s pos c )
        with Not_found -> None
      with
          Some pos2 ->
            if pos2 = pos then iter (pos+1) ("" :: to_rev) else
              iter (pos2+1) ((String.sub s pos (pos2-pos)) :: to_rev)
        | None -> List.rev ( String.sub s pos (len-pos) :: to_rev )
  in
  iter 0 []

let cut_at s c =
  let pos = String.index s c in
  String.sub s 0 pos, String.sub s (pos+1) (String.length s - pos - 1)

end
module Parser
= struct
#1 "parser.ml"
type token =
  | AMPERAMPER
  | AMPERSAND
  | AND
  | AS
  | ASSERT
  | BACKQUOTE
  | BANG
  | BAR
  | BARBAR
  | BARRBRACKET
  | BEGIN
  | CHAR of (char)
  | CLASS
  | COLON
  | COLONCOLON
  | COLONEQUAL
  | COLONGREATER
  | COMMA
  | CONSTRAINT
  | DO
  | DONE
  | DOT
  | DOTDOT
  | DOWNTO
  | ELSE
  | END
  | EOF
  | EQUAL
  | EXCEPTION
  | EXTERNAL
  | FALSE
  | FLOAT of (string)
  | FOR
  | FUN
  | FUNCTION
  | FUNCTOR
  | GREATER
  | GREATERRBRACE
  | GREATERRBRACKET
  | IF
  | IN
  | INCLUDE
  | INFIXOP0 of (string)
  | INFIXOP1 of (string)
  | INFIXOP2 of (string)
  | INFIXOP3 of (string)
  | INFIXOP4 of (string)
  | INHERIT
  | INITIALIZER
  | INT of (int)
  | INT32 of (int32)
  | INT64 of (int64)
  | LABEL of (string)
  | LAZY
  | LBRACE
  | LBRACELESS
  | LBRACKET
  | LBRACKETBAR
  | LBRACKETLESS
  | LBRACKETGREATER
  | LBRACKETPERCENT
  | LBRACKETPERCENTPERCENT
  | LESS
  | LESSMINUS
  | LET
  | LIDENT of (string)
  | LPAREN
  | LBRACKETAT
  | LBRACKETATAT
  | LBRACKETATATAT
  | MATCH
  | METHOD
  | MINUS
  | MINUSDOT
  | MINUSGREATER
  | MODULE
  | MUTABLE
  | NATIVEINT of (nativeint)
  | NEW
  | NONREC
  | OBJECT
  | OF
  | OPEN
  | OPTLABEL of (string)
  | OR
  | PERCENT
  | PLUS
  | PLUSDOT
  | PLUSEQ
  | PREFIXOP of (string)
  | PRIVATE
  | QUESTION
  | QUOTE
  | RBRACE
  | RBRACKET
  | REC
  | RPAREN
  | SEMI
  | SEMISEMI
  | SHARP
  | SHARPOP of (string)
  | SIG
  | STAR
  | STRING of (string * string option)
  | STRUCT
  | THEN
  | TILDE
  | TO
  | TRUE
  | TRY
  | TYPE
  | UIDENT of (string)
  | UNDERSCORE
  | VAL
  | VIRTUAL
  | WHEN
  | WHILE
  | WITH
  | COMMENT of (string * Location.t)

  | EOL


end
module Lexer : sig 
#1 "lexer.mli"
(***********************************************************************)
(*                                                                     *)
(*                                OCaml                                *)
(*                                                                     *)
(*            Xavier Leroy, projet Cristal, INRIA Rocquencourt         *)
(*                                                                     *)
(*  Copyright 1996 Institut National de Recherche en Informatique et   *)
(*  en Automatique.  All rights reserved.  This file is distributed    *)
(*  under the terms of the Q Public License version 1.0.               *)
(*                                                                     *)
(***********************************************************************)

(* The lexical analyzer *)

val init : unit -> unit
val token: Lexing.lexbuf -> Parser.token
val skip_sharp_bang: Lexing.lexbuf -> unit

type directive_type = 
  | Dir_type_bool 
  | Dir_type_float 
  | Dir_type_int 
  | Dir_type_string 

type directive_value =
  | Dir_bool of bool 
  | Dir_float of float
  | Dir_int of int
  | Dir_string of string

type error =
  | Illegal_character of char
  | Illegal_escape of string
  | Unterminated_comment of Location.t
  | Unterminated_string
  | Unterminated_string_in_comment of Location.t * Location.t
  | Keyword_as_label of string
  | Literal_overflow of string
  | Unterminated_paren_in_conditional
  | Unterminated_if
  | Unterminated_else 
  | Unexpected_token_in_conditional 
  | Expect_hash_then_in_conditional
  | Illegal_semver of string
  | Unexpected_directive
  | Conditional_expr_expected_type of directive_type * directive_type
;;

exception Error of error * Location.t

open Format

val report_error: formatter -> error -> unit
 (* Deprecated.  Use Location.{error_of_exn, report_error}. *)

val in_comment : unit -> bool;;
val in_string : unit -> bool;;


val print_warnings : bool ref
val comments : unit -> (string * Location.t) list
val token_with_comments : Lexing.lexbuf -> Parser.token

(*
  [set_preprocessor init preprocessor] registers [init] as the function
to call to initialize the preprocessor when the lexer is initialized,
and [preprocessor] a function that is called when a new token is needed
by the parser, as [preprocessor lexer lexbuf] where [lexer] is the
lexing function.

When a preprocessor is configured by calling [set_preprocessor], the lexer
changes its behavior to accept backslash-newline as a token-separating blank.
*)

val set_preprocessor :
  (unit -> unit) ->
  ((Lexing.lexbuf -> Parser.token) -> Lexing.lexbuf -> Parser.token) ->
  unit


val replace_directive_built_in_value : 
  string ->  directive_value -> unit

(** Raises Not_found *)
val find_directive_built_in_value :
  string -> directive_value

val iter_directive_built_in_value : 
  (string -> directive_value -> unit) -> unit


(** semantic version predicate *)
val semver : Location.t ->   string -> string -> bool

val filter_directive_from_lexbuf : Lexing.lexbuf -> (int * int) list

end = struct
#1 "lexer.ml"
# 15 "parsing/lexer.mll"
 
open Lexing
open Misc
open Parser

type directive_value =
  | Dir_bool of bool 
  | Dir_float of float
  | Dir_int of int
  | Dir_string of string

type directive_type = 
  | Dir_type_bool 
  | Dir_type_float 
  | Dir_type_int 
  | Dir_type_string 

let type_of_directive x =
  match x with 
  | Dir_bool _ -> Dir_type_bool
  | Dir_float _ -> Dir_type_float
  | Dir_int _ -> Dir_type_int
  | Dir_string _ -> Dir_type_string

let string_of_type_directive x = 
  match x with 
  | Dir_type_bool  -> "bool"
  | Dir_type_float  -> "float"
  | Dir_type_int  -> "int"
  | Dir_type_string  -> "string"

type error =
  | Illegal_character of char
  | Illegal_escape of string
  | Unterminated_comment of Location.t
  | Unterminated_string
  | Unterminated_string_in_comment of Location.t * Location.t
  | Keyword_as_label of string
  | Literal_overflow of string
  | Unterminated_paren_in_conditional
  | Unterminated_if
  | Unterminated_else 
  | Unexpected_token_in_conditional 
  | Expect_hash_then_in_conditional
  | Illegal_semver of string
  | Unexpected_directive 
  | Conditional_expr_expected_type of directive_type * directive_type

;;

exception Error of error * Location.t;;

let assert_same_type  lexbuf x y = 
  let lhs = type_of_directive x in let rhs =  type_of_directive y  in
  if lhs <> rhs then 
    raise (Error(Conditional_expr_expected_type(lhs,rhs), Location.curr lexbuf))
  else y

let directive_built_in_values  =
  Hashtbl.create 51


let replace_directive_built_in_value k v = 
  Hashtbl.replace directive_built_in_values k v 

let () =
  (* Note we use {!Config} instead of {!Sys} becasue 
     we want to overwrite in some cases with the 
     same stdlib
  *)
  replace_directive_built_in_value "OCAML_VERSION" 
    (Dir_string Config.version);
  replace_directive_built_in_value "OCAML_PATCH"
    (Dir_string 
       (let i = String.rindex Sys.ocaml_version '+' in
        String.sub Config.version (i + 1)
          (String.length Config.version - i - 1)))
  ;
  replace_directive_built_in_value "OS_TYPE" 
    (Dir_string Sys.os_type);
  replace_directive_built_in_value "BIG_ENDIAN" 
    (Dir_bool Sys.big_endian);
  replace_directive_built_in_value "WORD_SIZE" 
    (Dir_int Sys.word_size)

let find_directive_built_in_value k =
  Hashtbl.find directive_built_in_values k 

let iter_directive_built_in_value f = Hashtbl.iter f directive_built_in_values

(*
   {[
     # semver 0 "12";;
     - : int * int * int * string = (12, 0, 0, "");;
     # semver 0 "12.3";;
     - : int * int * int * string = (12, 3, 0, "");;
       semver 0 "12.3.10";;
     - : int * int * int * string = (12, 3, 10, "");;
     # semver 0 "12.3.10+x";;
     - : int * int * int * string = (12, 3, 10, "+x")
   ]}
*)    
let zero = Char.code '0' 
let dot = Char.code '.'
let semantic_version_parse str start  last_index = 
  let rec aux start  acc last_index =
    if start <= last_index then
      let c = Char.code (String.unsafe_get str start) in
      if c = dot then (acc, start + 1) (* consume [4.] instead of [4]*)
      else 
        let v =  c - zero in
        if v >=0 && v <= 9  then
          aux (start + 1) (acc * 10 + v) last_index
        else (acc , start)
    else (acc, start)
  in
  let major, major_end =  aux start 0 last_index  in
  let minor, minor_end = aux major_end 0 last_index in
  let patch, patch_end = aux minor_end 0 last_index in 
  let additional = String.sub str patch_end (last_index - patch_end  +1) in
  (major, minor, patch), additional

(** 
   {[
     semver Location.none "1.2.3" "~1.3.0" = false;;
     semver Location.none "1.2.3" "^1.3.0" = true ;;
     semver Location.none "1.2.3" ">1.3.0" = false ;;
     semver Location.none "1.2.3" ">=1.3.0" = false ;;
     semver Location.none "1.2.3" "<1.3.0" = true ;;
     semver Location.none "1.2.3" "<=1.3.0" = true ;;
   ]}
*)
let semver loc lhs str =
  let last_index = String.length str - 1 in 
  if last_index < 0 then raise (Error(Illegal_semver str, loc))
  else 
    let pred, ((major, minor,patch) as version, _) = 
      let v = String.unsafe_get str 0 in 
      match v with
      | '>' -> 
          if last_index = 0 then raise (Error(Illegal_semver str, loc)) else 
          if String.unsafe_get str 1 = '=' then 
            `Ge, semantic_version_parse str 2 last_index
          else `Gt, semantic_version_parse str 1 last_index
      | '<' 
        ->
          if last_index = 0 then raise (Error(Illegal_semver str, loc)) else 
          if String.unsafe_get str 1 = '=' then 
            `Le, semantic_version_parse str 2 last_index
          else `Lt, semantic_version_parse str 1 last_index
      | '^' 
        -> `Compatible, semantic_version_parse str 1 last_index
      | '~' ->  `Approximate, semantic_version_parse str 1 last_index
      | _ -> `Exact, semantic_version_parse str 0 last_index 
    in 
    let ((l_major, l_minor, l_patch) as lversion,_) =
      semantic_version_parse lhs 0 (String.length lhs - 1) in 
    match pred with 
    | `Ge -> lversion >= version 
    | `Gt -> lversion > version 
    | `Le -> lversion <= version
    | `Lt -> lversion < version 
    | `Approximate -> major = l_major && minor = l_minor 
    |  `Compatible -> major = l_major
    | `Exact -> lversion = version 


    
let defined str = 
  try ignore @@ Sys.getenv str; true with _ -> 
    try ignore @@ find_directive_built_in_value str ; true with _ ->  false
let query loc str =
  match Sys.getenv str with
  | v ->
      begin 
        try Dir_bool (bool_of_string v) with 
          _ -> 
            begin 
              try Dir_int (int_of_string v )
              with 
                _ -> 
                  begin try (Dir_float (float_of_string v)) 
                  with _ -> Dir_string v
                  end
            end
      end


  | exception Not_found ->
      begin
        try find_directive_built_in_value str 
        with
        | Not_found ->
            Dir_bool false
      end

let value_of_token loc (t : Parser.token)  = 
  match t with 
  | INT i -> Dir_int i 
  | STRING (s,_) -> Dir_string s 
  | FLOAT s  -> Dir_float (float_of_string s)
  | TRUE -> Dir_bool true
  | FALSE -> Dir_bool false
  | UIDENT s -> query loc s 
  | _ -> raise (Error (Unexpected_token_in_conditional, loc))


let directive_parse token_with_comments lexbuf =
  let look_ahead = ref None in
  let token () : Parser.token =
    let v = !look_ahead in
    match v with 
    | Some v -> 
        look_ahead := None ;
        v
    | None ->
       let rec skip () = 
        match token_with_comments lexbuf  with
        | COMMENT _ -> skip ()

        | EOL -> skip ()
        | EOF -> raise (Error (Unterminated_if, Location.curr lexbuf)) 
        | t -> t 
        in  skip ()
  in
  let push e =
    (* INVARIANT: only look at most one token *)
    assert (!look_ahead = None);
    look_ahead := Some e 
  in
  let rec
    token_op calc   ~no  lhs   =
    match token () with 
    | (LESS 
    | GREATER 
    | INFIXOP0 "<=" 
    | INFIXOP0 ">=" 
    | EQUAL
    | INFIXOP0 "<>" as op) ->
        let f =  
          match op with 
          | LESS -> (<) 
          | GREATER -> (>)
          | INFIXOP0 "<=" -> (<=)
          | EQUAL -> (=)
          | INFIXOP0 "<>" -> (<>) 
          | _ -> assert false
        in 
        let curr_loc = Location.curr lexbuf in 
        let rhs = value_of_token curr_loc (token ()) in 
        not calc ||
        f lhs (assert_same_type lexbuf lhs rhs)
    | INFIXOP0 "=~" -> 
        not calc ||
        begin match lhs with 
        | Dir_string s ->
            let curr_loc = Location.curr lexbuf in 
            let rhs = value_of_token curr_loc (token ()) in 
            begin match rhs with 
            | Dir_string rhs -> 
                semver curr_loc s rhs
            | _ -> 
                raise
                  (Error
                     ( Conditional_expr_expected_type
                         (Dir_type_string, type_of_directive lhs), Location.curr lexbuf))
            end
        | _ -> raise
                 (Error
                    ( Conditional_expr_expected_type
                        (Dir_type_string, type_of_directive lhs), Location.curr lexbuf))
        end
    | e -> no e 
  and
    parse_or calc : bool =
    parse_or_aux calc (parse_and calc)
  and  (* a || (b || (c || d))*)
    parse_or_aux calc v : bool =
    (* let l = v  in *)
    match token () with
    | BARBAR ->
        let b =   parse_or (calc && not v)  in
        v || b 
    | e -> push e ; v
  and parse_and calc = 
    parse_and_aux calc (parse_relation calc)
  and parse_and_aux calc v = (* a && (b && (c && d)) *)
    (* let l = v  in *)
    match token () with
    | AMPERAMPER ->
        let b =  parse_and (calc && v) in
        v && b
    | e -> push e ; v
  and parse_relation (calc : bool) : bool  =
    let curr_token = token () in
    let curr_loc = Location.curr lexbuf in
    match curr_token with
    | TRUE -> true 
    | FALSE -> false
    | UIDENT v ->
        let value_v = query curr_loc v in
        token_op calc 
          ~no:(fun e -> push e ;
                match value_v with 
                | Dir_bool b -> b 
                | _ -> 
                    let ty = type_of_directive value_v in
                    raise
                      (Error(Conditional_expr_expected_type (Dir_type_bool, ty),
                             curr_loc)))
          value_v
    | INT v -> 
        token_op calc
          ~no:(fun e -> 
              raise(Error(Conditional_expr_expected_type(Dir_type_bool,Dir_type_int), 
                          curr_loc)))
          (Dir_int v)
    | FLOAT v -> 
        token_op calc
          ~no:(fun e -> 
              raise (Error(Conditional_expr_expected_type(Dir_type_bool, Dir_type_float),
                           curr_loc)))
          (Dir_float (float_of_string v))
    | STRING (v,_) -> 
        token_op calc
          ~no:(fun e ->
              raise (Error
                       (Conditional_expr_expected_type(Dir_type_bool, Dir_type_string),
                        curr_loc)))
          (Dir_string v)
    | LIDENT ("defined" | "undefined" as r) ->
        let t = token () in 
        let loc = Location.curr lexbuf in
        begin match t with
        | UIDENT s -> 
            not calc || 
            if r.[0] = 'u' then 
              not @@ defined s
            else defined s 
        | _ -> raise (Error (Unexpected_token_in_conditional, loc))
        end
    | LPAREN ->
        let v = parse_or calc in
        begin match token () with
        | RPAREN ->  v
        | _ -> raise (Error(Unterminated_paren_in_conditional, Location.curr lexbuf))
        end 

    | _ -> raise (Error (Unexpected_token_in_conditional, curr_loc))
  in
  let v = parse_or true in
  begin match token () with
  | THEN ->  v 
  | _ -> raise (Error (Expect_hash_then_in_conditional, Location.curr lexbuf))
  end


type dir_conditional =
  | Dir_if_true
  | Dir_if_false
  | Dir_out 

let string_of_dir_conditional (x : dir_conditional) =
  match x with 
  | Dir_if_true -> "Dir_if_true"
  | Dir_if_false -> "Dir_if_false"
  | Dir_out -> "Dir_out"

let is_elif (i : Parser.token ) =
  match i with
  | LIDENT "elif" -> true
  | _ -> false (* avoid polymorphic equal *)


(* The table of keywords *)

let keyword_table =
  create_hashtable 149 [
    "and", AND;
    "as", AS;
    "assert", ASSERT;
    "begin", BEGIN;
    "class", CLASS;
    "constraint", CONSTRAINT;
    "do", DO;
    "done", DONE;
    "downto", DOWNTO;
    "else", ELSE;
    "end", END;
    "exception", EXCEPTION;
    "external", EXTERNAL;
    "false", FALSE;
    "for", FOR;
    "fun", FUN;
    "function", FUNCTION;
    "functor", FUNCTOR;
    "if", IF;
    "in", IN;
    "include", INCLUDE;
    "inherit", INHERIT;
    "initializer", INITIALIZER;
    "lazy", LAZY;
    "let", LET;
    "match", MATCH;
    "method", METHOD;
    "module", MODULE;
    "mutable", MUTABLE;
    "new", NEW;
    "nonrec", NONREC;
    "object", OBJECT;
    "of", OF;
    "open", OPEN;
    "or", OR;
(*  "parser", PARSER; *)
    "private", PRIVATE;
    "rec", REC;
    "sig", SIG;
    "struct", STRUCT;
    "then", THEN;
    "to", TO;
    "true", TRUE;
    "try", TRY;
    "type", TYPE;
    "val", VAL;
    "virtual", VIRTUAL;
    "when", WHEN;
    "while", WHILE;
    "with", WITH;

    "mod", INFIXOP3("mod");
    "land", INFIXOP3("land");
    "lor", INFIXOP3("lor");
    "lxor", INFIXOP3("lxor");
    "lsl", INFIXOP4("lsl");
    "lsr", INFIXOP4("lsr");
    "asr", INFIXOP4("asr")
]

(* To buffer string literals *)

let initial_string_buffer = Bytes.create 256
let string_buff = ref initial_string_buffer
let string_index = ref 0

let reset_string_buffer () =
  string_buff := initial_string_buffer;
  string_index := 0

let store_string_char c =
  if !string_index >= Bytes.length !string_buff then begin
    let new_buff = Bytes.create (Bytes.length (!string_buff) * 2) in
    Bytes.blit !string_buff 0 new_buff 0 (Bytes.length !string_buff);
    string_buff := new_buff
  end;
  Bytes.unsafe_set !string_buff !string_index c;
  incr string_index

let store_string s =
  for i = 0 to String.length s - 1 do
    store_string_char s.[i];
  done

let store_lexeme lexbuf =
  store_string (Lexing.lexeme lexbuf)

let get_stored_string () =
  let s = Bytes.sub_string !string_buff 0 !string_index in
  string_buff := initial_string_buffer;
  s

(* To store the position of the beginning of a string and comment *)
let string_start_loc = ref Location.none;;
let comment_start_loc = ref [];;
let in_comment () = !comment_start_loc <> [];;
let is_in_string = ref false
let in_string () = !is_in_string
let print_warnings = ref true
let if_then_else = ref Dir_out
let sharp_look_ahead = ref None
let update_if_then_else v = 
  (* Format.fprintf Format.err_formatter "@[update %s \n@]@." (string_of_dir_conditional v); *)
  if_then_else := v
    
let with_comment_buffer comment lexbuf =
  let start_loc = Location.curr lexbuf  in
  comment_start_loc := [start_loc];
  reset_string_buffer ();
  let end_loc = comment lexbuf in
  let s = get_stored_string () in
  reset_string_buffer ();
  let loc = { start_loc with Location.loc_end = end_loc.Location.loc_end } in
  s, loc

(* To translate escape sequences *)

let char_for_backslash = function
  | 'n' -> '\010'
  | 'r' -> '\013'
  | 'b' -> '\008'
  | 't' -> '\009'
  | c   -> c

let char_for_decimal_code lexbuf i =
  let c = 100 * (Char.code(Lexing.lexeme_char lexbuf i) - 48) +
           10 * (Char.code(Lexing.lexeme_char lexbuf (i+1)) - 48) +
                (Char.code(Lexing.lexeme_char lexbuf (i+2)) - 48) in
  if (c < 0 || c > 255) then
    if in_comment ()
    then 'x'
    else raise (Error(Illegal_escape (Lexing.lexeme lexbuf),
                      Location.curr lexbuf))
  else Char.chr c

let char_for_hexadecimal_code lexbuf i =
  let d1 = Char.code (Lexing.lexeme_char lexbuf i) in
  let val1 = if d1 >= 97 then d1 - 87
             else if d1 >= 65 then d1 - 55
             else d1 - 48
  in
  let d2 = Char.code (Lexing.lexeme_char lexbuf (i+1)) in
  let val2 = if d2 >= 97 then d2 - 87
             else if d2 >= 65 then d2 - 55
             else d2 - 48
  in
  Char.chr (val1 * 16 + val2)

(* To convert integer literals, allowing max_int + 1 (PR#4210) *)

let cvt_int_literal s =
  - int_of_string ("-" ^ s)
let cvt_int32_literal s =
  Int32.neg (Int32.of_string ("-" ^ String.sub s 0 (String.length s - 1)))
let cvt_int64_literal s =
  Int64.neg (Int64.of_string ("-" ^ String.sub s 0 (String.length s - 1)))
let cvt_nativeint_literal s =
  Nativeint.neg (Nativeint.of_string ("-" ^ String.sub s 0
                                                       (String.length s - 1)))

(* Remove underscores from float literals *)

let remove_underscores s =
  let l = String.length s in
  let b = Bytes.create l in
  let rec remove src dst =
    if src >= l then
      if dst >= l then s else Bytes.sub_string b 0 dst
    else
      match s.[src] with
        '_' -> remove (src + 1) dst
      |  c  -> Bytes.set b dst c; remove (src + 1) (dst + 1)
  in remove 0 0

(* recover the name from a LABEL or OPTLABEL token *)

let get_label_name lexbuf =
  let s = Lexing.lexeme lexbuf in
  let name = String.sub s 1 (String.length s - 2) in
  if Hashtbl.mem keyword_table name then
    raise (Error(Keyword_as_label name, Location.curr lexbuf));
  name
;;

(* Update the current location with file name and line number. *)

let update_loc lexbuf file line absolute chars =
  let pos = lexbuf.lex_curr_p in
  let new_file = match file with
                 | None -> pos.pos_fname
                 | Some s -> s
  in
  lexbuf.lex_curr_p <- { pos with
    pos_fname = new_file;
    pos_lnum = if absolute then line else pos.pos_lnum + line;
    pos_bol = pos.pos_cnum - chars;
  }
;;

let preprocessor = ref None

let escaped_newlines = ref false

(* Warn about Latin-1 characters used in idents *)

let warn_latin1 lexbuf =
  Location.prerr_warning (Location.curr lexbuf)
    (Warnings.Deprecated "ISO-Latin1 characters in identifiers")
;;

let comment_list = ref []

let add_comment com =
  comment_list := com :: !comment_list

let add_docstring_comment ds =
 
  ()    


let comments () = List.rev !comment_list

(* Error report *)

open Format

let report_error ppf = function
  | Illegal_character c ->
      fprintf ppf "Illegal character (%s)" (Char.escaped c)
  | Illegal_escape s ->
      fprintf ppf "Illegal backslash escape in string or character (%s)" s
  | Unterminated_comment _ ->
      fprintf ppf "Comment not terminated"
  | Unterminated_string ->
      fprintf ppf "String literal not terminated"
  | Unterminated_string_in_comment (_, loc) ->
      fprintf ppf "This comment contains an unterminated string literal@.\
                   %aString literal begins here"
              Location.print_error loc
  | Keyword_as_label kwd ->
      fprintf ppf "`%s' is a keyword, it cannot be used as label name" kwd
  | Literal_overflow ty ->
      fprintf ppf "Integer literal exceeds the range of representable \
                   integers of type %s" ty
  | Unterminated_if -> 
      fprintf ppf "#if not terminated"
  | Unterminated_else -> 
      fprintf ppf "#else not terminated"
  | Unexpected_directive -> fprintf ppf "Unexpected directive"
  | Unexpected_token_in_conditional -> 
      fprintf ppf "Unexpected token in conditional predicate"
  | Unterminated_paren_in_conditional ->
    fprintf ppf "Unterminated parens in conditional predicate"
  | Expect_hash_then_in_conditional -> 
      fprintf ppf "Expect `then` after conditioal predicate"
  | Conditional_expr_expected_type (a,b) -> 
      fprintf ppf "Conditional expression type mismatch (%s,%s)" 
        (string_of_type_directive a )
        (string_of_type_directive b )
  | Illegal_semver s -> 
      fprintf ppf "Illegal semantic version string %s" s
let () =
  Location.register_error_of_exn
    (function
      | Error (err, loc) ->
          Some (Location.error_of_printer loc report_error err)
      | _ ->
          None
    )


# 657 "parsing/lexer.ml"
let __ocaml_lex_tables = {
  Lexing.lex_base = 
   "\000\000\164\255\165\255\224\000\003\001\038\001\073\001\108\001\
    \143\001\188\255\178\001\215\001\196\255\091\000\252\001\031\002\
    \068\000\071\000\084\000\066\002\213\255\215\255\218\255\101\002\
    \196\002\231\002\089\000\255\000\005\003\236\255\082\003\115\003\
    \188\003\140\004\092\005\044\006\011\007\103\007\055\008\125\000\
    \254\255\001\000\005\000\255\255\006\000\007\000\022\009\052\009\
    \004\010\250\255\249\255\212\010\164\011\247\255\246\255\237\255\
    \238\255\239\255\093\000\118\002\091\000\110\000\231\002\007\004\
    \215\004\101\002\254\002\118\000\194\255\235\255\120\005\132\012\
    \096\000\113\000\011\000\234\255\233\255\229\255\229\004\128\000\
    \115\000\232\255\224\000\117\000\231\255\119\006\147\000\230\255\
    \146\000\225\255\148\000\224\255\217\000\132\012\223\255\171\012\
    \175\008\174\006\222\255\012\000\024\001\044\001\080\001\045\001\
    \222\255\013\000\217\012\000\013\035\013\073\013\210\255\206\255\
    \207\255\208\255\204\255\108\013\154\000\183\000\197\255\198\255\
    \199\255\199\000\182\255\184\255\191\255\143\013\187\255\189\255\
    \178\013\213\013\248\013\027\014\235\005\243\255\244\255\017\000\
    \245\255\062\002\172\007\253\255\223\000\241\000\255\255\254\255\
    \252\255\200\007\045\014\250\000\252\000\018\000\251\255\250\255\
    \249\255\128\009\030\003\003\001\248\255\092\003\004\001\247\255\
    \079\010\005\001\246\255\043\001\199\001\247\255\248\255\249\255\
    \059\001\118\014\255\255\250\255\031\011\036\004\253\255\038\001\
    \069\001\094\001\252\004\252\255\239\011\251\255\095\001\181\001\
    \252\255\238\006\254\255\255\255\111\001\112\001\253\255\074\007\
    \016\001\019\001\050\001\063\001\026\001\107\001\033\001\019\000\
    \255\255";
  Lexing.lex_backtrk = 
   "\255\255\255\255\255\255\088\000\087\000\084\000\083\000\076\000\
    \074\000\255\255\065\000\062\000\255\255\055\000\054\000\052\000\
    \050\000\046\000\044\000\079\000\255\255\255\255\255\255\035\000\
    \034\000\041\000\039\000\038\000\060\000\255\255\014\000\014\000\
    \013\000\012\000\011\000\010\000\007\000\004\000\003\000\002\000\
    \255\255\091\000\091\000\255\255\255\255\255\255\082\000\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\015\000\255\255\255\255\255\255\014\000\
    \014\000\014\000\015\000\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\026\000\026\000\
    \026\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \027\000\255\255\028\000\255\255\029\000\086\000\255\255\089\000\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\036\000\085\000\080\000\043\000\255\255\255\255\
    \255\255\255\255\255\255\053\000\070\000\069\000\255\255\255\255\
    \255\255\072\000\255\255\255\255\255\255\063\000\255\255\255\255\
    \081\000\075\000\078\000\077\000\255\255\255\255\255\255\012\000\
    \255\255\012\000\012\000\255\255\012\000\012\000\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \008\000\008\000\255\255\255\255\005\000\005\000\255\255\001\000\
    \005\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\003\000\255\255\255\255\003\000\255\255\255\255\255\255\
    \002\000\255\255\255\255\001\000\255\255\255\255\255\255\255\255\
    \255\255";
  Lexing.lex_default = 
   "\001\000\000\000\000\000\255\255\255\255\255\255\255\255\255\255\
    \255\255\000\000\255\255\255\255\000\000\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\000\000\000\000\000\000\255\255\
    \255\255\255\255\255\255\072\000\255\255\000\000\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \000\000\255\255\255\255\000\000\255\255\255\255\255\255\255\255\
    \255\255\000\000\000\000\255\255\255\255\000\000\000\000\000\000\
    \000\000\000\000\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\000\000\000\000\255\255\077\000\
    \255\255\255\255\255\255\000\000\000\000\000\000\255\255\255\255\
    \255\255\000\000\255\255\255\255\000\000\255\255\255\255\000\000\
    \255\255\000\000\255\255\000\000\255\255\255\255\000\000\255\255\
    \100\000\255\255\000\000\255\255\100\000\101\000\100\000\103\000\
    \000\000\255\255\255\255\255\255\255\255\255\255\000\000\000\000\
    \000\000\000\000\000\000\255\255\255\255\255\255\000\000\000\000\
    \000\000\255\255\000\000\000\000\000\000\255\255\000\000\000\000\
    \255\255\255\255\255\255\255\255\133\000\000\000\000\000\255\255\
    \000\000\147\000\255\255\000\000\255\255\255\255\000\000\000\000\
    \000\000\255\255\255\255\255\255\255\255\255\255\000\000\000\000\
    \000\000\255\255\255\255\255\255\000\000\255\255\255\255\000\000\
    \255\255\255\255\000\000\255\255\165\000\000\000\000\000\000\000\
    \255\255\171\000\000\000\000\000\255\255\255\255\000\000\255\255\
    \255\255\255\255\255\255\000\000\255\255\000\000\255\255\184\000\
    \000\000\255\255\000\000\000\000\255\255\255\255\000\000\255\255\
    \255\255\255\255\194\000\197\000\255\255\197\000\255\255\255\255\
    \000\000";
  Lexing.lex_trans = 
   "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\039\000\040\000\040\000\039\000\041\000\045\000\043\000\
    \043\000\040\000\044\000\044\000\045\000\073\000\098\000\104\000\
    \074\000\099\000\105\000\134\000\148\000\200\000\163\000\149\000\
    \039\000\008\000\029\000\024\000\006\000\004\000\023\000\027\000\
    \026\000\021\000\025\000\007\000\020\000\019\000\018\000\003\000\
    \031\000\030\000\030\000\030\000\030\000\030\000\030\000\030\000\
    \030\000\030\000\017\000\016\000\015\000\014\000\010\000\036\000\
    \005\000\033\000\033\000\033\000\033\000\033\000\033\000\033\000\
    \033\000\033\000\033\000\033\000\033\000\033\000\033\000\033\000\
    \033\000\033\000\033\000\033\000\033\000\033\000\033\000\033\000\
    \033\000\033\000\033\000\013\000\042\000\012\000\005\000\038\000\
    \022\000\035\000\035\000\035\000\035\000\035\000\035\000\035\000\
    \035\000\035\000\035\000\035\000\035\000\035\000\035\000\035\000\
    \035\000\035\000\035\000\035\000\035\000\035\000\035\000\035\000\
    \035\000\035\000\035\000\028\000\011\000\009\000\037\000\114\000\
    \116\000\113\000\110\000\088\000\112\000\111\000\039\000\076\000\
    \067\000\039\000\067\000\065\000\065\000\066\000\066\000\066\000\
    \066\000\066\000\066\000\066\000\066\000\066\000\066\000\119\000\
    \075\000\118\000\081\000\117\000\084\000\039\000\064\000\064\000\
    \064\000\064\000\064\000\064\000\064\000\064\000\066\000\066\000\
    \066\000\066\000\066\000\066\000\066\000\066\000\066\000\066\000\
    \082\000\082\000\082\000\082\000\082\000\082\000\082\000\082\000\
    \082\000\082\000\087\000\089\000\090\000\091\000\092\000\123\000\
    \032\000\032\000\032\000\032\000\032\000\032\000\032\000\032\000\
    \032\000\032\000\032\000\032\000\032\000\032\000\032\000\032\000\
    \032\000\032\000\032\000\032\000\032\000\032\000\032\000\120\000\
    \032\000\032\000\032\000\032\000\032\000\032\000\032\000\034\000\
    \034\000\034\000\034\000\034\000\034\000\034\000\034\000\034\000\
    \034\000\034\000\034\000\034\000\034\000\034\000\034\000\034\000\
    \034\000\034\000\034\000\034\000\034\000\034\000\034\000\121\000\
    \034\000\034\000\034\000\034\000\034\000\034\000\034\000\034\000\
    \002\000\003\000\091\000\092\000\003\000\003\000\003\000\122\000\
    \143\000\073\000\003\000\003\000\074\000\003\000\003\000\003\000\
    \083\000\083\000\083\000\083\000\083\000\083\000\083\000\083\000\
    \083\000\083\000\003\000\142\000\003\000\003\000\003\000\003\000\
    \003\000\152\000\098\000\151\000\003\000\099\000\255\255\003\000\
    \003\000\003\000\156\000\159\000\162\000\003\000\003\000\175\000\
    \003\000\003\000\003\000\193\000\194\000\134\000\098\000\104\000\
    \163\000\099\000\105\000\198\000\195\000\003\000\003\000\003\000\
    \003\000\003\000\003\000\003\000\199\000\167\000\175\000\005\000\
    \182\000\196\000\005\000\005\000\005\000\000\000\103\000\175\000\
    \005\000\005\000\177\000\005\000\005\000\005\000\000\000\000\000\
    \000\000\102\000\098\000\071\000\003\000\099\000\003\000\000\000\
    \005\000\003\000\005\000\005\000\005\000\005\000\005\000\000\000\
    \175\000\167\000\006\000\177\000\182\000\006\000\006\000\006\000\
    \102\000\000\000\101\000\006\000\006\000\196\000\006\000\006\000\
    \006\000\187\000\187\000\000\000\189\000\189\000\000\000\003\000\
    \000\000\003\000\000\000\006\000\005\000\006\000\006\000\006\000\
    \006\000\006\000\000\000\000\000\000\000\107\000\000\000\000\000\
    \107\000\107\000\107\000\000\000\000\000\000\000\107\000\107\000\
    \000\000\107\000\131\000\107\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\005\000\000\000\005\000\000\000\107\000\006\000\
    \107\000\130\000\107\000\107\000\107\000\000\000\000\000\000\000\
    \128\000\000\000\000\000\128\000\128\000\128\000\000\000\000\000\
    \000\000\128\000\128\000\000\000\128\000\128\000\128\000\187\000\
    \000\000\000\000\188\000\000\000\000\000\006\000\000\000\006\000\
    \000\000\128\000\107\000\128\000\129\000\128\000\128\000\128\000\
    \000\000\167\000\000\000\006\000\168\000\000\000\006\000\006\000\
    \006\000\000\000\000\000\000\000\006\000\006\000\000\000\006\000\
    \006\000\006\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \107\000\170\000\107\000\000\000\006\000\128\000\006\000\006\000\
    \006\000\006\000\006\000\000\000\000\000\000\000\000\000\000\000\
    \006\000\000\000\000\000\006\000\006\000\006\000\000\000\255\255\
    \000\000\006\000\006\000\000\000\006\000\006\000\006\000\000\000\
    \000\000\000\000\000\000\128\000\000\000\128\000\000\000\127\000\
    \006\000\006\000\000\000\006\000\006\000\006\000\006\000\006\000\
    \255\255\000\000\000\000\000\000\000\000\006\000\000\000\000\000\
    \006\000\006\000\006\000\169\000\000\000\000\000\006\000\006\000\
    \000\000\006\000\006\000\006\000\255\255\255\255\006\000\126\000\
    \006\000\185\000\255\255\000\000\124\000\006\000\006\000\000\000\
    \006\000\006\000\006\000\006\000\006\000\000\000\000\000\255\255\
    \006\000\000\000\000\000\006\000\006\000\006\000\000\000\000\000\
    \148\000\006\000\006\000\149\000\115\000\006\000\006\000\000\000\
    \255\255\000\000\000\000\125\000\000\000\006\000\000\000\000\000\
    \000\000\006\000\006\000\006\000\006\000\006\000\006\000\006\000\
    \000\000\000\000\000\000\107\000\000\000\150\000\107\000\107\000\
    \107\000\000\000\000\000\255\255\107\000\107\000\000\000\107\000\
    \108\000\107\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \006\000\000\000\006\000\000\000\107\000\006\000\107\000\107\000\
    \109\000\107\000\107\000\000\000\000\000\000\000\006\000\000\000\
    \000\000\006\000\006\000\106\000\000\000\000\000\000\000\006\000\
    \006\000\000\000\006\000\006\000\006\000\065\000\065\000\000\000\
    \000\000\000\000\146\000\006\000\000\000\006\000\000\000\006\000\
    \107\000\006\000\006\000\006\000\006\000\006\000\059\000\059\000\
    \059\000\059\000\059\000\059\000\059\000\059\000\059\000\059\000\
    \000\000\056\000\000\000\000\000\000\000\186\000\000\000\000\000\
    \000\000\000\000\000\000\058\000\000\000\000\000\107\000\000\000\
    \107\000\000\000\000\000\006\000\065\000\000\000\000\000\166\000\
    \000\000\000\000\000\000\000\000\000\000\097\000\000\000\000\000\
    \000\000\057\000\000\000\055\000\000\000\059\000\000\000\000\000\
    \000\000\000\000\000\000\058\000\000\000\000\000\000\000\000\000\
    \000\000\006\000\000\000\006\000\097\000\095\000\000\000\095\000\
    \095\000\095\000\095\000\000\000\000\000\000\000\095\000\095\000\
    \000\000\095\000\095\000\095\000\096\000\096\000\096\000\096\000\
    \096\000\096\000\096\000\096\000\096\000\096\000\095\000\000\000\
    \095\000\095\000\095\000\095\000\095\000\000\000\000\000\000\000\
    \003\000\000\000\000\000\003\000\003\000\003\000\000\000\000\000\
    \094\000\093\000\003\000\000\000\003\000\003\000\003\000\063\000\
    \063\000\063\000\063\000\063\000\063\000\063\000\063\000\063\000\
    \063\000\003\000\095\000\003\000\003\000\003\000\003\000\003\000\
    \063\000\063\000\063\000\063\000\063\000\063\000\066\000\066\000\
    \066\000\066\000\066\000\066\000\066\000\066\000\066\000\066\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\255\255\000\000\
    \095\000\068\000\095\000\000\000\000\000\003\000\000\000\000\000\
    \063\000\063\000\063\000\063\000\063\000\063\000\157\000\157\000\
    \157\000\157\000\157\000\157\000\157\000\157\000\157\000\157\000\
    \000\000\000\000\000\000\000\000\000\000\066\000\000\000\000\000\
    \000\000\000\000\000\000\003\000\070\000\003\000\070\000\070\000\
    \070\000\070\000\070\000\070\000\070\000\070\000\070\000\070\000\
    \070\000\070\000\070\000\070\000\070\000\070\000\070\000\070\000\
    \070\000\070\000\070\000\070\000\070\000\070\000\070\000\070\000\
    \059\000\069\000\030\000\030\000\030\000\030\000\030\000\030\000\
    \030\000\030\000\030\000\030\000\158\000\158\000\158\000\158\000\
    \158\000\158\000\158\000\158\000\158\000\158\000\000\000\058\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\056\000\000\000\
    \000\000\059\000\000\000\030\000\030\000\030\000\030\000\030\000\
    \030\000\030\000\030\000\030\000\030\000\000\000\000\000\000\000\
    \000\000\030\000\000\000\000\000\000\000\060\000\000\000\058\000\
    \058\000\000\000\000\000\000\000\000\000\000\000\057\000\056\000\
    \055\000\000\000\061\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\062\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\030\000\000\000\000\000\060\000\000\000\000\000\
    \058\000\000\000\000\000\000\000\000\000\000\000\000\000\057\000\
    \000\000\055\000\061\000\032\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\062\000\032\000\032\000\032\000\032\000\
    \032\000\032\000\032\000\032\000\032\000\032\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\032\000\032\000\032\000\
    \032\000\032\000\032\000\032\000\032\000\032\000\032\000\032\000\
    \032\000\032\000\032\000\032\000\032\000\032\000\032\000\032\000\
    \032\000\032\000\032\000\032\000\032\000\032\000\032\000\000\000\
    \000\000\000\000\000\000\032\000\000\000\032\000\032\000\032\000\
    \032\000\032\000\032\000\032\000\032\000\032\000\032\000\032\000\
    \032\000\032\000\032\000\032\000\032\000\032\000\032\000\032\000\
    \032\000\032\000\032\000\032\000\032\000\032\000\032\000\063\000\
    \063\000\063\000\063\000\063\000\063\000\063\000\063\000\063\000\
    \063\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \063\000\063\000\063\000\063\000\063\000\063\000\000\000\000\000\
    \000\000\000\000\000\000\056\000\178\000\178\000\178\000\178\000\
    \178\000\178\000\178\000\178\000\178\000\178\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\063\000\000\000\
    \063\000\063\000\063\000\063\000\063\000\063\000\000\000\000\000\
    \000\000\000\000\000\000\057\000\000\000\055\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\032\000\032\000\032\000\032\000\
    \032\000\032\000\032\000\032\000\032\000\032\000\032\000\032\000\
    \032\000\032\000\032\000\032\000\032\000\032\000\032\000\032\000\
    \032\000\032\000\032\000\000\000\032\000\032\000\032\000\032\000\
    \032\000\032\000\032\000\032\000\032\000\032\000\032\000\032\000\
    \032\000\032\000\032\000\032\000\032\000\032\000\032\000\032\000\
    \032\000\032\000\032\000\032\000\032\000\032\000\032\000\032\000\
    \032\000\032\000\032\000\033\000\032\000\032\000\032\000\032\000\
    \032\000\032\000\032\000\032\000\033\000\033\000\033\000\033\000\
    \033\000\033\000\033\000\033\000\033\000\033\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\033\000\033\000\033\000\
    \033\000\033\000\033\000\033\000\033\000\033\000\033\000\033\000\
    \033\000\033\000\033\000\033\000\033\000\033\000\033\000\033\000\
    \033\000\033\000\033\000\033\000\033\000\033\000\033\000\000\000\
    \000\000\000\000\000\000\033\000\000\000\033\000\033\000\033\000\
    \033\000\033\000\033\000\033\000\033\000\033\000\033\000\033\000\
    \033\000\033\000\033\000\033\000\033\000\033\000\033\000\033\000\
    \033\000\033\000\033\000\033\000\033\000\033\000\033\000\064\000\
    \064\000\064\000\064\000\064\000\064\000\064\000\064\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\085\000\085\000\085\000\
    \085\000\085\000\085\000\085\000\085\000\085\000\085\000\000\000\
    \000\000\000\000\000\000\056\000\000\000\000\000\085\000\085\000\
    \085\000\085\000\085\000\085\000\179\000\179\000\179\000\179\000\
    \179\000\179\000\179\000\179\000\179\000\179\000\064\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\057\000\000\000\055\000\085\000\085\000\
    \085\000\085\000\085\000\085\000\032\000\032\000\032\000\032\000\
    \032\000\032\000\032\000\032\000\032\000\032\000\032\000\032\000\
    \032\000\032\000\032\000\032\000\032\000\032\000\032\000\032\000\
    \032\000\032\000\032\000\000\000\032\000\032\000\032\000\032\000\
    \032\000\032\000\032\000\032\000\032\000\032\000\032\000\032\000\
    \032\000\032\000\032\000\032\000\032\000\032\000\032\000\032\000\
    \032\000\032\000\032\000\032\000\032\000\032\000\032\000\032\000\
    \032\000\032\000\032\000\034\000\032\000\032\000\032\000\032\000\
    \032\000\032\000\032\000\032\000\034\000\034\000\034\000\034\000\
    \034\000\034\000\034\000\034\000\034\000\034\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\034\000\034\000\034\000\
    \034\000\034\000\034\000\034\000\034\000\034\000\034\000\034\000\
    \034\000\034\000\034\000\034\000\034\000\034\000\034\000\034\000\
    \034\000\034\000\034\000\034\000\034\000\034\000\034\000\000\000\
    \000\000\000\000\000\000\034\000\000\000\034\000\034\000\034\000\
    \034\000\034\000\034\000\034\000\034\000\034\000\034\000\034\000\
    \034\000\034\000\034\000\034\000\034\000\034\000\034\000\034\000\
    \034\000\034\000\034\000\034\000\034\000\034\000\034\000\070\000\
    \000\000\070\000\070\000\070\000\070\000\070\000\070\000\070\000\
    \070\000\070\000\070\000\070\000\070\000\070\000\070\000\070\000\
    \070\000\070\000\070\000\070\000\070\000\070\000\070\000\070\000\
    \070\000\070\000\070\000\000\000\069\000\134\000\000\000\000\000\
    \135\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\139\000\000\000\000\000\
    \000\000\000\000\137\000\141\000\000\000\140\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\034\000\034\000\034\000\034\000\
    \034\000\034\000\034\000\034\000\034\000\034\000\034\000\034\000\
    \034\000\034\000\034\000\034\000\034\000\034\000\034\000\034\000\
    \034\000\034\000\034\000\000\000\034\000\034\000\034\000\034\000\
    \034\000\034\000\034\000\034\000\034\000\034\000\034\000\034\000\
    \034\000\034\000\034\000\034\000\034\000\034\000\034\000\034\000\
    \034\000\034\000\034\000\034\000\034\000\034\000\034\000\034\000\
    \034\000\034\000\034\000\035\000\034\000\034\000\034\000\034\000\
    \034\000\034\000\034\000\034\000\035\000\035\000\035\000\035\000\
    \035\000\035\000\035\000\035\000\035\000\035\000\138\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\035\000\035\000\035\000\
    \035\000\035\000\035\000\035\000\035\000\035\000\035\000\035\000\
    \035\000\035\000\035\000\035\000\035\000\035\000\035\000\035\000\
    \035\000\035\000\035\000\035\000\035\000\035\000\035\000\000\000\
    \000\000\000\000\000\000\035\000\000\000\035\000\035\000\035\000\
    \035\000\035\000\035\000\035\000\035\000\035\000\035\000\035\000\
    \035\000\035\000\035\000\035\000\035\000\035\000\035\000\035\000\
    \035\000\035\000\035\000\035\000\035\000\035\000\035\000\086\000\
    \086\000\086\000\086\000\086\000\086\000\086\000\086\000\086\000\
    \086\000\000\000\000\000\000\000\000\000\000\000\000\000\097\000\
    \086\000\086\000\086\000\086\000\086\000\086\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\097\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \086\000\086\000\086\000\086\000\086\000\086\000\096\000\096\000\
    \096\000\096\000\096\000\096\000\096\000\096\000\096\000\096\000\
    \000\000\000\000\000\000\136\000\034\000\034\000\034\000\034\000\
    \034\000\034\000\034\000\034\000\034\000\034\000\034\000\034\000\
    \034\000\034\000\034\000\034\000\034\000\034\000\034\000\034\000\
    \034\000\034\000\034\000\000\000\034\000\034\000\034\000\034\000\
    \034\000\034\000\034\000\034\000\034\000\034\000\034\000\034\000\
    \034\000\034\000\034\000\034\000\034\000\034\000\034\000\034\000\
    \034\000\034\000\034\000\034\000\034\000\034\000\034\000\034\000\
    \034\000\034\000\034\000\000\000\034\000\034\000\034\000\034\000\
    \034\000\034\000\034\000\034\000\046\000\000\000\000\000\046\000\
    \046\000\046\000\000\000\000\000\000\000\046\000\046\000\000\000\
    \046\000\046\000\046\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\046\000\000\000\046\000\
    \046\000\046\000\046\000\046\000\000\000\191\000\000\000\191\000\
    \191\000\191\000\191\000\191\000\191\000\191\000\191\000\191\000\
    \191\000\191\000\191\000\191\000\191\000\191\000\191\000\191\000\
    \191\000\191\000\191\000\191\000\191\000\191\000\191\000\191\000\
    \191\000\046\000\052\000\190\000\052\000\052\000\052\000\052\000\
    \052\000\052\000\052\000\052\000\052\000\052\000\052\000\052\000\
    \052\000\052\000\052\000\052\000\052\000\052\000\052\000\052\000\
    \052\000\052\000\052\000\052\000\052\000\052\000\000\000\046\000\
    \046\000\046\000\000\000\046\000\046\000\046\000\000\000\000\000\
    \000\000\046\000\046\000\000\000\046\000\046\000\046\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\046\000\000\000\046\000\046\000\046\000\046\000\046\000\
    \000\000\191\000\000\000\191\000\191\000\191\000\191\000\191\000\
    \191\000\191\000\191\000\191\000\191\000\191\000\191\000\191\000\
    \191\000\191\000\191\000\191\000\191\000\191\000\191\000\191\000\
    \191\000\191\000\191\000\191\000\191\000\046\000\048\000\190\000\
    \048\000\048\000\048\000\048\000\048\000\048\000\048\000\048\000\
    \048\000\048\000\048\000\048\000\048\000\048\000\048\000\048\000\
    \048\000\048\000\048\000\048\000\048\000\048\000\048\000\048\000\
    \048\000\048\000\000\000\046\000\000\000\046\000\000\000\000\000\
    \000\000\000\000\051\000\051\000\051\000\051\000\051\000\051\000\
    \051\000\051\000\051\000\051\000\051\000\051\000\051\000\051\000\
    \051\000\051\000\051\000\051\000\051\000\051\000\051\000\051\000\
    \051\000\051\000\000\000\051\000\051\000\051\000\051\000\051\000\
    \051\000\051\000\051\000\145\000\000\000\145\000\145\000\145\000\
    \145\000\145\000\145\000\145\000\145\000\145\000\145\000\145\000\
    \145\000\145\000\145\000\145\000\145\000\145\000\145\000\145\000\
    \145\000\145\000\145\000\145\000\145\000\145\000\145\000\145\000\
    \144\000\145\000\145\000\145\000\145\000\145\000\145\000\145\000\
    \145\000\145\000\145\000\145\000\145\000\145\000\145\000\145\000\
    \145\000\145\000\145\000\145\000\145\000\145\000\145\000\145\000\
    \145\000\145\000\145\000\000\000\144\000\000\000\047\000\047\000\
    \047\000\047\000\047\000\047\000\047\000\047\000\047\000\047\000\
    \047\000\047\000\047\000\047\000\047\000\047\000\047\000\047\000\
    \047\000\047\000\047\000\047\000\047\000\047\000\035\000\047\000\
    \047\000\047\000\047\000\047\000\047\000\047\000\047\000\035\000\
    \035\000\035\000\035\000\035\000\035\000\035\000\035\000\035\000\
    \035\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \035\000\035\000\035\000\035\000\035\000\035\000\035\000\035\000\
    \035\000\035\000\035\000\035\000\035\000\035\000\035\000\035\000\
    \035\000\035\000\035\000\035\000\035\000\035\000\035\000\035\000\
    \035\000\035\000\000\000\000\000\000\000\000\000\035\000\000\000\
    \035\000\035\000\035\000\035\000\035\000\035\000\035\000\035\000\
    \035\000\035\000\035\000\035\000\035\000\035\000\035\000\035\000\
    \035\000\035\000\035\000\035\000\035\000\035\000\035\000\035\000\
    \035\000\035\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \102\000\098\000\000\000\000\000\099\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\102\000\
    \000\000\101\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\096\000\
    \096\000\096\000\096\000\096\000\096\000\096\000\096\000\096\000\
    \096\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\034\000\
    \034\000\034\000\034\000\034\000\034\000\034\000\034\000\034\000\
    \034\000\034\000\034\000\034\000\034\000\034\000\034\000\034\000\
    \034\000\034\000\034\000\034\000\034\000\034\000\000\000\034\000\
    \034\000\034\000\034\000\034\000\034\000\034\000\034\000\034\000\
    \034\000\034\000\034\000\034\000\034\000\034\000\034\000\034\000\
    \034\000\034\000\034\000\034\000\034\000\034\000\034\000\034\000\
    \034\000\034\000\034\000\034\000\034\000\034\000\000\000\034\000\
    \034\000\034\000\034\000\034\000\034\000\034\000\034\000\046\000\
    \000\000\000\000\046\000\046\000\046\000\000\000\000\000\000\000\
    \046\000\046\000\000\000\046\000\046\000\046\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \046\000\000\000\046\000\046\000\046\000\046\000\046\000\000\000\
    \000\000\000\000\000\000\047\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\047\000\047\000\047\000\047\000\
    \047\000\047\000\047\000\047\000\047\000\047\000\050\000\000\000\
    \000\000\000\000\000\000\000\000\046\000\047\000\047\000\047\000\
    \047\000\047\000\047\000\047\000\047\000\047\000\047\000\047\000\
    \047\000\047\000\047\000\047\000\047\000\047\000\047\000\047\000\
    \047\000\047\000\047\000\047\000\047\000\047\000\047\000\000\000\
    \000\000\000\000\046\000\047\000\046\000\047\000\047\000\047\000\
    \047\000\047\000\047\000\047\000\047\000\047\000\047\000\047\000\
    \047\000\047\000\047\000\047\000\047\000\047\000\047\000\047\000\
    \047\000\047\000\047\000\047\000\047\000\047\000\047\000\255\255\
    \160\000\160\000\160\000\160\000\160\000\160\000\160\000\160\000\
    \160\000\160\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\160\000\160\000\160\000\160\000\160\000\160\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\160\000\160\000\160\000\160\000\160\000\160\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\047\000\047\000\047\000\047\000\
    \047\000\047\000\047\000\047\000\047\000\047\000\047\000\047\000\
    \047\000\047\000\047\000\047\000\047\000\047\000\047\000\047\000\
    \047\000\047\000\047\000\000\000\047\000\047\000\047\000\047\000\
    \047\000\047\000\047\000\047\000\047\000\047\000\047\000\047\000\
    \047\000\047\000\047\000\047\000\047\000\047\000\047\000\047\000\
    \047\000\047\000\047\000\047\000\047\000\047\000\047\000\047\000\
    \047\000\047\000\047\000\048\000\047\000\047\000\047\000\047\000\
    \047\000\047\000\047\000\047\000\048\000\048\000\048\000\048\000\
    \048\000\048\000\048\000\048\000\048\000\048\000\049\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\048\000\048\000\048\000\
    \048\000\048\000\048\000\048\000\048\000\048\000\048\000\048\000\
    \048\000\048\000\048\000\048\000\048\000\048\000\048\000\048\000\
    \048\000\048\000\048\000\048\000\048\000\048\000\048\000\000\000\
    \000\000\000\000\000\000\048\000\000\000\048\000\048\000\048\000\
    \048\000\048\000\048\000\048\000\048\000\048\000\048\000\048\000\
    \048\000\048\000\048\000\048\000\048\000\048\000\048\000\048\000\
    \048\000\048\000\048\000\048\000\048\000\048\000\048\000\161\000\
    \161\000\161\000\161\000\161\000\161\000\161\000\161\000\161\000\
    \161\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \161\000\161\000\161\000\161\000\161\000\161\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \161\000\161\000\161\000\161\000\161\000\161\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\047\000\047\000\047\000\047\000\
    \047\000\047\000\047\000\047\000\047\000\047\000\047\000\047\000\
    \047\000\047\000\047\000\047\000\047\000\047\000\047\000\047\000\
    \047\000\047\000\047\000\000\000\047\000\047\000\047\000\047\000\
    \047\000\047\000\047\000\047\000\047\000\047\000\047\000\047\000\
    \047\000\047\000\047\000\047\000\047\000\047\000\047\000\047\000\
    \047\000\047\000\047\000\047\000\047\000\047\000\047\000\047\000\
    \047\000\047\000\047\000\051\000\047\000\047\000\047\000\047\000\
    \047\000\047\000\047\000\047\000\051\000\051\000\051\000\051\000\
    \051\000\051\000\051\000\051\000\051\000\051\000\054\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\051\000\051\000\051\000\
    \051\000\051\000\051\000\051\000\051\000\051\000\051\000\051\000\
    \051\000\051\000\051\000\051\000\051\000\051\000\051\000\051\000\
    \051\000\051\000\051\000\051\000\051\000\051\000\051\000\000\000\
    \000\000\000\000\000\000\051\000\000\000\051\000\051\000\051\000\
    \051\000\051\000\051\000\051\000\051\000\051\000\051\000\051\000\
    \051\000\051\000\051\000\051\000\051\000\051\000\051\000\051\000\
    \051\000\051\000\051\000\051\000\051\000\051\000\051\000\180\000\
    \180\000\180\000\180\000\180\000\180\000\180\000\180\000\180\000\
    \180\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \180\000\180\000\180\000\180\000\180\000\180\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \180\000\180\000\180\000\180\000\180\000\180\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\051\000\051\000\051\000\051\000\
    \051\000\051\000\051\000\051\000\051\000\051\000\051\000\051\000\
    \051\000\051\000\051\000\051\000\051\000\051\000\051\000\051\000\
    \051\000\051\000\051\000\000\000\051\000\051\000\051\000\051\000\
    \051\000\051\000\051\000\051\000\051\000\051\000\051\000\051\000\
    \051\000\051\000\051\000\051\000\051\000\051\000\051\000\051\000\
    \051\000\051\000\051\000\051\000\051\000\051\000\051\000\051\000\
    \051\000\051\000\051\000\052\000\051\000\051\000\051\000\051\000\
    \051\000\051\000\051\000\051\000\052\000\052\000\052\000\052\000\
    \052\000\052\000\052\000\052\000\052\000\052\000\053\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\052\000\052\000\052\000\
    \052\000\052\000\052\000\052\000\052\000\052\000\052\000\052\000\
    \052\000\052\000\052\000\052\000\052\000\052\000\052\000\052\000\
    \052\000\052\000\052\000\052\000\052\000\052\000\052\000\000\000\
    \000\000\000\000\000\000\052\000\000\000\052\000\052\000\052\000\
    \052\000\052\000\052\000\052\000\052\000\052\000\052\000\052\000\
    \052\000\052\000\052\000\052\000\052\000\052\000\052\000\052\000\
    \052\000\052\000\052\000\052\000\052\000\052\000\052\000\181\000\
    \181\000\181\000\181\000\181\000\181\000\181\000\181\000\181\000\
    \181\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \181\000\181\000\181\000\181\000\181\000\181\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \181\000\181\000\181\000\181\000\181\000\181\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\051\000\051\000\051\000\051\000\
    \051\000\051\000\051\000\051\000\051\000\051\000\051\000\051\000\
    \051\000\051\000\051\000\051\000\051\000\051\000\051\000\051\000\
    \051\000\051\000\051\000\000\000\051\000\051\000\051\000\051\000\
    \051\000\051\000\051\000\051\000\051\000\051\000\051\000\051\000\
    \051\000\051\000\051\000\051\000\051\000\051\000\051\000\051\000\
    \051\000\051\000\051\000\051\000\051\000\051\000\051\000\051\000\
    \051\000\051\000\051\000\000\000\051\000\051\000\051\000\051\000\
    \051\000\051\000\051\000\051\000\080\000\093\000\080\000\000\000\
    \093\000\093\000\093\000\080\000\000\000\000\000\093\000\093\000\
    \000\000\093\000\093\000\093\000\079\000\079\000\079\000\079\000\
    \079\000\079\000\079\000\079\000\079\000\079\000\093\000\000\000\
    \093\000\093\000\093\000\093\000\093\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\095\000\000\000\095\000\095\000\
    \095\000\095\000\000\000\000\000\000\000\095\000\095\000\000\000\
    \095\000\095\000\095\000\000\000\000\000\000\000\000\000\000\000\
    \080\000\000\000\093\000\000\000\000\000\095\000\080\000\095\000\
    \095\000\095\000\095\000\095\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\080\000\000\000\000\000\000\000\080\000\000\000\
    \080\000\000\000\006\000\000\000\078\000\006\000\006\000\006\000\
    \093\000\000\000\093\000\006\000\006\000\000\000\006\000\006\000\
    \006\000\095\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\006\000\000\000\006\000\006\000\006\000\
    \006\000\006\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\107\000\000\000\000\000\107\000\107\000\107\000\095\000\
    \000\000\095\000\107\000\107\000\000\000\107\000\107\000\107\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\006\000\
    \000\000\000\000\107\000\000\000\107\000\107\000\107\000\107\000\
    \107\000\000\000\000\000\000\000\107\000\000\000\000\000\107\000\
    \107\000\107\000\000\000\000\000\000\000\107\000\107\000\000\000\
    \107\000\107\000\107\000\000\000\000\000\006\000\000\000\006\000\
    \000\000\000\000\000\000\000\000\000\000\107\000\107\000\107\000\
    \107\000\107\000\107\000\107\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\107\000\000\000\000\000\107\000\107\000\107\000\
    \000\000\000\000\000\000\107\000\107\000\000\000\107\000\107\000\
    \107\000\000\000\000\000\000\000\107\000\000\000\107\000\000\000\
    \000\000\107\000\000\000\107\000\255\255\107\000\107\000\107\000\
    \107\000\107\000\000\000\000\000\000\000\006\000\000\000\000\000\
    \006\000\006\000\006\000\000\000\000\000\000\000\006\000\006\000\
    \000\000\006\000\006\000\006\000\000\000\000\000\000\000\107\000\
    \000\000\107\000\000\000\000\000\000\000\000\000\006\000\107\000\
    \006\000\006\000\006\000\006\000\006\000\000\000\000\000\000\000\
    \006\000\000\000\000\000\006\000\006\000\006\000\000\000\000\000\
    \000\000\006\000\006\000\000\000\006\000\006\000\006\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\107\000\000\000\107\000\
    \000\000\006\000\006\000\006\000\006\000\006\000\006\000\006\000\
    \000\000\000\000\000\000\128\000\000\000\000\000\128\000\128\000\
    \128\000\000\000\000\000\000\000\128\000\128\000\000\000\128\000\
    \128\000\128\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \006\000\000\000\006\000\000\000\128\000\006\000\128\000\128\000\
    \128\000\128\000\128\000\000\000\000\000\000\000\128\000\000\000\
    \000\000\128\000\128\000\128\000\000\000\000\000\000\000\128\000\
    \128\000\000\000\128\000\128\000\128\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\006\000\000\000\006\000\000\000\128\000\
    \128\000\128\000\128\000\128\000\128\000\128\000\000\000\000\000\
    \000\000\107\000\000\000\000\000\107\000\107\000\107\000\000\000\
    \000\000\000\000\107\000\107\000\000\000\107\000\107\000\107\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\128\000\000\000\
    \128\000\000\000\107\000\128\000\107\000\107\000\107\000\107\000\
    \107\000\000\000\000\000\000\000\107\000\000\000\000\000\107\000\
    \107\000\107\000\000\000\000\000\000\000\107\000\107\000\000\000\
    \107\000\107\000\107\000\000\000\000\000\155\000\000\000\155\000\
    \000\000\128\000\000\000\128\000\155\000\107\000\107\000\107\000\
    \107\000\107\000\107\000\107\000\000\000\154\000\154\000\154\000\
    \154\000\154\000\154\000\154\000\154\000\154\000\154\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\107\000\000\000\107\000\000\000\
    \000\000\107\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \175\000\000\000\000\000\176\000\000\000\000\000\000\000\000\000\
    \000\000\155\000\000\000\000\000\000\000\000\000\000\000\155\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\174\000\107\000\
    \174\000\107\000\000\000\155\000\000\000\174\000\000\000\155\000\
    \000\000\155\000\000\000\000\000\000\000\153\000\173\000\173\000\
    \173\000\173\000\173\000\173\000\173\000\173\000\173\000\173\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\174\000\000\000\000\000\000\000\000\000\000\000\
    \174\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\174\000\000\000\000\000\000\000\
    \174\000\000\000\174\000\000\000\000\000\000\000\172\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\255\255";
  Lexing.lex_check = 
   "\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\000\000\000\000\041\000\000\000\000\000\041\000\042\000\
    \044\000\045\000\042\000\044\000\045\000\074\000\099\000\105\000\
    \074\000\099\000\105\000\135\000\149\000\199\000\135\000\149\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\016\000\
    \013\000\017\000\018\000\026\000\017\000\017\000\039\000\072\000\
    \058\000\039\000\058\000\060\000\060\000\058\000\058\000\058\000\
    \058\000\058\000\058\000\058\000\058\000\058\000\058\000\013\000\
    \073\000\013\000\080\000\013\000\083\000\039\000\061\000\061\000\
    \061\000\061\000\061\000\061\000\061\000\061\000\067\000\067\000\
    \067\000\067\000\067\000\067\000\067\000\067\000\067\000\067\000\
    \079\000\079\000\079\000\079\000\079\000\079\000\079\000\079\000\
    \079\000\079\000\086\000\088\000\088\000\090\000\090\000\116\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\013\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\117\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\003\000\092\000\092\000\003\000\003\000\003\000\121\000\
    \140\000\027\000\003\000\003\000\027\000\003\000\003\000\003\000\
    \082\000\082\000\082\000\082\000\082\000\082\000\082\000\082\000\
    \082\000\082\000\003\000\141\000\003\000\003\000\003\000\003\000\
    \003\000\147\000\100\000\148\000\004\000\100\000\027\000\004\000\
    \004\000\004\000\155\000\158\000\161\000\004\000\004\000\175\000\
    \004\000\004\000\004\000\192\000\193\000\163\000\101\000\103\000\
    \163\000\101\000\103\000\196\000\194\000\004\000\003\000\004\000\
    \004\000\004\000\004\000\004\000\198\000\168\000\175\000\005\000\
    \168\000\195\000\005\000\005\000\005\000\255\255\101\000\176\000\
    \005\000\005\000\176\000\005\000\005\000\005\000\255\255\255\255\
    \255\255\102\000\102\000\027\000\003\000\102\000\003\000\255\255\
    \005\000\004\000\005\000\005\000\005\000\005\000\005\000\255\255\
    \177\000\182\000\006\000\177\000\182\000\006\000\006\000\006\000\
    \102\000\255\255\102\000\006\000\006\000\197\000\006\000\006\000\
    \006\000\188\000\189\000\255\255\188\000\189\000\255\255\004\000\
    \255\255\004\000\255\255\006\000\005\000\006\000\006\000\006\000\
    \006\000\006\000\255\255\255\255\255\255\007\000\255\255\255\255\
    \007\000\007\000\007\000\255\255\255\255\255\255\007\000\007\000\
    \255\255\007\000\007\000\007\000\255\255\255\255\255\255\255\255\
    \255\255\255\255\005\000\255\255\005\000\255\255\007\000\006\000\
    \007\000\007\000\007\000\007\000\007\000\255\255\255\255\255\255\
    \008\000\255\255\255\255\008\000\008\000\008\000\255\255\255\255\
    \255\255\008\000\008\000\255\255\008\000\008\000\008\000\183\000\
    \255\255\255\255\183\000\255\255\255\255\006\000\255\255\006\000\
    \255\255\008\000\007\000\008\000\008\000\008\000\008\000\008\000\
    \255\255\164\000\255\255\010\000\164\000\255\255\010\000\010\000\
    \010\000\255\255\255\255\255\255\010\000\010\000\255\255\010\000\
    \010\000\010\000\255\255\255\255\255\255\255\255\255\255\255\255\
    \007\000\164\000\007\000\255\255\010\000\008\000\010\000\010\000\
    \010\000\010\000\010\000\255\255\255\255\255\255\255\255\255\255\
    \011\000\255\255\255\255\011\000\011\000\011\000\255\255\027\000\
    \255\255\011\000\011\000\255\255\011\000\011\000\011\000\255\255\
    \255\255\255\255\255\255\008\000\255\255\008\000\255\255\010\000\
    \010\000\011\000\255\255\011\000\011\000\011\000\011\000\011\000\
    \100\000\255\255\255\255\255\255\255\255\014\000\255\255\255\255\
    \014\000\014\000\014\000\164\000\255\255\255\255\014\000\014\000\
    \255\255\014\000\014\000\014\000\101\000\103\000\010\000\010\000\
    \010\000\183\000\194\000\255\255\011\000\011\000\014\000\255\255\
    \014\000\014\000\014\000\014\000\014\000\255\255\255\255\195\000\
    \015\000\255\255\255\255\015\000\015\000\015\000\255\255\255\255\
    \137\000\015\000\015\000\137\000\015\000\015\000\015\000\255\255\
    \102\000\255\255\255\255\011\000\255\255\011\000\255\255\255\255\
    \255\255\015\000\014\000\015\000\015\000\015\000\015\000\015\000\
    \255\255\255\255\255\255\019\000\255\255\137\000\019\000\019\000\
    \019\000\255\255\255\255\197\000\019\000\019\000\255\255\019\000\
    \019\000\019\000\255\255\255\255\255\255\255\255\255\255\255\255\
    \014\000\255\255\014\000\255\255\019\000\015\000\019\000\019\000\
    \019\000\019\000\019\000\255\255\255\255\255\255\023\000\255\255\
    \255\255\023\000\023\000\023\000\255\255\255\255\255\255\023\000\
    \023\000\255\255\023\000\023\000\023\000\065\000\065\000\255\255\
    \255\255\255\255\137\000\015\000\255\255\015\000\255\255\023\000\
    \019\000\023\000\023\000\023\000\023\000\023\000\059\000\059\000\
    \059\000\059\000\059\000\059\000\059\000\059\000\059\000\059\000\
    \255\255\065\000\255\255\255\255\255\255\183\000\255\255\255\255\
    \255\255\255\255\255\255\059\000\255\255\255\255\019\000\255\255\
    \019\000\255\255\255\255\023\000\065\000\255\255\255\255\164\000\
    \255\255\255\255\255\255\255\255\255\255\024\000\255\255\255\255\
    \255\255\065\000\255\255\065\000\255\255\059\000\255\255\255\255\
    \255\255\255\255\255\255\059\000\255\255\255\255\255\255\255\255\
    \255\255\023\000\255\255\023\000\024\000\024\000\255\255\024\000\
    \024\000\024\000\024\000\255\255\255\255\255\255\024\000\024\000\
    \255\255\024\000\024\000\024\000\024\000\024\000\024\000\024\000\
    \024\000\024\000\024\000\024\000\024\000\024\000\024\000\255\255\
    \024\000\024\000\024\000\024\000\024\000\255\255\255\255\255\255\
    \025\000\255\255\255\255\025\000\025\000\025\000\255\255\255\255\
    \025\000\025\000\025\000\255\255\025\000\025\000\025\000\062\000\
    \062\000\062\000\062\000\062\000\062\000\062\000\062\000\062\000\
    \062\000\025\000\024\000\025\000\025\000\025\000\025\000\025\000\
    \062\000\062\000\062\000\062\000\062\000\062\000\066\000\066\000\
    \066\000\066\000\066\000\066\000\066\000\066\000\066\000\066\000\
    \255\255\255\255\255\255\255\255\255\255\255\255\137\000\255\255\
    \024\000\028\000\024\000\255\255\255\255\025\000\255\255\255\255\
    \062\000\062\000\062\000\062\000\062\000\062\000\154\000\154\000\
    \154\000\154\000\154\000\154\000\154\000\154\000\154\000\154\000\
    \255\255\255\255\255\255\255\255\255\255\066\000\255\255\255\255\
    \255\255\255\255\255\255\025\000\028\000\025\000\028\000\028\000\
    \028\000\028\000\028\000\028\000\028\000\028\000\028\000\028\000\
    \028\000\028\000\028\000\028\000\028\000\028\000\028\000\028\000\
    \028\000\028\000\028\000\028\000\028\000\028\000\028\000\028\000\
    \030\000\028\000\030\000\030\000\030\000\030\000\030\000\030\000\
    \030\000\030\000\030\000\030\000\157\000\157\000\157\000\157\000\
    \157\000\157\000\157\000\157\000\157\000\157\000\255\255\030\000\
    \255\255\255\255\255\255\255\255\255\255\255\255\030\000\255\255\
    \255\255\031\000\255\255\031\000\031\000\031\000\031\000\031\000\
    \031\000\031\000\031\000\031\000\031\000\255\255\255\255\255\255\
    \255\255\030\000\255\255\255\255\255\255\031\000\255\255\030\000\
    \031\000\255\255\255\255\255\255\255\255\255\255\030\000\031\000\
    \030\000\255\255\031\000\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\031\000\255\255\255\255\255\255\255\255\
    \255\255\255\255\031\000\255\255\255\255\031\000\255\255\255\255\
    \031\000\255\255\255\255\255\255\255\255\255\255\255\255\031\000\
    \255\255\031\000\031\000\032\000\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\031\000\032\000\032\000\032\000\032\000\
    \032\000\032\000\032\000\032\000\032\000\032\000\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\032\000\032\000\032\000\
    \032\000\032\000\032\000\032\000\032\000\032\000\032\000\032\000\
    \032\000\032\000\032\000\032\000\032\000\032\000\032\000\032\000\
    \032\000\032\000\032\000\032\000\032\000\032\000\032\000\255\255\
    \255\255\255\255\255\255\032\000\255\255\032\000\032\000\032\000\
    \032\000\032\000\032\000\032\000\032\000\032\000\032\000\032\000\
    \032\000\032\000\032\000\032\000\032\000\032\000\032\000\032\000\
    \032\000\032\000\032\000\032\000\032\000\032\000\032\000\063\000\
    \063\000\063\000\063\000\063\000\063\000\063\000\063\000\063\000\
    \063\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \063\000\063\000\063\000\063\000\063\000\063\000\255\255\255\255\
    \255\255\255\255\255\255\063\000\173\000\173\000\173\000\173\000\
    \173\000\173\000\173\000\173\000\173\000\173\000\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\063\000\255\255\
    \063\000\063\000\063\000\063\000\063\000\063\000\255\255\255\255\
    \255\255\255\255\255\255\063\000\255\255\063\000\255\255\255\255\
    \255\255\255\255\255\255\255\255\032\000\032\000\032\000\032\000\
    \032\000\032\000\032\000\032\000\032\000\032\000\032\000\032\000\
    \032\000\032\000\032\000\032\000\032\000\032\000\032\000\032\000\
    \032\000\032\000\032\000\255\255\032\000\032\000\032\000\032\000\
    \032\000\032\000\032\000\032\000\032\000\032\000\032\000\032\000\
    \032\000\032\000\032\000\032\000\032\000\032\000\032\000\032\000\
    \032\000\032\000\032\000\032\000\032\000\032\000\032\000\032\000\
    \032\000\032\000\032\000\033\000\032\000\032\000\032\000\032\000\
    \032\000\032\000\032\000\032\000\033\000\033\000\033\000\033\000\
    \033\000\033\000\033\000\033\000\033\000\033\000\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\033\000\033\000\033\000\
    \033\000\033\000\033\000\033\000\033\000\033\000\033\000\033\000\
    \033\000\033\000\033\000\033\000\033\000\033\000\033\000\033\000\
    \033\000\033\000\033\000\033\000\033\000\033\000\033\000\255\255\
    \255\255\255\255\255\255\033\000\255\255\033\000\033\000\033\000\
    \033\000\033\000\033\000\033\000\033\000\033\000\033\000\033\000\
    \033\000\033\000\033\000\033\000\033\000\033\000\033\000\033\000\
    \033\000\033\000\033\000\033\000\033\000\033\000\033\000\064\000\
    \064\000\064\000\064\000\064\000\064\000\064\000\064\000\255\255\
    \255\255\255\255\255\255\255\255\255\255\078\000\078\000\078\000\
    \078\000\078\000\078\000\078\000\078\000\078\000\078\000\255\255\
    \255\255\255\255\255\255\064\000\255\255\255\255\078\000\078\000\
    \078\000\078\000\078\000\078\000\178\000\178\000\178\000\178\000\
    \178\000\178\000\178\000\178\000\178\000\178\000\064\000\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\064\000\255\255\064\000\078\000\078\000\
    \078\000\078\000\078\000\078\000\033\000\033\000\033\000\033\000\
    \033\000\033\000\033\000\033\000\033\000\033\000\033\000\033\000\
    \033\000\033\000\033\000\033\000\033\000\033\000\033\000\033\000\
    \033\000\033\000\033\000\255\255\033\000\033\000\033\000\033\000\
    \033\000\033\000\033\000\033\000\033\000\033\000\033\000\033\000\
    \033\000\033\000\033\000\033\000\033\000\033\000\033\000\033\000\
    \033\000\033\000\033\000\033\000\033\000\033\000\033\000\033\000\
    \033\000\033\000\033\000\034\000\033\000\033\000\033\000\033\000\
    \033\000\033\000\033\000\033\000\034\000\034\000\034\000\034\000\
    \034\000\034\000\034\000\034\000\034\000\034\000\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\034\000\034\000\034\000\
    \034\000\034\000\034\000\034\000\034\000\034\000\034\000\034\000\
    \034\000\034\000\034\000\034\000\034\000\034\000\034\000\034\000\
    \034\000\034\000\034\000\034\000\034\000\034\000\034\000\255\255\
    \255\255\255\255\255\255\034\000\255\255\034\000\034\000\034\000\
    \034\000\034\000\034\000\034\000\034\000\034\000\034\000\034\000\
    \034\000\034\000\034\000\034\000\034\000\034\000\034\000\034\000\
    \034\000\034\000\034\000\034\000\034\000\034\000\034\000\070\000\
    \255\255\070\000\070\000\070\000\070\000\070\000\070\000\070\000\
    \070\000\070\000\070\000\070\000\070\000\070\000\070\000\070\000\
    \070\000\070\000\070\000\070\000\070\000\070\000\070\000\070\000\
    \070\000\070\000\070\000\255\255\070\000\132\000\255\255\255\255\
    \132\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\132\000\255\255\255\255\
    \255\255\255\255\132\000\132\000\255\255\132\000\255\255\255\255\
    \255\255\255\255\255\255\255\255\034\000\034\000\034\000\034\000\
    \034\000\034\000\034\000\034\000\034\000\034\000\034\000\034\000\
    \034\000\034\000\034\000\034\000\034\000\034\000\034\000\034\000\
    \034\000\034\000\034\000\255\255\034\000\034\000\034\000\034\000\
    \034\000\034\000\034\000\034\000\034\000\034\000\034\000\034\000\
    \034\000\034\000\034\000\034\000\034\000\034\000\034\000\034\000\
    \034\000\034\000\034\000\034\000\034\000\034\000\034\000\034\000\
    \034\000\034\000\034\000\035\000\034\000\034\000\034\000\034\000\
    \034\000\034\000\034\000\034\000\035\000\035\000\035\000\035\000\
    \035\000\035\000\035\000\035\000\035\000\035\000\132\000\255\255\
    \255\255\255\255\255\255\255\255\255\255\035\000\035\000\035\000\
    \035\000\035\000\035\000\035\000\035\000\035\000\035\000\035\000\
    \035\000\035\000\035\000\035\000\035\000\035\000\035\000\035\000\
    \035\000\035\000\035\000\035\000\035\000\035\000\035\000\255\255\
    \255\255\255\255\255\255\035\000\255\255\035\000\035\000\035\000\
    \035\000\035\000\035\000\035\000\035\000\035\000\035\000\035\000\
    \035\000\035\000\035\000\035\000\035\000\035\000\035\000\035\000\
    \035\000\035\000\035\000\035\000\035\000\035\000\035\000\085\000\
    \085\000\085\000\085\000\085\000\085\000\085\000\085\000\085\000\
    \085\000\255\255\255\255\255\255\255\255\255\255\255\255\097\000\
    \085\000\085\000\085\000\085\000\085\000\085\000\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\097\000\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \085\000\085\000\085\000\085\000\085\000\085\000\097\000\097\000\
    \097\000\097\000\097\000\097\000\097\000\097\000\097\000\097\000\
    \255\255\255\255\255\255\132\000\035\000\035\000\035\000\035\000\
    \035\000\035\000\035\000\035\000\035\000\035\000\035\000\035\000\
    \035\000\035\000\035\000\035\000\035\000\035\000\035\000\035\000\
    \035\000\035\000\035\000\255\255\035\000\035\000\035\000\035\000\
    \035\000\035\000\035\000\035\000\035\000\035\000\035\000\035\000\
    \035\000\035\000\035\000\035\000\035\000\035\000\035\000\035\000\
    \035\000\035\000\035\000\035\000\035\000\035\000\035\000\035\000\
    \035\000\035\000\035\000\255\255\035\000\035\000\035\000\035\000\
    \035\000\035\000\035\000\035\000\036\000\255\255\255\255\036\000\
    \036\000\036\000\255\255\255\255\255\255\036\000\036\000\255\255\
    \036\000\036\000\036\000\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\036\000\255\255\036\000\
    \036\000\036\000\036\000\036\000\255\255\185\000\255\255\185\000\
    \185\000\185\000\185\000\185\000\185\000\185\000\185\000\185\000\
    \185\000\185\000\185\000\185\000\185\000\185\000\185\000\185\000\
    \185\000\185\000\185\000\185\000\185\000\185\000\185\000\185\000\
    \185\000\036\000\036\000\185\000\036\000\036\000\036\000\036\000\
    \036\000\036\000\036\000\036\000\036\000\036\000\036\000\036\000\
    \036\000\036\000\036\000\036\000\036\000\036\000\036\000\036\000\
    \036\000\036\000\036\000\036\000\036\000\036\000\255\255\036\000\
    \037\000\036\000\255\255\037\000\037\000\037\000\255\255\255\255\
    \255\255\037\000\037\000\255\255\037\000\037\000\037\000\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\037\000\255\255\037\000\037\000\037\000\037\000\037\000\
    \255\255\191\000\255\255\191\000\191\000\191\000\191\000\191\000\
    \191\000\191\000\191\000\191\000\191\000\191\000\191\000\191\000\
    \191\000\191\000\191\000\191\000\191\000\191\000\191\000\191\000\
    \191\000\191\000\191\000\191\000\191\000\037\000\037\000\191\000\
    \037\000\037\000\037\000\037\000\037\000\037\000\037\000\037\000\
    \037\000\037\000\037\000\037\000\037\000\037\000\037\000\037\000\
    \037\000\037\000\037\000\037\000\037\000\037\000\037\000\037\000\
    \037\000\037\000\255\255\037\000\255\255\037\000\255\255\255\255\
    \255\255\255\255\036\000\036\000\036\000\036\000\036\000\036\000\
    \036\000\036\000\036\000\036\000\036\000\036\000\036\000\036\000\
    \036\000\036\000\036\000\036\000\036\000\036\000\036\000\036\000\
    \036\000\036\000\255\255\036\000\036\000\036\000\036\000\036\000\
    \036\000\036\000\036\000\138\000\255\255\138\000\138\000\138\000\
    \138\000\138\000\138\000\138\000\138\000\138\000\138\000\138\000\
    \138\000\138\000\138\000\138\000\138\000\138\000\138\000\138\000\
    \138\000\138\000\138\000\138\000\138\000\138\000\138\000\145\000\
    \138\000\145\000\145\000\145\000\145\000\145\000\145\000\145\000\
    \145\000\145\000\145\000\145\000\145\000\145\000\145\000\145\000\
    \145\000\145\000\145\000\145\000\145\000\145\000\145\000\145\000\
    \145\000\145\000\145\000\255\255\145\000\255\255\037\000\037\000\
    \037\000\037\000\037\000\037\000\037\000\037\000\037\000\037\000\
    \037\000\037\000\037\000\037\000\037\000\037\000\037\000\037\000\
    \037\000\037\000\037\000\037\000\037\000\037\000\038\000\037\000\
    \037\000\037\000\037\000\037\000\037\000\037\000\037\000\038\000\
    \038\000\038\000\038\000\038\000\038\000\038\000\038\000\038\000\
    \038\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \038\000\038\000\038\000\038\000\038\000\038\000\038\000\038\000\
    \038\000\038\000\038\000\038\000\038\000\038\000\038\000\038\000\
    \038\000\038\000\038\000\038\000\038\000\038\000\038\000\038\000\
    \038\000\038\000\255\255\255\255\255\255\255\255\038\000\255\255\
    \038\000\038\000\038\000\038\000\038\000\038\000\038\000\038\000\
    \038\000\038\000\038\000\038\000\038\000\038\000\038\000\038\000\
    \038\000\038\000\038\000\038\000\038\000\038\000\038\000\038\000\
    \038\000\038\000\255\255\255\255\255\255\255\255\255\255\255\255\
    \096\000\096\000\255\255\255\255\096\000\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\096\000\
    \255\255\096\000\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\096\000\
    \096\000\096\000\096\000\096\000\096\000\096\000\096\000\096\000\
    \096\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\038\000\
    \038\000\038\000\038\000\038\000\038\000\038\000\038\000\038\000\
    \038\000\038\000\038\000\038\000\038\000\038\000\038\000\038\000\
    \038\000\038\000\038\000\038\000\038\000\038\000\255\255\038\000\
    \038\000\038\000\038\000\038\000\038\000\038\000\038\000\038\000\
    \038\000\038\000\038\000\038\000\038\000\038\000\038\000\038\000\
    \038\000\038\000\038\000\038\000\038\000\038\000\038\000\038\000\
    \038\000\038\000\038\000\038\000\038\000\038\000\255\255\038\000\
    \038\000\038\000\038\000\038\000\038\000\038\000\038\000\046\000\
    \255\255\255\255\046\000\046\000\046\000\255\255\255\255\255\255\
    \046\000\046\000\255\255\046\000\046\000\046\000\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \046\000\255\255\046\000\046\000\046\000\046\000\046\000\255\255\
    \255\255\255\255\255\255\047\000\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\047\000\047\000\047\000\047\000\
    \047\000\047\000\047\000\047\000\047\000\047\000\047\000\255\255\
    \255\255\255\255\255\255\255\255\046\000\047\000\047\000\047\000\
    \047\000\047\000\047\000\047\000\047\000\047\000\047\000\047\000\
    \047\000\047\000\047\000\047\000\047\000\047\000\047\000\047\000\
    \047\000\047\000\047\000\047\000\047\000\047\000\047\000\255\255\
    \255\255\255\255\046\000\047\000\046\000\047\000\047\000\047\000\
    \047\000\047\000\047\000\047\000\047\000\047\000\047\000\047\000\
    \047\000\047\000\047\000\047\000\047\000\047\000\047\000\047\000\
    \047\000\047\000\047\000\047\000\047\000\047\000\047\000\096\000\
    \153\000\153\000\153\000\153\000\153\000\153\000\153\000\153\000\
    \153\000\153\000\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\153\000\153\000\153\000\153\000\153\000\153\000\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\153\000\153\000\153\000\153\000\153\000\153\000\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\047\000\047\000\047\000\047\000\
    \047\000\047\000\047\000\047\000\047\000\047\000\047\000\047\000\
    \047\000\047\000\047\000\047\000\047\000\047\000\047\000\047\000\
    \047\000\047\000\047\000\255\255\047\000\047\000\047\000\047\000\
    \047\000\047\000\047\000\047\000\047\000\047\000\047\000\047\000\
    \047\000\047\000\047\000\047\000\047\000\047\000\047\000\047\000\
    \047\000\047\000\047\000\047\000\047\000\047\000\047\000\047\000\
    \047\000\047\000\047\000\048\000\047\000\047\000\047\000\047\000\
    \047\000\047\000\047\000\047\000\048\000\048\000\048\000\048\000\
    \048\000\048\000\048\000\048\000\048\000\048\000\048\000\255\255\
    \255\255\255\255\255\255\255\255\255\255\048\000\048\000\048\000\
    \048\000\048\000\048\000\048\000\048\000\048\000\048\000\048\000\
    \048\000\048\000\048\000\048\000\048\000\048\000\048\000\048\000\
    \048\000\048\000\048\000\048\000\048\000\048\000\048\000\255\255\
    \255\255\255\255\255\255\048\000\255\255\048\000\048\000\048\000\
    \048\000\048\000\048\000\048\000\048\000\048\000\048\000\048\000\
    \048\000\048\000\048\000\048\000\048\000\048\000\048\000\048\000\
    \048\000\048\000\048\000\048\000\048\000\048\000\048\000\160\000\
    \160\000\160\000\160\000\160\000\160\000\160\000\160\000\160\000\
    \160\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \160\000\160\000\160\000\160\000\160\000\160\000\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \160\000\160\000\160\000\160\000\160\000\160\000\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\048\000\048\000\048\000\048\000\
    \048\000\048\000\048\000\048\000\048\000\048\000\048\000\048\000\
    \048\000\048\000\048\000\048\000\048\000\048\000\048\000\048\000\
    \048\000\048\000\048\000\255\255\048\000\048\000\048\000\048\000\
    \048\000\048\000\048\000\048\000\048\000\048\000\048\000\048\000\
    \048\000\048\000\048\000\048\000\048\000\048\000\048\000\048\000\
    \048\000\048\000\048\000\048\000\048\000\048\000\048\000\048\000\
    \048\000\048\000\048\000\051\000\048\000\048\000\048\000\048\000\
    \048\000\048\000\048\000\048\000\051\000\051\000\051\000\051\000\
    \051\000\051\000\051\000\051\000\051\000\051\000\051\000\255\255\
    \255\255\255\255\255\255\255\255\255\255\051\000\051\000\051\000\
    \051\000\051\000\051\000\051\000\051\000\051\000\051\000\051\000\
    \051\000\051\000\051\000\051\000\051\000\051\000\051\000\051\000\
    \051\000\051\000\051\000\051\000\051\000\051\000\051\000\255\255\
    \255\255\255\255\255\255\051\000\255\255\051\000\051\000\051\000\
    \051\000\051\000\051\000\051\000\051\000\051\000\051\000\051\000\
    \051\000\051\000\051\000\051\000\051\000\051\000\051\000\051\000\
    \051\000\051\000\051\000\051\000\051\000\051\000\051\000\172\000\
    \172\000\172\000\172\000\172\000\172\000\172\000\172\000\172\000\
    \172\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \172\000\172\000\172\000\172\000\172\000\172\000\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \172\000\172\000\172\000\172\000\172\000\172\000\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\051\000\051\000\051\000\051\000\
    \051\000\051\000\051\000\051\000\051\000\051\000\051\000\051\000\
    \051\000\051\000\051\000\051\000\051\000\051\000\051\000\051\000\
    \051\000\051\000\051\000\255\255\051\000\051\000\051\000\051\000\
    \051\000\051\000\051\000\051\000\051\000\051\000\051\000\051\000\
    \051\000\051\000\051\000\051\000\051\000\051\000\051\000\051\000\
    \051\000\051\000\051\000\051\000\051\000\051\000\051\000\051\000\
    \051\000\051\000\051\000\052\000\051\000\051\000\051\000\051\000\
    \051\000\051\000\051\000\051\000\052\000\052\000\052\000\052\000\
    \052\000\052\000\052\000\052\000\052\000\052\000\052\000\255\255\
    \255\255\255\255\255\255\255\255\255\255\052\000\052\000\052\000\
    \052\000\052\000\052\000\052\000\052\000\052\000\052\000\052\000\
    \052\000\052\000\052\000\052\000\052\000\052\000\052\000\052\000\
    \052\000\052\000\052\000\052\000\052\000\052\000\052\000\255\255\
    \255\255\255\255\255\255\052\000\255\255\052\000\052\000\052\000\
    \052\000\052\000\052\000\052\000\052\000\052\000\052\000\052\000\
    \052\000\052\000\052\000\052\000\052\000\052\000\052\000\052\000\
    \052\000\052\000\052\000\052\000\052\000\052\000\052\000\180\000\
    \180\000\180\000\180\000\180\000\180\000\180\000\180\000\180\000\
    \180\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \180\000\180\000\180\000\180\000\180\000\180\000\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \180\000\180\000\180\000\180\000\180\000\180\000\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\052\000\052\000\052\000\052\000\
    \052\000\052\000\052\000\052\000\052\000\052\000\052\000\052\000\
    \052\000\052\000\052\000\052\000\052\000\052\000\052\000\052\000\
    \052\000\052\000\052\000\255\255\052\000\052\000\052\000\052\000\
    \052\000\052\000\052\000\052\000\052\000\052\000\052\000\052\000\
    \052\000\052\000\052\000\052\000\052\000\052\000\052\000\052\000\
    \052\000\052\000\052\000\052\000\052\000\052\000\052\000\052\000\
    \052\000\052\000\052\000\255\255\052\000\052\000\052\000\052\000\
    \052\000\052\000\052\000\052\000\071\000\093\000\071\000\255\255\
    \093\000\093\000\093\000\071\000\255\255\255\255\093\000\093\000\
    \255\255\093\000\093\000\093\000\071\000\071\000\071\000\071\000\
    \071\000\071\000\071\000\071\000\071\000\071\000\093\000\255\255\
    \093\000\093\000\093\000\093\000\093\000\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\095\000\255\255\095\000\095\000\
    \095\000\095\000\255\255\255\255\255\255\095\000\095\000\255\255\
    \095\000\095\000\095\000\255\255\255\255\255\255\255\255\255\255\
    \071\000\255\255\093\000\255\255\255\255\095\000\071\000\095\000\
    \095\000\095\000\095\000\095\000\255\255\255\255\255\255\255\255\
    \255\255\255\255\071\000\255\255\255\255\255\255\071\000\255\255\
    \071\000\255\255\106\000\255\255\071\000\106\000\106\000\106\000\
    \093\000\255\255\093\000\106\000\106\000\255\255\106\000\106\000\
    \106\000\095\000\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\106\000\255\255\106\000\106\000\106\000\
    \106\000\106\000\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\107\000\255\255\255\255\107\000\107\000\107\000\095\000\
    \255\255\095\000\107\000\107\000\255\255\107\000\107\000\107\000\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\106\000\
    \255\255\255\255\107\000\255\255\107\000\107\000\107\000\107\000\
    \107\000\255\255\255\255\255\255\108\000\255\255\255\255\108\000\
    \108\000\108\000\255\255\255\255\255\255\108\000\108\000\255\255\
    \108\000\108\000\108\000\255\255\255\255\106\000\255\255\106\000\
    \255\255\255\255\255\255\255\255\255\255\108\000\107\000\108\000\
    \108\000\108\000\108\000\108\000\255\255\255\255\255\255\255\255\
    \255\255\255\255\109\000\255\255\255\255\109\000\109\000\109\000\
    \255\255\255\255\255\255\109\000\109\000\255\255\109\000\109\000\
    \109\000\255\255\255\255\255\255\107\000\255\255\107\000\255\255\
    \255\255\108\000\255\255\109\000\071\000\109\000\109\000\109\000\
    \109\000\109\000\255\255\255\255\255\255\115\000\255\255\255\255\
    \115\000\115\000\115\000\255\255\255\255\255\255\115\000\115\000\
    \255\255\115\000\115\000\115\000\255\255\255\255\255\255\108\000\
    \255\255\108\000\255\255\255\255\255\255\255\255\115\000\109\000\
    \115\000\115\000\115\000\115\000\115\000\255\255\255\255\255\255\
    \125\000\255\255\255\255\125\000\125\000\125\000\255\255\255\255\
    \255\255\125\000\125\000\255\255\125\000\125\000\125\000\255\255\
    \255\255\255\255\255\255\255\255\255\255\109\000\255\255\109\000\
    \255\255\125\000\115\000\125\000\125\000\125\000\125\000\125\000\
    \255\255\255\255\255\255\128\000\255\255\255\255\128\000\128\000\
    \128\000\255\255\255\255\255\255\128\000\128\000\255\255\128\000\
    \128\000\128\000\255\255\255\255\255\255\255\255\255\255\255\255\
    \115\000\255\255\115\000\255\255\128\000\125\000\128\000\128\000\
    \128\000\128\000\128\000\255\255\255\255\255\255\129\000\255\255\
    \255\255\129\000\129\000\129\000\255\255\255\255\255\255\129\000\
    \129\000\255\255\129\000\129\000\129\000\255\255\255\255\255\255\
    \255\255\255\255\255\255\125\000\255\255\125\000\255\255\129\000\
    \128\000\129\000\129\000\129\000\129\000\129\000\255\255\255\255\
    \255\255\130\000\255\255\255\255\130\000\130\000\130\000\255\255\
    \255\255\255\255\130\000\130\000\255\255\130\000\130\000\130\000\
    \255\255\255\255\255\255\255\255\255\255\255\255\128\000\255\255\
    \128\000\255\255\130\000\129\000\130\000\130\000\130\000\130\000\
    \130\000\255\255\255\255\255\255\131\000\255\255\255\255\131\000\
    \131\000\131\000\255\255\255\255\255\255\131\000\131\000\255\255\
    \131\000\131\000\131\000\255\255\255\255\146\000\255\255\146\000\
    \255\255\129\000\255\255\129\000\146\000\131\000\130\000\131\000\
    \131\000\131\000\131\000\131\000\255\255\146\000\146\000\146\000\
    \146\000\146\000\146\000\146\000\146\000\146\000\146\000\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\130\000\255\255\130\000\255\255\
    \255\255\131\000\255\255\255\255\255\255\255\255\255\255\255\255\
    \169\000\255\255\255\255\169\000\255\255\255\255\255\255\255\255\
    \255\255\146\000\255\255\255\255\255\255\255\255\255\255\146\000\
    \255\255\255\255\255\255\255\255\255\255\255\255\169\000\131\000\
    \169\000\131\000\255\255\146\000\255\255\169\000\255\255\146\000\
    \255\255\146\000\255\255\255\255\255\255\146\000\169\000\169\000\
    \169\000\169\000\169\000\169\000\169\000\169\000\169\000\169\000\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\169\000\255\255\255\255\255\255\255\255\255\255\
    \169\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\169\000\255\255\255\255\255\255\
    \169\000\255\255\169\000\255\255\255\255\255\255\169\000\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\169\000";
  Lexing.lex_base_code = 
   "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \010\000\036\000\012\000\000\000\000\000\000\000\002\000\000\000\
    \027\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\001\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \002\000\004\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000";
  Lexing.lex_backtrk_code = 
   "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\039\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000";
  Lexing.lex_default_code = 
   "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\019\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000";
  Lexing.lex_trans_code = 
   "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\001\000\000\000\036\000\036\000\000\000\036\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \001\000\000\000\000\000\001\000\022\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\007\000\001\000\000\000\000\000\
    \004\000\004\000\004\000\004\000\004\000\004\000\004\000\004\000\
    \004\000\004\000\004\000\004\000\004\000\004\000\004\000\004\000\
    \004\000\004\000\004\000\004\000\001\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\004\000\004\000\004\000\004\000\
    \004\000\004\000\004\000\004\000\004\000\004\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000";
  Lexing.lex_check_code = 
   "\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\024\000\101\000\169\000\176\000\101\000\177\000\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \024\000\255\255\101\000\000\000\102\000\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\096\000\097\000\255\255\255\255\
    \024\000\024\000\024\000\024\000\024\000\024\000\024\000\024\000\
    \024\000\024\000\096\000\096\000\096\000\096\000\096\000\096\000\
    \096\000\096\000\096\000\096\000\097\000\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\097\000\097\000\097\000\097\000\
    \097\000\097\000\097\000\097\000\097\000\097\000\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \101\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255";
  Lexing.lex_code = 
   "\255\004\255\255\005\255\255\007\255\006\255\255\003\255\000\004\
    \001\005\255\007\255\255\006\255\007\255\255\000\004\001\005\003\
    \006\002\007\255\001\255\255\000\001\255";
}

let rec token lexbuf =
  lexbuf.Lexing.lex_mem <- Array.make 8 (-1) ;   __ocaml_lex_token_rec lexbuf 0
and __ocaml_lex_token_rec lexbuf __ocaml_lex_state =
  match Lexing.new_engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 697 "parsing/lexer.mll"
                 (
      if not !escaped_newlines then
        raise (Error(Illegal_character (Lexing.lexeme_char lexbuf 0),
                     Location.curr lexbuf));
      update_loc lexbuf None 1 false 0;
      token lexbuf )
# 1907 "parsing/lexer.ml"

  | 1 ->
# 704 "parsing/lexer.mll"
      ( update_loc lexbuf None 1 false 0;
        EOL )
# 1913 "parsing/lexer.ml"

  | 2 ->
# 707 "parsing/lexer.mll"
      ( token lexbuf )
# 1918 "parsing/lexer.ml"

  | 3 ->
# 709 "parsing/lexer.mll"
      ( UNDERSCORE )
# 1923 "parsing/lexer.ml"

  | 4 ->
# 711 "parsing/lexer.mll"
      ( TILDE )
# 1928 "parsing/lexer.ml"

  | 5 ->
# 713 "parsing/lexer.mll"
      ( LABEL (get_label_name lexbuf) )
# 1933 "parsing/lexer.ml"

  | 6 ->
# 715 "parsing/lexer.mll"
      ( warn_latin1 lexbuf; LABEL (get_label_name lexbuf) )
# 1938 "parsing/lexer.ml"

  | 7 ->
# 717 "parsing/lexer.mll"
      ( QUESTION )
# 1943 "parsing/lexer.ml"

  | 8 ->
# 719 "parsing/lexer.mll"
      ( OPTLABEL (get_label_name lexbuf) )
# 1948 "parsing/lexer.ml"

  | 9 ->
# 721 "parsing/lexer.mll"
      ( warn_latin1 lexbuf; OPTLABEL (get_label_name lexbuf) )
# 1953 "parsing/lexer.ml"

  | 10 ->
# 723 "parsing/lexer.mll"
      ( let s = Lexing.lexeme lexbuf in
        try Hashtbl.find keyword_table s
        with Not_found -> LIDENT s )
# 1960 "parsing/lexer.ml"

  | 11 ->
# 727 "parsing/lexer.mll"
      ( warn_latin1 lexbuf; LIDENT (Lexing.lexeme lexbuf) )
# 1965 "parsing/lexer.ml"

  | 12 ->
# 729 "parsing/lexer.mll"
      ( UIDENT(Lexing.lexeme lexbuf) )
# 1970 "parsing/lexer.ml"

  | 13 ->
# 731 "parsing/lexer.mll"
      ( warn_latin1 lexbuf; UIDENT(Lexing.lexeme lexbuf) )
# 1975 "parsing/lexer.ml"

  | 14 ->
# 733 "parsing/lexer.mll"
      ( try
          INT (cvt_int_literal (Lexing.lexeme lexbuf))
        with Failure _ ->
          raise (Error(Literal_overflow "int", Location.curr lexbuf))
      )
# 1984 "parsing/lexer.ml"

  | 15 ->
# 739 "parsing/lexer.mll"
      ( FLOAT (remove_underscores(Lexing.lexeme lexbuf)) )
# 1989 "parsing/lexer.ml"

  | 16 ->
# 741 "parsing/lexer.mll"
      ( try
          INT32 (cvt_int32_literal (Lexing.lexeme lexbuf))
        with Failure _ ->
          raise (Error(Literal_overflow "int32", Location.curr lexbuf)) )
# 1997 "parsing/lexer.ml"

  | 17 ->
# 746 "parsing/lexer.mll"
      ( try
          INT64 (cvt_int64_literal (Lexing.lexeme lexbuf))
        with Failure _ ->
          raise (Error(Literal_overflow "int64", Location.curr lexbuf)) )
# 2005 "parsing/lexer.ml"

  | 18 ->
# 751 "parsing/lexer.mll"
      ( try
          NATIVEINT (cvt_nativeint_literal (Lexing.lexeme lexbuf))
        with Failure _ ->
          raise (Error(Literal_overflow "nativeint", Location.curr lexbuf)) )
# 2013 "parsing/lexer.ml"

  | 19 ->
# 756 "parsing/lexer.mll"
      ( reset_string_buffer();
        is_in_string := true;
        let string_start = lexbuf.lex_start_p in
        string_start_loc := Location.curr lexbuf;
        string lexbuf;
        is_in_string := false;
        lexbuf.lex_start_p <- string_start;
        STRING (get_stored_string(), None) )
# 2025 "parsing/lexer.ml"

  | 20 ->
# 765 "parsing/lexer.mll"
      ( reset_string_buffer();
        let delim = Lexing.lexeme lexbuf in
        let delim = String.sub delim 1 (String.length delim - 2) in
        is_in_string := true;
        let string_start = lexbuf.lex_start_p in
        string_start_loc := Location.curr lexbuf;
        quoted_string delim lexbuf;
        is_in_string := false;
        lexbuf.lex_start_p <- string_start;
        STRING (get_stored_string(), Some delim) )
# 2039 "parsing/lexer.ml"

  | 21 ->
# 776 "parsing/lexer.mll"
      ( update_loc lexbuf None 1 false 1;
        CHAR (Lexing.lexeme_char lexbuf 1) )
# 2045 "parsing/lexer.ml"

  | 22 ->
# 779 "parsing/lexer.mll"
      ( CHAR(Lexing.lexeme_char lexbuf 1) )
# 2050 "parsing/lexer.ml"

  | 23 ->
# 781 "parsing/lexer.mll"
      ( CHAR(char_for_backslash (Lexing.lexeme_char lexbuf 2)) )
# 2055 "parsing/lexer.ml"

  | 24 ->
# 783 "parsing/lexer.mll"
      ( CHAR(char_for_decimal_code lexbuf 2) )
# 2060 "parsing/lexer.ml"

  | 25 ->
# 785 "parsing/lexer.mll"
      ( CHAR(char_for_hexadecimal_code lexbuf 3) )
# 2065 "parsing/lexer.ml"

  | 26 ->
# 787 "parsing/lexer.mll"
      ( let l = Lexing.lexeme lexbuf in
        let esc = String.sub l 1 (String.length l - 1) in
        raise (Error(Illegal_escape esc, Location.curr lexbuf))
      )
# 2073 "parsing/lexer.ml"

  | 27 ->
# 792 "parsing/lexer.mll"
      ( let s, loc = with_comment_buffer comment lexbuf in
        COMMENT (s, loc) )
# 2079 "parsing/lexer.ml"

  | 28 ->
# 795 "parsing/lexer.mll"
      ( let s, loc = with_comment_buffer comment lexbuf in

        COMMENT (s,loc)    

)
# 2090 "parsing/lexer.ml"

  | 29 ->
let
# 802 "parsing/lexer.mll"
                    stars
# 2096 "parsing/lexer.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_start_pos lexbuf.Lexing.lex_curr_pos in
# 803 "parsing/lexer.mll"
      ( let s, loc =
          with_comment_buffer
            (fun lexbuf ->
               store_string ("*" ^ stars);
               comment lexbuf)
            lexbuf
        in
        COMMENT (s, loc) )
# 2107 "parsing/lexer.ml"

  | 30 ->
# 812 "parsing/lexer.mll"
      ( if !print_warnings then
          Location.prerr_warning (Location.curr lexbuf) Warnings.Comment_start;
        let s, loc = with_comment_buffer comment lexbuf in
        COMMENT (s, loc) )
# 2115 "parsing/lexer.ml"

  | 31 ->
let
# 816 "parsing/lexer.mll"
                   stars
# 2121 "parsing/lexer.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_start_pos (lexbuf.Lexing.lex_curr_pos + -2) in
# 817 "parsing/lexer.mll"
      ( COMMENT (stars, Location.curr lexbuf) )
# 2125 "parsing/lexer.ml"

  | 32 ->
# 819 "parsing/lexer.mll"
      ( let loc = Location.curr lexbuf in
        Location.prerr_warning loc Warnings.Comment_not_end;
        lexbuf.Lexing.lex_curr_pos <- lexbuf.Lexing.lex_curr_pos - 1;
        let curpos = lexbuf.lex_curr_p in
        lexbuf.lex_curr_p <- { curpos with pos_cnum = curpos.pos_cnum - 1 };
        STAR
      )
# 2136 "parsing/lexer.ml"

  | 33 ->
let
# 826 "parsing/lexer.mll"
                                   num
# 2142 "parsing/lexer.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_mem.(0) lexbuf.Lexing.lex_mem.(1)
and
# 827 "parsing/lexer.mll"
                                           name
# 2147 "parsing/lexer.ml"
= Lexing.sub_lexeme_opt lexbuf lexbuf.Lexing.lex_mem.(3) lexbuf.Lexing.lex_mem.(2) in
# 829 "parsing/lexer.mll"
      ( update_loc lexbuf name (int_of_string num) true 0;
        token lexbuf
      )
# 2153 "parsing/lexer.ml"

  | 34 ->
# 832 "parsing/lexer.mll"
         ( SHARP )
# 2158 "parsing/lexer.ml"

  | 35 ->
# 833 "parsing/lexer.mll"
         ( AMPERSAND )
# 2163 "parsing/lexer.ml"

  | 36 ->
# 834 "parsing/lexer.mll"
         ( AMPERAMPER )
# 2168 "parsing/lexer.ml"

  | 37 ->
# 835 "parsing/lexer.mll"
         ( BACKQUOTE )
# 2173 "parsing/lexer.ml"

  | 38 ->
# 836 "parsing/lexer.mll"
         ( QUOTE )
# 2178 "parsing/lexer.ml"

  | 39 ->
# 837 "parsing/lexer.mll"
         ( LPAREN )
# 2183 "parsing/lexer.ml"

  | 40 ->
# 838 "parsing/lexer.mll"
         ( RPAREN )
# 2188 "parsing/lexer.ml"

  | 41 ->
# 839 "parsing/lexer.mll"
         ( STAR )
# 2193 "parsing/lexer.ml"

  | 42 ->
# 840 "parsing/lexer.mll"
         ( COMMA )
# 2198 "parsing/lexer.ml"

  | 43 ->
# 841 "parsing/lexer.mll"
         ( MINUSGREATER )
# 2203 "parsing/lexer.ml"

  | 44 ->
# 842 "parsing/lexer.mll"
         ( DOT )
# 2208 "parsing/lexer.ml"

  | 45 ->
# 843 "parsing/lexer.mll"
         ( DOTDOT )
# 2213 "parsing/lexer.ml"

  | 46 ->
# 844 "parsing/lexer.mll"
         ( COLON )
# 2218 "parsing/lexer.ml"

  | 47 ->
# 845 "parsing/lexer.mll"
         ( COLONCOLON )
# 2223 "parsing/lexer.ml"

  | 48 ->
# 846 "parsing/lexer.mll"
         ( COLONEQUAL )
# 2228 "parsing/lexer.ml"

  | 49 ->
# 847 "parsing/lexer.mll"
         ( COLONGREATER )
# 2233 "parsing/lexer.ml"

  | 50 ->
# 848 "parsing/lexer.mll"
         ( SEMI )
# 2238 "parsing/lexer.ml"

  | 51 ->
# 849 "parsing/lexer.mll"
         ( SEMISEMI )
# 2243 "parsing/lexer.ml"

  | 52 ->
# 850 "parsing/lexer.mll"
         ( LESS )
# 2248 "parsing/lexer.ml"

  | 53 ->
# 851 "parsing/lexer.mll"
         ( LESSMINUS )
# 2253 "parsing/lexer.ml"

  | 54 ->
# 852 "parsing/lexer.mll"
         ( EQUAL )
# 2258 "parsing/lexer.ml"

  | 55 ->
# 853 "parsing/lexer.mll"
         ( LBRACKET )
# 2263 "parsing/lexer.ml"

  | 56 ->
# 854 "parsing/lexer.mll"
         ( LBRACKETBAR )
# 2268 "parsing/lexer.ml"

  | 57 ->
# 855 "parsing/lexer.mll"
         ( LBRACKETLESS )
# 2273 "parsing/lexer.ml"

  | 58 ->
# 856 "parsing/lexer.mll"
         ( LBRACKETGREATER )
# 2278 "parsing/lexer.ml"

  | 59 ->
# 857 "parsing/lexer.mll"
         ( RBRACKET )
# 2283 "parsing/lexer.ml"

  | 60 ->
# 858 "parsing/lexer.mll"
         ( LBRACE )
# 2288 "parsing/lexer.ml"

  | 61 ->
# 859 "parsing/lexer.mll"
         ( LBRACELESS )
# 2293 "parsing/lexer.ml"

  | 62 ->
# 860 "parsing/lexer.mll"
         ( BAR )
# 2298 "parsing/lexer.ml"

  | 63 ->
# 861 "parsing/lexer.mll"
         ( BARBAR )
# 2303 "parsing/lexer.ml"

  | 64 ->
# 862 "parsing/lexer.mll"
         ( BARRBRACKET )
# 2308 "parsing/lexer.ml"

  | 65 ->
# 863 "parsing/lexer.mll"
         ( GREATER )
# 2313 "parsing/lexer.ml"

  | 66 ->
# 864 "parsing/lexer.mll"
         ( GREATERRBRACKET )
# 2318 "parsing/lexer.ml"

  | 67 ->
# 865 "parsing/lexer.mll"
         ( RBRACE )
# 2323 "parsing/lexer.ml"

  | 68 ->
# 866 "parsing/lexer.mll"
         ( GREATERRBRACE )
# 2328 "parsing/lexer.ml"

  | 69 ->
# 867 "parsing/lexer.mll"
         ( LBRACKETAT )
# 2333 "parsing/lexer.ml"

  | 70 ->
# 868 "parsing/lexer.mll"
         ( LBRACKETPERCENT )
# 2338 "parsing/lexer.ml"

  | 71 ->
# 869 "parsing/lexer.mll"
          ( LBRACKETPERCENTPERCENT )
# 2343 "parsing/lexer.ml"

  | 72 ->
# 870 "parsing/lexer.mll"
          ( LBRACKETATAT )
# 2348 "parsing/lexer.ml"

  | 73 ->
# 871 "parsing/lexer.mll"
           ( LBRACKETATATAT )
# 2353 "parsing/lexer.ml"

  | 74 ->
# 872 "parsing/lexer.mll"
         ( BANG )
# 2358 "parsing/lexer.ml"

  | 75 ->
# 873 "parsing/lexer.mll"
         ( INFIXOP0 "!=" )
# 2363 "parsing/lexer.ml"

  | 76 ->
# 874 "parsing/lexer.mll"
         ( PLUS )
# 2368 "parsing/lexer.ml"

  | 77 ->
# 875 "parsing/lexer.mll"
         ( PLUSDOT )
# 2373 "parsing/lexer.ml"

  | 78 ->
# 876 "parsing/lexer.mll"
         ( PLUSEQ )
# 2378 "parsing/lexer.ml"

  | 79 ->
# 877 "parsing/lexer.mll"
         ( MINUS )
# 2383 "parsing/lexer.ml"

  | 80 ->
# 878 "parsing/lexer.mll"
         ( MINUSDOT )
# 2388 "parsing/lexer.ml"

  | 81 ->
# 881 "parsing/lexer.mll"
            ( PREFIXOP(Lexing.lexeme lexbuf) )
# 2393 "parsing/lexer.ml"

  | 82 ->
# 883 "parsing/lexer.mll"
            ( PREFIXOP(Lexing.lexeme lexbuf) )
# 2398 "parsing/lexer.ml"

  | 83 ->
# 885 "parsing/lexer.mll"
            ( INFIXOP0(Lexing.lexeme lexbuf) )
# 2403 "parsing/lexer.ml"

  | 84 ->
# 887 "parsing/lexer.mll"
            ( INFIXOP1(Lexing.lexeme lexbuf) )
# 2408 "parsing/lexer.ml"

  | 85 ->
# 889 "parsing/lexer.mll"
            ( INFIXOP2(Lexing.lexeme lexbuf) )
# 2413 "parsing/lexer.ml"

  | 86 ->
# 891 "parsing/lexer.mll"
            ( INFIXOP4(Lexing.lexeme lexbuf) )
# 2418 "parsing/lexer.ml"

  | 87 ->
# 892 "parsing/lexer.mll"
            ( PERCENT )
# 2423 "parsing/lexer.ml"

  | 88 ->
# 894 "parsing/lexer.mll"
            ( INFIXOP3(Lexing.lexeme lexbuf) )
# 2428 "parsing/lexer.ml"

  | 89 ->
# 896 "parsing/lexer.mll"
            ( SHARPOP(Lexing.lexeme lexbuf) )
# 2433 "parsing/lexer.ml"

  | 90 ->
# 897 "parsing/lexer.mll"
        (
      if !if_then_else <> Dir_out then
        if !if_then_else = Dir_if_true then
          raise (Error (Unterminated_if, Location.curr lexbuf))
        else raise (Error(Unterminated_else, Location.curr lexbuf))
      else 
        EOF
        
    )
# 2446 "parsing/lexer.ml"

  | 91 ->
# 907 "parsing/lexer.mll"
      ( raise (Error(Illegal_character (Lexing.lexeme_char lexbuf 0),
                     Location.curr lexbuf))
      )
# 2453 "parsing/lexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf; 
      __ocaml_lex_token_rec lexbuf __ocaml_lex_state

and comment lexbuf =
    __ocaml_lex_comment_rec lexbuf 132
and __ocaml_lex_comment_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 913 "parsing/lexer.mll"
      ( comment_start_loc := (Location.curr lexbuf) :: !comment_start_loc;
        store_lexeme lexbuf;
        comment lexbuf;
      )
# 2468 "parsing/lexer.ml"

  | 1 ->
# 918 "parsing/lexer.mll"
      ( match !comment_start_loc with
        | [] -> assert false
        | [_] -> comment_start_loc := []; Location.curr lexbuf
        | _ :: l -> comment_start_loc := l;
                  store_lexeme lexbuf;
                  comment lexbuf;
       )
# 2479 "parsing/lexer.ml"

  | 2 ->
# 926 "parsing/lexer.mll"
      (
        string_start_loc := Location.curr lexbuf;
        store_string_char '"';
        is_in_string := true;
        begin try string lexbuf
        with Error (Unterminated_string, str_start) ->
          match !comment_start_loc with
          | [] -> assert false
          | loc :: _ ->
            let start = List.hd (List.rev !comment_start_loc) in
            comment_start_loc := [];
            raise (Error (Unterminated_string_in_comment (start, str_start),
                          loc))
        end;
        is_in_string := false;
        store_string_char '"';
        comment lexbuf )
# 2500 "parsing/lexer.ml"

  | 3 ->
# 944 "parsing/lexer.mll"
      (
        let delim = Lexing.lexeme lexbuf in
        let delim = String.sub delim 1 (String.length delim - 2) in
        string_start_loc := Location.curr lexbuf;
        store_lexeme lexbuf;
        is_in_string := true;
        begin try quoted_string delim lexbuf
        with Error (Unterminated_string, str_start) ->
          match !comment_start_loc with
          | [] -> assert false
          | loc :: _ ->
            let start = List.hd (List.rev !comment_start_loc) in
            comment_start_loc := [];
            raise (Error (Unterminated_string_in_comment (start, str_start),
                          loc))
        end;
        is_in_string := false;
        store_string_char '|';
        store_string delim;
        store_string_char '}';
        comment lexbuf )
# 2525 "parsing/lexer.ml"

  | 4 ->
# 967 "parsing/lexer.mll"
      ( store_lexeme lexbuf; comment lexbuf )
# 2530 "parsing/lexer.ml"

  | 5 ->
# 969 "parsing/lexer.mll"
      ( update_loc lexbuf None 1 false 1;
        store_lexeme lexbuf;
        comment lexbuf
      )
# 2538 "parsing/lexer.ml"

  | 6 ->
# 974 "parsing/lexer.mll"
      ( store_lexeme lexbuf; comment lexbuf )
# 2543 "parsing/lexer.ml"

  | 7 ->
# 976 "parsing/lexer.mll"
      ( store_lexeme lexbuf; comment lexbuf )
# 2548 "parsing/lexer.ml"

  | 8 ->
# 978 "parsing/lexer.mll"
      ( store_lexeme lexbuf; comment lexbuf )
# 2553 "parsing/lexer.ml"

  | 9 ->
# 980 "parsing/lexer.mll"
      ( store_lexeme lexbuf; comment lexbuf )
# 2558 "parsing/lexer.ml"

  | 10 ->
# 982 "parsing/lexer.mll"
      ( match !comment_start_loc with
        | [] -> assert false
        | loc :: _ ->
          let start = List.hd (List.rev !comment_start_loc) in
          comment_start_loc := [];
          raise (Error (Unterminated_comment start, loc))
      )
# 2569 "parsing/lexer.ml"

  | 11 ->
# 990 "parsing/lexer.mll"
      ( update_loc lexbuf None 1 false 0;
        store_lexeme lexbuf;
        comment lexbuf
      )
# 2577 "parsing/lexer.ml"

  | 12 ->
# 995 "parsing/lexer.mll"
      ( store_lexeme lexbuf; comment lexbuf )
# 2582 "parsing/lexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf; 
      __ocaml_lex_comment_rec lexbuf __ocaml_lex_state

and string lexbuf =
  lexbuf.Lexing.lex_mem <- Array.make 2 (-1) ;   __ocaml_lex_string_rec lexbuf 164
and __ocaml_lex_string_rec lexbuf __ocaml_lex_state =
  match Lexing.new_engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 999 "parsing/lexer.mll"
      ( () )
# 2594 "parsing/lexer.ml"

  | 1 ->
let
# 1000 "parsing/lexer.mll"
                                  space
# 2600 "parsing/lexer.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_mem.(0) lexbuf.Lexing.lex_curr_pos in
# 1001 "parsing/lexer.mll"
      ( update_loc lexbuf None 1 false (String.length space);
        string lexbuf
      )
# 2606 "parsing/lexer.ml"

  | 2 ->
# 1005 "parsing/lexer.mll"
      ( store_string_char(char_for_backslash(Lexing.lexeme_char lexbuf 1));
        string lexbuf )
# 2612 "parsing/lexer.ml"

  | 3 ->
# 1008 "parsing/lexer.mll"
      ( store_string_char(char_for_decimal_code lexbuf 1);
         string lexbuf )
# 2618 "parsing/lexer.ml"

  | 4 ->
# 1011 "parsing/lexer.mll"
      ( store_string_char(char_for_hexadecimal_code lexbuf 2);
         string lexbuf )
# 2624 "parsing/lexer.ml"

  | 5 ->
# 1014 "parsing/lexer.mll"
      ( if in_comment ()
        then string lexbuf
        else begin
(*  Should be an error, but we are very lax.
          raise (Error (Illegal_escape (Lexing.lexeme lexbuf),
                        Location.curr lexbuf))
*)
          let loc = Location.curr lexbuf in
          Location.prerr_warning loc Warnings.Illegal_backslash;
          store_string_char (Lexing.lexeme_char lexbuf 0);
          store_string_char (Lexing.lexeme_char lexbuf 1);
          string lexbuf
        end
      )
# 2642 "parsing/lexer.ml"

  | 6 ->
# 1029 "parsing/lexer.mll"
      ( if not (in_comment ()) then
          Location.prerr_warning (Location.curr lexbuf) Warnings.Eol_in_string;
        update_loc lexbuf None 1 false 0;
        store_lexeme lexbuf;
        string lexbuf
      )
# 2652 "parsing/lexer.ml"

  | 7 ->
# 1036 "parsing/lexer.mll"
      ( is_in_string := false;
        raise (Error (Unterminated_string, !string_start_loc)) )
# 2658 "parsing/lexer.ml"

  | 8 ->
# 1039 "parsing/lexer.mll"
      ( store_string_char(Lexing.lexeme_char lexbuf 0);
        string lexbuf )
# 2664 "parsing/lexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf; 
      __ocaml_lex_string_rec lexbuf __ocaml_lex_state

and quoted_string delim lexbuf =
    __ocaml_lex_quoted_string_rec delim lexbuf 183
and __ocaml_lex_quoted_string_rec delim lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 1044 "parsing/lexer.mll"
      ( update_loc lexbuf None 1 false 0;
        store_lexeme lexbuf;
        quoted_string delim lexbuf
      )
# 2679 "parsing/lexer.ml"

  | 1 ->
# 1049 "parsing/lexer.mll"
      ( is_in_string := false;
        raise (Error (Unterminated_string, !string_start_loc)) )
# 2685 "parsing/lexer.ml"

  | 2 ->
# 1052 "parsing/lexer.mll"
      (
        let edelim = Lexing.lexeme lexbuf in
        let edelim = String.sub edelim 1 (String.length edelim - 2) in
        if delim = edelim then ()
        else (store_lexeme lexbuf; quoted_string delim lexbuf)
      )
# 2695 "parsing/lexer.ml"

  | 3 ->
# 1059 "parsing/lexer.mll"
      ( store_string_char(Lexing.lexeme_char lexbuf 0);
        quoted_string delim lexbuf )
# 2701 "parsing/lexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf; 
      __ocaml_lex_quoted_string_rec delim lexbuf __ocaml_lex_state

and skip_sharp_bang lexbuf =
    __ocaml_lex_skip_sharp_bang_rec lexbuf 192
and __ocaml_lex_skip_sharp_bang_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 1064 "parsing/lexer.mll"
       ( update_loc lexbuf None 3 false 0 )
# 2713 "parsing/lexer.ml"

  | 1 ->
# 1066 "parsing/lexer.mll"
       ( update_loc lexbuf None 1 false 0 )
# 2718 "parsing/lexer.ml"

  | 2 ->
# 1067 "parsing/lexer.mll"
       ( () )
# 2723 "parsing/lexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf; 
      __ocaml_lex_skip_sharp_bang_rec lexbuf __ocaml_lex_state

;;

# 1069 "parsing/lexer.mll"
 

  let at_bol lexbuf = 
    let pos = Lexing.lexeme_start_p lexbuf in 
    pos.pos_cnum = pos.pos_bol 

  let token_with_comments lexbuf =
    match !preprocessor with
    | None -> token lexbuf
    | Some (_init, preprocess) -> preprocess token lexbuf

  type newline_state =
    | NoLine (* There have been no blank lines yet. *)
    | NewLine
        (* There have been no blank lines, and the previous
           token was a newline. *)
    | BlankLine (* There have been blank lines. *)

  type doc_state =
    | Initial  (* There have been no docstrings yet *)

  let interpret_directive lexbuf cont look_ahead = 
    let if_then_else = !if_then_else in
    begin match token_with_comments lexbuf, if_then_else with 
    |  IF, Dir_out  ->
        let rec skip_from_if_false () = 
          let token = token_with_comments lexbuf in
          if token = EOF then 
            raise (Error (Unterminated_if, Location.curr lexbuf)) else
          if token = SHARP && at_bol lexbuf then 
            begin 
              let token = token_with_comments lexbuf in
              match token with
              | END -> 
                  begin
                    update_if_then_else Dir_out;
                    cont lexbuf
                  end
              | ELSE -> 
                  begin
                    update_if_then_else Dir_if_false;
                    cont lexbuf
                  end
              | IF ->
                  raise (Error (Unexpected_directive, Location.curr lexbuf))
              | _ -> 
                  if is_elif token &&
                     directive_parse token_with_comments lexbuf then
                    begin
                      update_if_then_else Dir_if_true;
                      cont lexbuf
                    end
                  else skip_from_if_false ()                               
            end
          else skip_from_if_false () in 
        if directive_parse token_with_comments lexbuf then
          begin 
            update_if_then_else Dir_if_true (* Next state: ELSE *);
            cont lexbuf
          end
        else
          skip_from_if_false ()
    | IF,  (Dir_if_false | Dir_if_true)->
        raise (Error(Unexpected_directive, Location.curr lexbuf))
    | LIDENT "elif", (Dir_if_false | Dir_out)
      -> (* when the predicate is false, it will continue eating `elif` *)
        raise (Error(Unexpected_directive, Location.curr lexbuf))
    | (LIDENT "elif" | ELSE as token), Dir_if_true ->           
        (* looking for #end, however, it can not see #if anymore *)
        let rec skip_from_if_true else_seen = 
          let token = token_with_comments lexbuf in
          if token = EOF then 
            raise (Error (Unterminated_else, Location.curr lexbuf)) else
          if token = SHARP && at_bol lexbuf then 
            begin 
              let token = token_with_comments lexbuf in 
              match token with  
              | END -> 
                  begin
                    update_if_then_else Dir_out;
                    cont lexbuf
                  end  
              | IF ->  
                  raise (Error (Unexpected_directive, Location.curr lexbuf)) 
              | ELSE ->
                  if else_seen then 
                    raise (Error (Unexpected_directive, Location.curr lexbuf))
                  else 
                    skip_from_if_true true
              | _ ->
                  if else_seen && is_elif token then  
                    raise (Error (Unexpected_directive, Location.curr lexbuf))
                  else 
                    skip_from_if_true else_seen
            end
          else skip_from_if_true else_seen in 
        skip_from_if_true (token = ELSE)
    | ELSE, Dir_if_false 
    | ELSE, Dir_out -> 
        raise (Error(Unexpected_directive, Location.curr lexbuf))
    | END, (Dir_if_false | Dir_if_true ) -> 
        update_if_then_else  Dir_out;
        cont lexbuf
    | END,  Dir_out  -> 
        raise (Error(Unexpected_directive, Location.curr lexbuf))
    | token, (Dir_if_true | Dir_if_false | Dir_out) ->
        look_ahead token 
    end

  let token lexbuf =
    let post_pos = lexeme_end_p lexbuf in

    let rec loop lines docs lexbuf : Parser.token =
      match token_with_comments lexbuf with
      | COMMENT (s, loc) ->
          add_comment (s, loc);
          let lines' =
            match lines with
            | NoLine -> NoLine
            | NewLine -> NoLine
            | BlankLine -> BlankLine
          in
          loop lines' docs lexbuf
      | EOL ->
          let lines' =
            match lines with
            | NoLine -> NewLine
            | NewLine -> BlankLine
            | BlankLine -> BlankLine
          in
          loop lines' docs lexbuf
      | SHARP when at_bol lexbuf -> 
          interpret_directive lexbuf 
            (fun lexbuf -> loop lines docs lexbuf)
            (fun token -> sharp_look_ahead := Some token; SHARP)

      | tok ->

          tok

          
    in
      match !sharp_look_ahead with
      | None -> 
           loop NoLine Initial lexbuf
      | Some token -> 
           sharp_look_ahead := None ;
           token

  let init () =
    sharp_look_ahead := None;
    update_if_then_else  Dir_out;
    is_in_string := false;
    comment_start_loc := [];
    comment_list := [];
    match !preprocessor with
    | None -> ()
    | Some (init, _preprocess) -> init ()

  let rec filter_directive pos   acc lexbuf : (int * int ) list =
    match token_with_comments lexbuf with
    | SHARP when at_bol lexbuf ->
        (* ^[start_pos]#if ... #then^[end_pos] *)
        let start_pos = Lexing.lexeme_start lexbuf in 
        interpret_directive lexbuf 
          (fun lexbuf -> 
             filter_directive 
               (Lexing.lexeme_end lexbuf)
               ((pos, start_pos) :: acc)
               lexbuf
          
          )
          (fun _token -> filter_directive pos acc lexbuf  )
    | EOF -> (pos, Lexing.lexeme_end lexbuf) :: acc
    | _ -> filter_directive pos  acc lexbuf

  let filter_directive_from_lexbuf lexbuf = 
    List.rev (filter_directive 0 [] lexbuf )

  let set_preprocessor init preprocess =
    escaped_newlines := true;
    preprocessor := Some (init, preprocess)


# 2965 "parsing/lexer.ml"

end
module Bspp_main
= struct
#1 "bspp_main.ml"



let preprocess fn oc = 
  let ic = open_in fn in 
  let lexbuf = Lexing.from_channel ic in 
  let buf = Buffer.create 4096 in 
  Location.init lexbuf fn;
  Lexer.init ();
  lexbuf
  |> Lexer.filter_directive_from_lexbuf  
  |> List.iter
    (fun (start, stop) -> 
       let len = stop - start in 
       if len <> 0 then 
         begin
           seek_in ic start ; 
           Buffer.add_channel buf ic len ; 
           Buffer.output_buffer oc buf ; 
           Buffer.clear buf;
         end
    );
  close_in ic 


let () = 
  preprocess Sys.argv.(1) stdout

end
