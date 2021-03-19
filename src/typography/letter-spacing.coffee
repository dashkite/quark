import {r} from "../registry"
import {set} from "../core"

r["letter-spacing"] = set "letter-spacing"

r["tracking"] = (units) ->
  set "letter-spacing",
    switch units
      when "tighter" then "-0.05em"
      when "tight" then "-0.025em"
      when "normal" then "0em"
      when "wide" then "0.025em"
      when "wider" then "0.05em"
      when "widest" then "0.1em"
      else units
