import {pipe, pipeWith} from "@pandastrike/garden"
import {select, set, lookup} from "./core"
import {reset} from "./reset"
import {hrem} from "./units"
import {color, background} from "./color"
import {padding, minWidth, maxWidth, height, width, gutter} from "./dimension"
import {text, bold} from "./typography"
import {rows, columns, wrap, justifyContent, alignItems} from "./flexbox"
import {borders} from "./borders"
import {cursor, outline} from "./misc"

form = pipeWith lookup

  responsive: pipe [
    width "stretch"
    rows
    wrap
    padding hrem 2
    maxWidth hrem 108
  ]

  header: select "> header", [
    width "stretch"
    rows
    gutter hrem 2

    select "nav", [
      rows
      gutter hrem 2
      alignItems "center"
    ]
  ]

  footer: select "> footer", [
    width "stretch"
    rows
    gutter hrem 2

    select "nav", [
      rows
      gutter hrem 2
      justifyContent "flex-end"
      alignItems "center"
    ]
  ]

  section: select "> section", [
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

  button: select "button", [
    rows
    justifyContent "space-around"
    alignItems "center"
    minWidth hrem 12
    padding hrem 1

    text ( hrem 2), 1

    color "black-90"
    background "white-10"

    borders [ "round", "silver" ]

    cursor "auto"

    select "&:focus", [
      outline "none"
    ]

    select "&:disabled", [
      color "black-50"
      background "silver"
  ]
]

export {form}
