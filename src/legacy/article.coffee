import {tee, pipe, pipeWith} from "@dashkite/joy/function"
import {spush as push, spop as pop, speek as peek} from "@dashkite/katana"
import {select, media, set, lookup, sheet, render} from "./core"
import {color, background} from "./color"
import {type} from "./typography"
import {pct, rem, hrem, qrem, em} from "./units"
import {display, margin, padding, maxWidth, float, readable} from "./dimension"
import {border, borders} from "./borders"
import {reset} from "./reset"
import {normalize} from "./normalize"
import {opacity, important} from "./misc"

block = (m) ->

  pipe [
    reset [ "block" ]
    select "&:not(:last-child)", [
      switch m
        when "extra large" then margin bottom: hrem 5
        when "large" then margin bottom: hrem 4
        when "medium" then margin bottom: hrem 3
        when "small" then margin bottom: hrem 2
        when "extra small" then margin bottom: hrem 1
    ]
  ]

header = pipe [
  select "header", [
    block "extra large"
  ]
]

section = pipe [
  select "section", [
    block "large"
  ]
]

inset = pipe [
  block "medium"
  borders [ "round" ]
  padding rem 1
  select "h2", [
    block "extra small"
    type "small heading"
  ]
  select "h3", [
    block "extra small"
    type "extra small heading"
  ]
  select "& p, & li, & blockquote", [
    type "small copy"
  ]
]

aside = pipe [
  select "aside", [
    inset
  ]
]

figure = pipe [
  select "figure", [
    inset
    select "figcaption", [
      block "small"
      type "extra small heading"
    ]
  ]
]

right = pipe [
  media "screen and (min-width: 60rem)", [
    float "right"
    maxWidth pct 40
    margin
      left: important hrem 3
      right: important qrem 1
      bottom: important hrem 1
  ]
]

left = pipe [
  media "screen and (min-width: 60rem)", [
    float "left"
    maxWidth pct 40
    margin
      left: important qrem 1
      right: important rem 1
      bottom: important hrem 1
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

h6 = pipe [
  select "h6", [
    block "small"
    type "extra small heading"
    opacity pct 60
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
    select "& > ul > li", [
      margin bottom: important 0
    ]
  ]
]

bq = pipe [
  select "blockquote", [
    block "small"
    display "block"
    type "copy"
    padding left: hrem 1
    border left: "2px solid"
  ]
]

code = pipe [
  select "code", [
    display "inline-block"
    padding qrem 0.5
    background "var(--code-background, #eee)"
    set "font-size", pct 80
    set "font-family", "var(--code-font, monospace)"
  ]
]

all = pipe [
  readable
  header, section
  h1, h2, h3, h4, h5, h6
  p, ul, li, bq, code,
  aside, figure
  normalize [ "links" ]
]

article = pipeWith lookup {
  readable
  header, section
  h1, h2, h3, h4, h5, h6
  p, ul, li, bq, code,
  aside, figure
  left, right
  "aside left": select "aside", [ left ]
  "aside right": select "aside", [ right ]
  "figure left": select "figure", [ left ]
  "figure right": select "figure", [ right ]
  all
}

export {article, inset}
