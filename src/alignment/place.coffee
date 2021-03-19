import {r} from "../registry"
import {set} from "../core"

r["place"] = (placement) ->
  set "place-content",
    switch placement
      when "start" then "flex-start"
      when "end" then "flex-end"
      when "between" then "space-between"
      when "around" then "space-around"
      when "evenly" then "space-evenly"
      else placement

r["place-items"] = set "place-items"

r["place-self"] = set "place-self"
