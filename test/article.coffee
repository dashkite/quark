import {tee, flow} from "panda-garden"
import {push, pop, peek} from "@dashkite/katana"
import {rule, property} from "../src"

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

export default Article
