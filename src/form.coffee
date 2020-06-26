import {pipe, pipeWith} from "@pandastrike/garden"
import {select, set, lookup} from "./core"
import {reset} from "./reset"
import {hrem} from "./units"
import {padding, maxWidth, height, width} from "./dimension"
import {text, bold} from "./typography"
import {rows, columns} from "./flexbox"
import {borders} from "./borders"

form = pipeWith lookup

  header: select "header", [
    reset [ "block" ]
    columns
    set "margin-bottom", hrem 3
    select "h1", [
      reset [ "block" ]
      # TODO adjust text styles
      text (hrem 6), 4/5
      bold
    ]
  ]

  section: select "section", [
    reset [ "block" ]
    rows
    set "margin-bottom", hrem 3
    select "label", [
      width "stretch"
      # TODO adjust text styles
      text (hrem 3), 4/5
      select "p", [
        reset [ "block" ]
        set "margin-bottom", hrem 2
      ]
    ]
  ]

  input: select "input", [
    reset [ "block" ]
    width "stretch"
    maxWidth "96hrem"
    set "margin-bottom", hrem 1
    borders [ "round", "silver" ]
    padding hrem 1.5
    # TODO adjust text styles
    text (hrem 3), 4/5
    # TODO can't do this correctly in quark yet
    # &:disabled
    #   colors kite-gray lightest-kite-gray
  ]

  textarea: select "textarea", [
    reset [ "block" ]
    height hrem 8 * 3 # 8 lines
    width "stretch"
    maxWidth hrem 96
    set "margin-bottom", hrem 1
    borders [ "round", "silver" ]
    padding hrem 1.5
    # TODO adjust text styles
    text (hrem 3), 4/5
    # TODO can't do this correctly in quark yet
    # &:disabled
    #   colors kite-gray lightest-kite-gray
  ]

export {form}
