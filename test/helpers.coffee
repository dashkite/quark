import {wrap, flow} from "panda-garden"
import {push} from "@dashkite/katana"
import {styles} from "../src"

# TODO prevent extraneous newline
toString = (value) -> value.toString().trim()

top = (stack) -> stack[ stack.length - 1 ]

stylesheet = (f) ->
  flow [
    wrap []
    push styles
    f
    top
  ]

export {toString, stylesheet}
