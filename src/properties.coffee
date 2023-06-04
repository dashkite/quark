import { set } from "./combinators"

display = set "display"

block = display "block"
inline = display "inline"
table = display "table"
hidden = display "none"

flex = set "flex"
grid = set "grid"

justify = set "justify"
align = set "align"
place = set "place"

gap = set "gap"

order = set "order"

position = set "position"
fixed = position "fixed"
absolute = position "absolute"
relative = position "relative"
sticky = position "sticky"

color = set "color"

visibility = set "visibility"
visible = visibility "visible"
invisible = visibility "hidden"

opacity = set "opacity"
transparent = opacity 0
opaque = opacity 1

background = set "background"

width = set "width"
height = set "height"

# Intended to be used with object values
# Ex: max width: pct 20
max = set "max"
min = set "min"

padding = set "padding"

margin = set "margin"

top = set "top"
left = set "left"
bottom = set "bottom"
right = set "right"

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

line = set "line"
text = set "text"

src = set "src"

export {
  display
  block
  inline
  table
  hidden
  flex
  grid  
  justify
  align
  place
  gap
  order
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
  color
  width
  height
  max
  min
  margin
  padding
  top
  left
  bottom
  right
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
  line
  text
}