import {r} from "../registry"
import {set} from "../core"

r.flex = (model) ->
  set "flex",
  switch model
    when "auto" then "1 1 auto"
    when "adapt" then "1 1 0%"
    when "shrink" then "0 1 auto"
    when "grow" then "1 0 auto"
    else model
