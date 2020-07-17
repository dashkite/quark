import {pipe, pipeWith} from "@pandastrike/garden"
import {select, set, lookup} from "./core"
import {reset} from "./reset"
import {hrem} from "./units"
import {color, background} from "./color"
import * as d from "./dimension"
import * as t from "./typography"
import * as f from "./flexbox"
import {borders} from "./borders"
import {cursor, outline} from "./misc"

form = pipeWith lookup

  responsive: pipe [
    d.width "stretch"
    d.maxWidth hrem 108
    d.height "stretch"
    f.rows
    f.wrap
    d.rowGap hrem 2
    d.columnGap hrem 4
  ]

  header: select "> header", [
    d.width "stretch"
    f.rows
    d.rowGap hrem 2

    select "nav", [
      f.rows
      d.rowGap hrem 2
      f.alignItems "center"
    ]
  ]

  footer: select "> footer", [
    d.width "stretch"
    f.rows
    d.rowGap hrem 2
    borders [ "top", "silver" ]
    d.padding top: hrem 2

    select "nav", [
      d.width "stretch"
      f.rows
      d.rowGap hrem 2
      f.justifyContent "flex-end"
      f.alignItems "center"
    ]
  ]

  section: select "section", [
    f.columns
    f.flex
      basis: 0
      grow: 1
    d.minWidth hrem 36
    d.maxWidth hrem 96

    # section within a section is a group of fields
    select "> section", [
      d.margin bottom: hrem 2
      borders [ "bottom", "silver" ]
    ]
  ]

  label: select "label", [
    reset [ "block" ]
    d.margin bottom: hrem 1

    select "& > p", [
      t.type "label"
      t.bold
    ]
  ]

  input: select "input[type='text'], select", [
    reset [ "block" ]
    d.width "stretch"
    d.maxWidth "96hrem"
    set "margin-bottom", hrem 1
    borders [ "round", "silver" ]
    d.padding hrem 1.5
    # TODO adjust text styles
    t.type "field"
    select "&:disabled", [
      color "black-50"
      background "silver"
    ]
    select "&:focus", [
      outline "none"
      borders [ "black" ]
    ]
  ]

  url:  select "[t.type='url']", [ set "word-break", "break-all" ]

  textarea: select "textarea", [
    reset [ "block" ]
    d.height hrem 8 * 3 # 8 lines
    d.width "stretch"
    d.maxWidth hrem 96
    d.margin botom: hrem 1
    borders [ "round", "silver" ]
    d.padding hrem 1.5
    t.type "field"
    select "&:disabled", [
      color "black-50"
      background "silver"
    ]
  ]

  button: select "button", [
    f.rows
    f.justifyContent "space-around"
    f.alignItems "center"
    d.minWidth hrem 12
    d.padding hrem 1

    t.type "label"

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
