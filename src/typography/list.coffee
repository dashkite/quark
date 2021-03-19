import {r} from "../registry"
import {set} from "../core"

r["list-style"] = set "list-style"
r["list-style-type"] = set "list-style-type"
r["list-style-position"] = set "list-style-position"

r.list = (args...) ->
  fx = for arg in args
    switch arg
      when "none" then set "list-style-type", "none"
      when "disc" then set "list-style-type", "disc"
      when "decimal" then set "list-style-type", "decimal"
      when "inside" then set "list-style-position", "inside"
      when "outside" then set "list-style-position", "outside"
      else -> # ignore
  pipe fx
