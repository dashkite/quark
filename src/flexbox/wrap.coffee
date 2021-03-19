import {r} from "../registry"
import {set} from "../core"

r["flex-wrap"] (model) ->
  set "flex-wrap",
    switch model
      when undefined then "wrap"
      when "reverse" then "wrap-reverse"
      when "no-wrap" then "nowrap"
      else model
