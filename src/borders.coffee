import {pipe, pipeWith} from "@pandastrike/garden"
import {set, lookup} from "./core"
import {rem, px} from "./units"

borders = pipeWith lookup

  all: _bordersAll = pipe [
    set "border-style", "solid"
    set "border-width", px 1
  ]

  round: pipe [
    # round always implies all
    _bordersAll
    set "border-radius", rem 1/2
  ]

  # TODO allow any color in colors
  silver: set "border-color", "silver"

export {borders}
