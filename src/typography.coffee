import {pipe, curry} from "@pandastrike/garden"
import {set, lookup} from "./core"
import {qrem, hrem, rem} from "./units"

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

type = lookup
  "banner": pipe [ sans, bold, text (hrem 10), 4/5 ]

  "extra large heading": pipe [ sans, bold, text (hrem 6), 4/5 ]
  "large heading": pipe [ sans, bold, text (hrem 5), 4/5 ]
  "heading": pipe [ sans, bold, text (hrem 4), 4/5 ]
  "small heading": pipe [ sans, bold, text (hrem 3), 4/5 ]
  "extra small heading": pipe [ sans, bold, text (hrem 2), 4/5 ]

  "extra large body": pipe [ plain, serif, text (hrem 5), 2/3 ]
  "large body": pipe [ plain, serif, text (hrem 4), 2/3 ]
  "body": pipe [ plain, serif, text (qrem 7), 2/3 ]
  "small body": pipe [ plain, serif, text (hrem 2), 3/4 ]
  "extra small body": pipe [ plain, serif, text (hrem 1), 4/5 ]

  "extra large copy": pipe [ plain, sans, text (hrem 5), 2/3 ]
  "large copy": pipe [ plain, sans, text (hrem 4), 2/3 ]
  "copy": pipe [ plain, sans, text (qrem 7), 2/3 ]
  "small copy": pipe [ plain, sans, text (hrem 2), 3/4 ]
  "extra small copy": pipe [ plain, sans, text (hrem 1), 4/5 ]

  "extra large caption": pipe [ plain, sans, text (hrem 5), 3/4 ]
  "large caption": pipe [ plain, sans, text (hrem 4), 3/4 ]
  "caption": pipe [ plain, sans, text (hrem 3), 3/4 ]
  "small caption": pipe [ plain, sans, text (hrem 2), 3/4 ]
  "extra small caption": pipe [ plain, sans, text (hrem 1), 4/5 ]

  "extra large label": pipe [ plain, sans, text (hrem 5), 4/5 ]
  "large label": pipe [ plain, sans, text (hrem 4), 4/5 ]
  "label": pipe [ plain, sans, text (hrem 3), 3/4 ]
  "small label": pipe [ plain, sans, text (hrem 3), 2/3 ]
  "extra small label": pipe [ plain, sans, text (hrem 2), 4/5 ]

  "extra large field": pipe [ plain, sans, text (hrem 5), 2/3 ]
  "large field": pipe [ plain, sans, text (hrem 4), 2/3 ]
  "field": pipe [ plain, sans, text (hrem 3), 2/3 ]
  "small field": pipe [ plain, sans, text (hrem 2), 3/4 ]
  "extra small field": pipe [ plain, sans, text (hrem 1), 4/5 ]

  "extra large code": pipe [ plain, monospace, text (hrem 5), 3/4 ]
  "large code": pipe [ plain, monospace, text (hrem 4), 3/4 ]
  "code": pipe [ plain, monospace, text (hrem 3), 3/4 ]
  "small code": pipe [ plain, monospace, text (hrem 2), 3/4 ]
  "extra small code": pipe [ plain, monospace, text (hrem 1), 4/5 ]

export {italic, bold, underline, strikeout, capitalize, uppercase, plain,
  sans, serif, monospace, text, type}
