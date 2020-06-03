import {tee, pipe, pipeWith} from "@pandastrike/garden"
import {spush as push, spop as pop, speek as peek} from "@dashkite/katana"
import {select, set, lookup, rem, readable} from "../src"

Article =

  bind: ({type, color}) ->

    h1 = select "> h1", pipe [
      type "heading"
      color "near-black"
    ]

    block = pipe [
      readable
      set "margin-bottom", rem 4
    ]

    article = pipeWith lookup {h1, block}

    {article, block, h1}

export default Article
