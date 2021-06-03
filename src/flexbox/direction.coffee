import {pipe} from "@dashkite/joy/function"
import {display} from "../properties"
import {set} from "../core"
import {r} from "../registry"

flex = (direction) ->
  pipe [
    display "flex"
    set "flex-direction", direction
  ]

r["rows"] = flex "row"
r["columns"] = flex "column"
r["rows-reverse"] = set "flex-direction", "row-reverse"
r["columns-reverse"] = set "flex-direction", "column-reverse"
