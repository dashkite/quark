import {pipe, tee} from "@pandastrike/garden"
import {color as _color} from "../src"

colors =
  "kite-blue": "#61d3ff"

color = (value) -> _color colors[value] ? value

export {color}
