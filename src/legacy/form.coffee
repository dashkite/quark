import {pipe, pipeWith} from "@pandastrike/garden"
import {select, set, lookup, supports} from "./core"
import {reset} from "./reset"
import {hrem, pct} from "./units"
import {color, background} from "./color"
import * as d from "./dimension"
import * as t from "./typography"
import * as f from "./flexbox"
import {borders} from "./borders"
import {cursor, outline, shadow, opacity, verticalAlign} from "./misc"

disabled = select "&:disabled", [
  color "gray"
  background "light-gray"
  opacity 3/4
  cursor "not-allowed"
]

focus = select "&:focus", [
  outline "none"
  shadow "0 0 0 2px currentColor"
]

appearance = pipe [
  set "-webkit-appearance", "none"
  set "-moz-appearance", "none"
  set "appearance", "none"
]

normalize = pipe [
  appearance
  focus
  disabled
]

toggle = (selector) -> select selector, [
  normalize

  set "box-sizing", "border-box"

  d.height hrem 3
  d.width hrem 3
  d.display "inline-block"
  verticalAlign "middle"
  set "position", "relative"
  d.margin "0 1rem 0 0"
  cursor "pointer"
  borders ["all", "silver"]
  background "transparent"

  select "&:checked", [
    background "black"
  ]

  select "&:disabled:checked", [
    background "#555"
  ]
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
    d.minWidth hrem 24

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
      d.display "inline-block"
      t.type "label"
      t.bold
    ]
  ]

  input: select "input[type='text'], input:not([type])", [
    reset [ "block" ]
    normalize
    d.width "stretch"
    set "margin-bottom", hrem 1
    borders [ "round", "silver" ]
    d.padding hrem 1.5
    # TODO adjust text styles
    t.type "field"
  ]

  textarea: select "textarea", [
    reset [ "block" ]
    normalize
    d.height hrem 8 * 3 # 8 lines
    d.width "stretch"
    d.margin botom: hrem 1
    borders [ "round", "silver" ]
    d.padding hrem 1.5
    t.type "field"
  ]

  search: select "input[type='search']", [
    reset [ "block" ]
    normalize
    d.width "stretch"
    set "margin-bottom", hrem 1
    borders [ "round", "silver" ]
    d.padding hrem 1.5
    # TODO adjust text styles
    t.type "field"
  ]

  select: select "select", [
    reset [ "block" ]
    normalize
    d.width "stretch"
    set "margin-bottom", hrem 1
    borders [ "round", "silver" ]
    d.padding hrem 1.5
    # TODO adjust text styles
    t.type "field"

    # The arrow on the selectbox
    set "background-image", "url('data:image/svg+xml;charset=US-ASCII,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20width%3D%22292.4%22%20height%3D%22292.4%22%3E%3Cpath%20d%3D%22M287%2069.4a17.6%2017.6%200%200%200-13-5.4H18.4c-5%200-9.3%201.8-12.9%205.4A17.6%2017.6%200%200%200%200%2082.2c0%205%201.8%209.3%205.4%2012.9l128%20127.9c3.6%203.6%207.8%205.4%2012.8%205.4s9.2-1.8%2012.8-5.4L287%2095c3.5-3.5%205.4-7.8%205.4-12.8%200-5-1.9-9.2-5.5-12.8z%22%2F%3E%3C%2Fsvg%3E')"
    set "fill", "currentColor"
    set "background-repeat", "no-repeat, repeat"
    set "background-position", "right .7em top 50%, 0 0"
    set "background-size", ".65em auto, 100%"
  ]

  checkbox: supports "(-webkit-appearance: none) or (-moz-appearance: none) or (appearance: none)", [
    toggle "input[type='checkbox']"

    select "input[type='checkbox']", [
      d.display "inline-block"
      set "border-radius", hrem 0.75
      select "&:checked:after", [
        set "content", "''"
        d.display "block"
        set "position", "absolute"
        set "width", hrem 0.5
        set "height", hrem 1.5
        set "border-bottom", "2px solid white"
        set "border-right", "2px solid white"
        set "left", "0.5rem"
        set "bottom", "0.35rem"
        set "transform", "rotate(45deg)"
    ] ]
  ]

  radio: supports "(-webkit-appearance: none) or (-moz-appearance: none) or (appearance: none)", [
    toggle "input[type='radio']"

    select "input[type='radio']", [
      set "border-radius", pct 50
      select "&:checked:after", [
        set "content", "''"
        d.display "block"
        set "position", "absolute"
        set "border-radius", pct 50
        background "white"
        set "width", hrem 1.25
        set "height", hrem 1.25
        set "left", "0.4rem"
        set "bottom", "0.4rem"
    ] ]
  ]

  button: select "button", [
    normalize
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
  ]

  url:  select "[t.type='url']", [ set "word-break", "break-all" ]

export {form}
