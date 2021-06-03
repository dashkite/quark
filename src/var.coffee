import {pipe} from "@dashkite/joy/function"
import {set} from "./core"

setvar = (object) -> pipe (set "--#{name}", value for name, value of object)

getvar = (name) -> "var(--#{name})"

export {
  setvar
  getvar
}
