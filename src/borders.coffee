import {pipe, pipeWith} from "@pandastrike/garden"
import {set, lookup} from "./core"
import {rem, px, pct} from "./units"
import {colors} from "./color"

_colors = {}
for name, value of colors
  _colors[name] = set "border-color", value

borders = pipeWith lookup {

  all: _bordersAll = pipe [
    set "border-style", "solid"
    set "border-width", px 1
  ]

  round: pipe [
    # round always implies all
    _bordersAll
    set "border-radius", rem 1/2
  ]

  circular: pipe [
    _bordersAll
    set "border-radius", pct 50
  ]

  top: pipe [
    set "border-top-style", "solid"
    set "border-top-width", "1px"
  ]
  right: pipe [
    set "border-right-style", "solid"
    set "border-right-width", "1px"
  ]
  bottom: pipe [
    set "border-bottom-style", "solid"
    set "border-bottom-width", "1px"
  ]
  left: pipe [
    set "border-left-style", "solid"
    set "border-left-width", "1px"
  ]
  none: pipe [
    set "border-style", "none"
    set "border-width", "0"
  ]

  _colors...

}

export {borders}
