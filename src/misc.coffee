import {set} from "./core"

cursor = set "cursor"

opacity = set "opacity"

animation = set "animation"

outline = set "outline"

verticalAlign = set "vertical-align"

important = (value) -> "#{value} !important"

export {
  cursor
  opacity
  animation
  outline
  verticalAlign
  important
}
