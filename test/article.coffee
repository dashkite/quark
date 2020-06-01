import {tee, pipe} from "@pandastrike/garden"
import {spush as push, spop as pop, speek as peek} from "@dashkite/katana"
import {selector, property} from "../src"

Article =

  bind: ({type, color}) ->

    h1 = tee pipe [
      push selector "> h1"
      type.heading
      color "blue"
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
