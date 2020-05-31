import {tee, pipe} from "@pandastrike/garden"
import {spush as push, spop as pop, speek as peek} from "@dashkite/katana"
import {selector, property} from "../src"

Article =

  bind: (theme) ->

    h1 = tee pipe [
      push selector "> h1"
      theme.type.heading
      pop property "color", theme.colors.primary.foreground
    ]

    block = tee pipe [
      peek property "margin-bottom", "4rem"
    ]

    dictionary = {h1, block}

    article = (names) ->
      combinators = names.map (name) -> dictionary[name]
      tee pipe combinators

    {article, block, h1}

export default Article
