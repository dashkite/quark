import {r} from "./registry"
import {set} from "./core"

r.p = set "padding"
r.px = (units) -> set "padding", left: units, right: units
r.py = (units) -> set "padding", top: units, bottom: units
r.pt = (units) -> set "padding", top: units
r.pb = (units) -> set "padding", bottom: units
r.pl = (units) -> set "padding", left: units
r.pr = (units) -> set "padding", right: units

r.m = set "margin"
r.mx = (units) -> set "margin", left: units, right: units
r.my = (units) -> set "margin", top: units, bottom: units
r.mt = (units) -> set "margin", top: units
r.mb = (units) -> set "margin", bottom: units
r.ml = (units) -> set "margin", left: units
r.mr = (units) -> set "margin", right: units

r["space-y"] = (units, direction) ->
  select "& > *:not(:last-child)", [
    set "margin",
      switch direction
        when "reverse" then top: units
        else bottom: units
  ]

r["space-x"] = (units, direction) ->
  select "& > *:not(:last-child)", [
    set "margin",
      switch direction
        when "reverse" then left: units
        else right: units
  ]
