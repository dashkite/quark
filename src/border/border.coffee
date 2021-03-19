import {r} from "../registry"
import {set} from "../core"

# TODO color, opacity, and style
# altho you could just write:
#    border-style solid, divider-x 1px
#
# it would be nice to support:
#    divider x 1px solid silver
#
r.b = set "border"
r.bx = (units) -> set "border", left: units, right: units
r.by = (units) -> set "border", top: units, bottom: units
r.bt = (units) -> set "border", top: units
r.bb = (units) -> set "border", bottom: units
r.bl = (units) -> set "border", left: units
r.br = (units) -> set "border", right: units


r["divider-y"] = (units, direction) ->
  select "& > *:not(:last-child)", [
    switch direction
      when "reverse" then set "border-top-width", units
      else set "border-bottom-width", units
  ]

r["divider-x"] = (units, direction) ->
  select "& > *:not(:last-child)", [
    switch direction
      when "reverse" then set "border-left-width", units
      else set "border-right-width", units
  ]
