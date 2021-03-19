import {r} from "../registry"
import {set} from "../core"
import {width, height} from "../properties"

r.w = width
r.h = height

r["min-width"] = (units) ->
  set "min-width",
    switch units
      when "full" then "100%"
      when "min" then "min-content"
      when "max" then "max-content"
      else units

r["min-height"] = (units) ->
  set "min-height",
    switch units
      when "full" then "100%"
      when "min" then "min-content"
      when "max" then "max-content"
      else units

r["max-width"] = (units) ->
  set "max-width",
    switch units
      when "full" then "100%"
      when "min" then "min-content"
      when "max" then "max-content"
      when "prose" then "65ch"
      else units

r["min-height"] = (units) ->
  set "max-height",
    switch units
      when "full" then "100%"
      when "min" then "min-content"
      when "max" then "max-content"
      else units
