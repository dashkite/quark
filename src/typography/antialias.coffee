import {pipe} from "@pandastrike/garden"
import {r} from "../registry"
import {set} from "../core"

r["antialiased"] = pipe [
  set "-webkit-font-smoothing", "antialiased"
  set "-moz-osx-font-smoothing", "grayscale"
]

r["subpixel-antialiased"] = pipe [
  set "-webkit-font-smoothing", "auto"
  set "-moz-osx-font-smoothing", "auto"
]
