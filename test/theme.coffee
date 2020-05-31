import {pipe, tee} from "@pandastrike/garden"
import {property} from "../src"
import {bold, sans} from "../src/base"
import {push} from "@dashkite/katana"

colors =
  primary:
    foreground: "blue"

type =
  heading: tee pipe [
    bold
    sans
  ]

theme = {colors, type}

export default theme
export {colors, type}
