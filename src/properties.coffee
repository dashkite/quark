import {curry, pipe} from "@pandastrike/garden"
import {set} from "./core"

display = set "display"

width = (units) ->
  set "width",
    switch units
      when "full" then "100%"
      when "screen" then "100vw"
      when "min" then "min-content"
      when "max" then "max-content"
      else units

height = (units) ->
  set "height",
    switch units
      when "full" then "100%"
      when "screen" then "100vh"
      when "min" then "min-content"
      when "max" then "max-content"
      else units

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
  height
  width
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
