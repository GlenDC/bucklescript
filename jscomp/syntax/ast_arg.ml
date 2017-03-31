(* Copyright (C) 2015-2016 Bloomberg Finance L.P.
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * In addition to the permissions granted to you by the LGPL, you may combine
 * or link a "work that uses the Library" with a publicly distributed version
 * of this file to produce a combined library or application, then distribute
 * that combined work under the terms of your choosing, with no requirement
 * to comply with the obligations normally placed on you by section 4 of the
 * LGPL version 3 (or the corresponding section of a later version of the LGPL
 * should you choose to use a later version).
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA. *)

(** type definitions for external argument *)

type cst = 
  | Arg_int_lit of int 
  | Arg_string_lit of string 

  | Arg_js_null
type label = 
  | Label of string * cst option 
  | Empty of cst option
  | Optional of string 
  (* it will be ignored , side effect will be recorded *)

type ty = 
  | NullString of (int * string) list (* `a does not have any value*)
  | NonNullString of (int * string) list (* `a of int *)
  | Int of (int * int ) list (* ([`a | `b ] [@bs.int])*)
  | Arg_cst of cst
  | Fn_uncurry_arity of int (* annotated with [@bs.uncurry ] or [@bs.uncurry 2]*)
    (* maybe we can improve it as a combination of {!Asttypes.constant} and tuple *)
  | Array 
  | Extern_unit
  | Nothing
  | Ignore

type kind = 
  {
    arg_type : ty;
    arg_label : label
  }


let empty_label = Empty None 
let empty_lit s = Empty (Some s) 
let label s cst = Label(s,cst)
let optional s = Optional s 

let empty_kind arg_type = { arg_label = empty_label ; arg_type }
