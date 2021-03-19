import {r} from "../registry"
import {set} from "../core"

r["align"] = (alignment) ->
  set "align-content",
    switch alignment
      when "start" then "flex-start"
      when "end" then "flex-end"
      when "between" then "space-between"
      when "around" then "space-around"
      when "evenly" then "space-evenly"
      else alignment

r["align-items"] = (alignment) ->
  set "align-items",
    switch alignment
      when "start" then "flex-start"
      when "end" then "flex-end"
      else alignment

r["align-self"] = (alignment) ->
  set "align-self",
    switch alignment
      when "start" then "flex-start"
      when "end" then "flex-end"
      else alignment
