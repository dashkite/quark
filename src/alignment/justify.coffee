import {r} from "../registry"
import {set} from "../core"

r["justify"] = (justification) ->
  set "justify-content",
    switch justification
      when "start" then "flex-start"
      when "end" then "flex-end"
      when "between" then "space-between"
      when "around" then "space-around"
      when "evenly" then "space-evenly"
      else justification

r["justify-items"] = set "justify-items"

r["justify-self"] = set "justify-self"
