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

visibility = set "visibility"
visible = visibility "visible"
invisible = visibility "hidden"

opacity = set "opacity"
transparent = opacity 0
opaque = opacity 1

background = set "background"

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

border = set "border"

fit = set "object-fit"

shadow = set "box-shadow"

font = set "font"

italic = set "font-style", "italic"
bold = set "font-weight", "bold"
underline = set "text-decoration", "underline"
strike = set "text-decoration", "line-through"
capitalize = set "text-transform", "capitalize"
uppercase = set "text-transform", "uppercase"

src = set "src"

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
  visibility
  visible
  invisible
  opacity
  transparent
  opaque
  background
  width
  height
  max
  min
  margin
  padding
  border
  fit
  font
  italic
  bold
  underline
  strike
  capitalize
  uppercase
  src
  custom
}