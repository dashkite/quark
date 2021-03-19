import {pipe} from "@pandastrike/garden"
import {r} from "../registry"
import {set} from "../core"

sizes =
  "xs":	[ "0.75rem", "1rem"  ]
  "sm":	[ "0.875rem", "1.25rem"  ]
  "base":	[ "1rem", "1.5rem"  ]
  "lg":	[ "1.125rem", "1.75rem"  ]
  "xl":	[ "1.25rem", "1.75rem"  ]
  "2xl":	[ "1.5rem", "2rem"  ]
  "3xl":	[ "1.875rem", "2.25rem"  ]
  "4xl":	[ "2.25rem", "2.5rem"  ]
  "5xl":	[ "3rem", "1"  ]
  "6xl":	[ "3.75rem", "1"  ]
  "7xl":	[ "4.5rem", "1"  ]
  "8xl":	[ "6rem", "1"  ]
  "9xl":	[ "8rem", "1"  ]

# use rhythmic sizing (line-height-step) when supported
# https://developer.mozilla.org/en-US/docs/Web/CSS/line-height-step
text = (args...) ->
  switch args.length
    when 1
      [ code ] = args
      text sizes[ code ]...
    else
      [ fs, lh ] = args
      pipe [
        set "line-height", lh
        set "font-size", fs
      ]

r.text = text
