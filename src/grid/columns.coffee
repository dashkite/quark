import {r} from "../registry"
import {set} from "../core"

r["grid-columns"] = (n) ->
  if n == "none"
    set "grid-template-columns", "none"
  else
    set "grid-template-columns", "repeat(#{n}, minmax(0, 1fr))"

r["grid-column-span"] = (n) ->
  switch n
    when "auto" then set "grid-column", "auto"
    when "full" then set "grid-column", "1 / -1"
    else set "grid-column", "span #{n} / span #{n}"

r["grid-column-start"] = set "grid-column-start"
r["grid-column-end"] = set "grid-column-end"
