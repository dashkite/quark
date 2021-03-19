import {r} from "./registry"
import {set} from "./core"

r.width = (units) ->
  set "width",
    switch units
      when "full" then "100%"
      when "screen" then "100vw"
      when "min" then "min-content"
      when "max" then "max-content"
      else units

r.height = (units) ->
  set "height",
    switch units
      when "full" then "100%"
      when "screen" then "100vh"
      when "min" then "min-content"
      when "max" then "max-content"
      else units

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
