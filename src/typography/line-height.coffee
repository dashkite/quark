import {r} from "../registry"
import {set} from "../core"

r["line-height"] = set "line-height"

r["leading"] = (units) ->
  set "line-height",
    switch units
      when "tighter" then "1.25"
      when "tight" then "1.375"
      when "none" then "1"
      when "loose" then "1.625"
      when "looser" then "2"
      else units
