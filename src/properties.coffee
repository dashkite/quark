import { set } from "./combinators"

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

width = set "width"
height = set "height"

max =
  width: set "max-width"
  height: set "max-height"

min =
  width: set "min-width"
  height: set "min-height"

padding = set "padding"

margin = set "margin"

fit = set "object-fit"

shadow = set "box-shadow"

italic = set "font-style", "italic"
bold = set "font-weight", "bold"
underline = set "text-decoration", "underline"
strike = set "text-decoration", "line-through"
capitalize = set "text-transform", "capitalize"
uppercase = set "text-transform", "uppercase"

custom =
  set: ( name, value ) -> set "--#{ name }", value
  get: ( name ) -> "var(--#{ name })"

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
  width
  height
  max
  min
  fit
  italic
  bold
  underline
  strike
  capitalize
  uppercase
  custom
}