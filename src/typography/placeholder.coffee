import {r} from "../registry"
import {select, set} from "../core"

# TODO: define colors
colors = {}

r.placeholder = (args...) ->
  fx = for arg in args
    if colors[arg]
      set "color", arg
    else
      set "opacity", arg
  select "&::placeholder", pipe fx
