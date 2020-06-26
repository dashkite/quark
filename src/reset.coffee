import {pipe, pipeWith} from "@pandastrike/garden"
import {select, set, lookup} from "./core"
import {display, margin, padding} from "./dimension"

reset = pipeWith lookup

  block: _resetBlock = pipe [

    set "box-sizing", "border-box"
    display "block"

    margin 0
    padding 0
    set "border", "none"

    set "font-family", "inherit"
    set "font-size", "inherit"
    set "line-height", "inherit"

    # TODO can't do this correctly in quark yet
    # &:before, &:after
    #   box-sizing inherit
  ]

  "inline-block": pipe [
    _resetBlock
    display "inline-block"
  ]

  list: pipe [
    _resetBlock
    set "list-style", "none"

    select "li", [
      _resetBlock
    ]
  ]

  blockquote: pipe [
    set "quotes", "none"

    # &:after, &:before
    #   content ""
    #   content none

  ]

  table: pipe [
    set "display", "table"
    set "border-collapse", "collapse"
    set "border-spacing", 0
  ]

export {reset}
