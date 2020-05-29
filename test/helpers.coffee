import {wrap, flow} from "panda-garden"
import {push} from "@dashkite/katana"
import {styles} from "../src"

toString = (value) -> value.toString()

top = (stack) -> stack[ stack.length - 1 ]

stylesheet = (f) ->
  flow [
    wrap []
    push styles
    f
    top
  ]

export {toString, stylesheet}
