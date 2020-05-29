import assert from "assert"
import {print, test, success} from "amen"
import "source-map-support/register"

import {wrap, tee, flow} from "panda-garden"
import {stack, push, pop, peek, log} from "@dashkite/katana"

import {rule} from "../src"
import {stylesheet, toString} from "./helpers"
import theme from "./theme"
import Article from "./article"

{article} = Article.bind theme

sheet = stylesheet flow [
  push rule "main"
  article
]

do ->

  print await test "Neutrino basic test", ->

    expected = """
      main article { margin-bottom: '4rem'; }
      main article > h1 { color: 'blue'; }
      """

    assert.equal expected, toString await sheet()

  process.exit if success then 0 else 1
