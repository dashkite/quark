import {curry, pipe} from "@dashkite/joy/function"
import {set} from "./core"

display = set "display"

block = display "block"
inline = display "inline"
table = display "table"
hidden = display "none"
flex = display "flex"
grid = display "grid"

position = set "position"
fixed = position "fixed"
absolute = position "absolute"
relative = position "relative"
sticky = position "sticky"

visible = set "visibility", "visible"
invisible = set "visibility", "hidden"

fit = set "object-fit"

shadow = set "box-shadow"

italic = set "font-style", "italic"
bold = set "font-weight", "bold"
underline = set "text-decoration", "underline"
strike = set "text-decoration", "line-through"
capitalize = set "text-transform", "capitalize"
uppercase = set "text-transform", "uppercase"

export {
  display
  block
  inline
  table
  hidden
  flex
  grid
  position
  fixed
  absolute
  relative
  sticky
  visible
  invisible
  fit
  italic
  bold
  underline
  strike
  capitalize
  uppercase
}
