import {pipe, tee} from "@pandastrike/garden"
import {property, bold, sans, color as _color} from "../src"
import {push} from "@dashkite/katana"

colors =
  "kite-blue": "#61d3ff"

color = (value) -> _color colors[value] ? value

export {color}
