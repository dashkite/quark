import {curry, pipe} from "@pandastrike/garden"
import {set} from "./core"

display = set "display"
width = set "width"
height = set "height"
margin = set "margin"
padding = set "padding"
border = set "border"

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

top = set "top"
right = set "right"
bottom = set "bottom"
left = set "left"

overflow = set "overflow"
float = set "float"
clear = set "clear"

fit = set "object-fit"

rows = display "flex"
columns = pipe [
  display "flex"
  set "flex-direction", "column"
]
wrap = set "flex-wrap", "wrap"

cursor = set "cursor"
opacity = set "opacity"
animation = set "animation"
outline = set "outline"
shadow = set "box-shadow"
valign = set "vertical-align"
important = (value) -> "#{value} !important"

fill = set "fill"
stroke = set "stroke"

italic = set "font-style", "italic"
bold = set "font-weight", "bold"
underline = set "text-decoration", "underline"
strike = set "text-decoration", "line-through"
capitalize = set "text-transform", "capitalize"
uppercase = set "text-transform", "uppercase"

# use rhythmic sizing (line-height-step) when supported
# https://developer.mozilla.org/en-US/docs/Web/CSS/line-height-step
text = curry (lh, r) ->
  pipe [
    set "line-height", lh
    set "font-size", "calc(#{lh} * #{r})"
  ]

export {
  display
  width
  height
  margin
  padding
  border
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
  top
  right
  bottom
  left
  overflow
  fit
  float
  clear
  rows
  columns
  wrap
  cursor
  opacity
  animation
  outline
  shadow
  valign
  important
  fill
  stroke
  italic
  bold
  underline
  strike
  capitalize
  uppercase
  text
}
