import {pipe, pipeWith} from "@pandastrike/garden"
import {select, set, lookup} from "./core"
import {reset} from "./reset"
import {hrem} from "./units"
import {color, background} from "./color"
import * as d from "./dimension"
import * as t from "./typography"
import * as f from "./flexbox"
import {borders} from "./borders"
import {cursor, outline, opacity} from "./misc"

disabled = select "&:disabled", [
  color "gray"
  background "light-gray"
  opacity 3/4
]

focus = select "&:focus", [
  outline "none"
  borders [ "black" ]
]

form = pipeWith lookup

  responsive: pipe [
    d.width "stretch"
    d.maxWidth hrem 108
    f.rows
    f.wrap
    d.rowGap hrem 4
    d.columnGap hrem 4
  ]

  header: select "> header", [
    d.width "stretch"
    f.rows
    f.alignItems "baseline"
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
      basis: hrem 48
      shrink: 1
      grow: 0
    d.minWidth hrem 36

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

  input: select "input[type='text'], input:not([type]), select", [
    reset [ "block" ]
    d.width "stretch"
    set "margin-bottom", hrem 1
    borders [ "round", "silver" ]
    d.padding hrem 1.5
    # TODO adjust text styles
    t.type "field"
    disabled
    focus
  ]

  url:  select "[t.type='url']", [ set "word-break", "break-all" ]

  textarea: select "textarea", [
    reset [ "block" ]
    d.height hrem 8 * 3 # 8 lines
    d.width "stretch"
    d.margin botom: hrem 1
    borders [ "round", "silver" ]
    d.padding hrem 1.5
    t.type "field"
    focus
    disabled
  ]

  button: select "button", [
    f.rows
    f.justifyContent "center"
    f.alignItems "center"
    d.minWidth hrem 12
    d.padding hrem 1

    t.type "label"

    color "black-90"
    background "white-10"

    borders [ "round", "silver" ]

    cursor "auto"

    focus
    disabled

]

export {form}
