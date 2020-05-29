import "source-map-support/register"
import {wrap, tee, flow} from "panda-garden"
import {stack, push, pop, peek, log} from "@dashkite/katana"

import {styles, rule, nestedRule, property} from "../src"

toString = (value) -> value.toString()

top = (stack) -> stack[ stack.length - 1 ]

stylesheet = (f) ->
  flow [
    wrap []
    push styles
    f
    top
  ]

theme =
  colors:
    primary:
      foreground: "blue"

Article =

  bind: (theme) ->

    h1 = tee flow [
      push rule "> h1"
      pop property "color", theme.colors.primary.foreground
    ]

    article = tee flow [
      push rule "article"
      peek property "margin-bottom", "4rem"
      h1
    ]

    {article, h1}

{article} = Article.bind theme

sheet = stylesheet flow [
  push rule "main"
  article
]

do ->
  console.log toString await sheet()
