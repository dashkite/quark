import {set} from "./core"

stop = (value, location) ->
  output = value
  if location
    output += " #{location}"
  output

gradient =
  linear: ({direction = "0deg", stops}) ->
    output = "linear-gradient(#{direction}"
    for _stop in stops
      output += ", #{_stop}"
    output += ")"
    output

export {
  gradient
  stop
}
