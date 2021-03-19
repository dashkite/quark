import {r} from "../registry"
import {set} from "../core"

r["order"] = (index) ->
  switch index
    when "first" then set "order", "-9999"
    when "last" then set "order", "9999"
    else set "order", index
