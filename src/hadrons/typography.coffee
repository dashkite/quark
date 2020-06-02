import {pipe, curry} from "@pandastrike/garden"
import {set} from "../core"

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

rem = (n) -> "#{n}rem"

rhythm = curry (lineHeight, ratio) ->
  pipe [
    set "font-size", rem lineHeight * ratio
    set "line-height", rem lineHeight
  ]

typography =
  "banner": pipe [ sans, bold, rhythm 18, 4/5 ]
  "extra large heading": pipe [ sans, bold, rhythm 14, 4/5 ]
  "large heading": pipe [ sans, bold, rhythm 10, 4/5 ]
  "heading": pipe [ sans, bold, rhythm 8, 4/5 ]
  "small heading": pipe [ sans, bold, rhythm 7, 4/5 ]
  "extra small heading": pipe [ sans, bold, rhythm 6, 4/5 ]
  "extra large copy": pipe [ serif, rhythm 8, 2/3 ]
  "large copy": pipe [ serif, rhythm 7, 2/3 ]
  "copy": pipe [ serif, rhythm 6, 2/3 ]
  "small copy": pipe [ serif, rhythm 5, 2/3 ]
  "extra small copy": pipe [ serif, rhythm 5, 2/3 ]

type = (name) -> typography[name]

export {italic, bold, underline, strikeout, capitalize, uppercase, plain,
  sans, serif, monospace, type}
