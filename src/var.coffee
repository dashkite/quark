import {set} from "./core"

_set = (name, value) -> set "--#{name}", value

setvar = (object) -> _set name, value for name, value of object

_var = (name) -> "var(--#{name})"

export {
  setvar
  _var as var
}
