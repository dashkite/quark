import {r} from "./registry"
import {set} from "./core"

# TODO color, opacity, and style
# altho you could just write:
#    border-style solid, divider-x 1px
#
# it would be nice to support:
#    divider x 1px solid silver
#

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
