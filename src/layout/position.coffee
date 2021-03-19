import {pipe} from "@pandastrike/garden"
import {r} from "../registry"
import {set} from "../core"
import {position} from "../properties"

{top, bottom, left, right} = r

r["static"] = position "static"

r["inset"] = (units) ->
  pipe [
    top units
    right units
    bottom units
    left units
  ]

r["inset-x"] = (units) ->
  pipe [
    right units
    left units
  ]

r["inset-y"] = (units) ->
  pipe [
    top units
    bottom units
  ]

r["z"] = set "z-index"
