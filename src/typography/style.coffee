import {pipe} from "@pandastrike/garden"
import {r} from "../registry"
import {set} from "../core"

r["font-style"] = set "font-style"

r["unstyled"] = pipe [
  set "font-style", "normal"
  set "font-weight", "400"
  set "text-decoration", "none"
]
