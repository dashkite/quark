import {pipe} from "@dashkite/joy/function"
import {set} from "../core"
import {r} from "../registry"

sizes =
  xs: "0.125rem"
  sm: "0.25rem"
  md: "0.375rem"
  lg: "0.5rem"
  xl: "0.75rem"
  "2xl": "1rem"
  "3xl": "1.5rem"

r.radius = (args...) ->

  for arg in args
    if arg in [ "t", "b", "l", "r" ]
      side = arg
    else
      size = sizes[arg] ? arg

  switch side
    when "t"
      pipe [
        set "border-top-left-radius", size
        set "border-top-right-radius", size
      ]
    when "b"
      pipe [
        set "border-bottom-left-radius", size
        set "border-bottom-right-radius", size
      ]
    when "l"
      pipe [
        set "border-top-left-radius", size
        set "border-bottom-left-radius", size
      ]
    when "r"
      pipe [
        set "border-top-right-radius", size
        set "border-bottom-right-radius", size
      ]
    else
      set "border-radius", size
