import {pipe, curry} from "@pandastrike/garden"
import {set} from "./core"
import {rem} from "./units"

italic = set "font-style", "italic"
bold = set "font-weight", "bold"
underline = set "text-decoration", "underline"
strikeout = set "text-decoration", "line-through"
capitalize = set "text-transform", "capitalize"
uppercase = set "text-transform", "uppercase"
plain = pipe [
  set "font-style", "normal"
  set "font-weight", "normal"
  set "text-decoration", "none"
  set "text-transform", "none"
]

sans = set "font-family", "sans-serif"
serif = set "font-family", "serif"
monospace = set "font-family", "monospace"

text = curry (lh, r) ->
  pipe [
    set "line-height", lh
    set "font-size", "calc(#{lh} * #{r})"
  ]

typography =
  "banner": pipe [ sans, bold, text (rem 18), 4/5 ]
  "extra large heading": pipe [ sans, bold, text (rem 14), 4/5 ]
  "large heading": pipe [ sans, bold, text (rem 10), 4/5 ]
  "heading": pipe [ sans, bold, text (rem 8), 4/5 ]
  "small heading": pipe [ sans, bold, text (rem 7), 4/5 ]
  "extra small heading": pipe [ sans, bold, text (rem 6), 4/5 ]
  "extra large copy": pipe [ serif, text (rem 8), 2/3 ]
  "large copy": pipe [ serif, text (rem 7), 2/3 ]
  "copy": pipe [ serif, text (rem 6), 2/3 ]
  "small copy": pipe [ serif, text (rem 5), 2/3 ]
  "extra small copy": pipe [ serif, text (rem 5), 2/3 ]

type = (name) -> typography[name]

export {italic, bold, underline, strikeout, capitalize, uppercase, plain,
  sans, serif, monospace, type}
