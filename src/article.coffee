import {tee, pipe, pipeWith} from "@pandastrike/garden"
import {spush as push, spop as pop, speek as peek} from "@dashkite/katana"
import {select, set, lookup} from "./core"
import {type} from "./typography"
import {hrem, qrem, em} from "./units"
import {display, margin, padding, readable} from "./dimension"
import {borders} from "./borders"
import {reset} from "./reset"
import {normalize} from "./normalize"

block = (m) ->

  pipe [
    reset [ "block" ]
    select "&:not(:last-child)", [
      switch m
        when "extra large" then margin bottom: hrem 5
        when "large" then margin bottom: hrem 4
        when "medium" then margin bottom: hrem 3
        when "small" then margin bottom: hrem 2
    ]
  ]

header = pipe [
  select "header", [
    block "extra large"
  ]
]

h1 = pipe [
  select "h1", [
    block "medium"
    type "extra large heading"
  ]
]

h2 = pipe [
  select "h2", [
    block "medium"
    type "large heading"
    padding bottom: qrem 1
    borders [ "bottom" ]
    set "border-color", "inherit"
  ]
]

h3 = pipe [
  select "h3", [
    block "small"
    type "heading"
  ]
]

h4 = pipe [
  select "h4", [
    block "small"
    type "small heading"
  ]
]

h5 = pipe [
  select "h5", [
    block "small"
    type "extra small heading"
  ]
]

p = pipe [
  select "p", [
    block "medium"
    type "copy"
  ]
]

ul = pipe [
  select "ul", [
    block "medium"
    margin left: em 1
    set "list-style", "disc outside"
  ]
]

li = pipe [
  select "li", [
    block "small"
    display "list-item"
    type "copy"
  ]
]

all = pipe [
  readable
  header
  h1, h2, h3, h4, h5, p, ul, li
  normalize [ "links" ]
]

article = lookup {readable, h1, h2, h3, h4, h5, p, ul, li, all}

export {article}
