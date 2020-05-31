import assert from "assert"
import {print, test, success} from "amen"
import "source-map-support/register"

import {wrap, tee, pipe} from "@pandastrike/garden"
import {stack, spush as push, spop as pop,
  speek as peek} from "@dashkite/katana"

import {styles, selector} from "../src"
import {toString} from "./helpers"
import theme from "./theme"
import Article from "./article"

{article} = Article.bind theme

sheet = styles pipe [
  push selector "main"
  push selector "article"
  article [ "block", "h1" ]
]

do ->

  print await test "Neutrino baseline test", ->

    expected = "main article { margin-bottom: '4rem'; }
      main article > h1 {
        font-weight: 'bold';
        font-family: 'sans-serif';
        color: 'blue'; }"

    assert.equal expected, toString await sheet()

  process.exit if success then 0 else 1
