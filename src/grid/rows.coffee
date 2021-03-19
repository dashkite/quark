import {r} from "../registry"
import {set} from "../core"

r["grid-rows"] = (n) ->
  if n == "none"
    set "grid-template-rows", "none"
  else
    set "grid-template-rows", "repeat(#{n}, minmax(0, 1fr))"

r["grid-row-span"] = (n) ->
  switch n
    when "auto" then set "grid-row", "auto"
    when "full" then set "grid-row", "1 / -1"
    else set "grid-row", "span #{n} / span #{n}"

r["grid-row-start"] = set "grid-row-start"
r["grid-row-end"] = set "grid-row-end"
