import {pipe} from "@pandastrike/garden"
import {speek as peek} from "@dashkite/katana"
import {property} from "./index"

italic = peek property "font-style", "italic"
bold = peek property "font-weight", "bold"
underline = peek property "text-decoration", "underline"
strikeout = peek property "text-decoration", "line-through"
capitalize = peek property "text-transform", "capitalize"
uppercase = peek property "text-transform", "uppercase"
plain = pipe [
  peek property "font-style", "normal"
  peek property "font-weight", "normal"
  peek property "text-decoration", "none"
  peek property "text-transform", "none"
]

sans = peek property "font-family", "sans-serif"

export {italic, bold, underline, strikeout, capitalize, uppercase, plain, sans}
