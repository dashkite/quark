import assert from "assert"
import {print, test, success} from "amen"
import "source-map-support/register"

import {tee, pipe} from "@pandastrike/garden"

import {styles, select, type} from "../src"
import {toString} from "./helpers"
import {color} from "./theme"
import Article from "./article"

{article} = Article.bind {type, color}

sheet = styles pipe [
  select "main"
  tee pipe [
    select "article"
    article [ "block", "h1" ]
  ]
]

do ->

  print await test "Neutrino baseline test", ->

    expected = "main article { margin-bottom: '4rem'; }
      main article > h1 {
        font-family: 'sans-serif';
        font-weight: 'bold';
        line-height: '8rem';
        font-size: 'calc(8rem * 0.8)';
        color: '#111'; }"
    assert.equal expected, toString await sheet()

  process.exit if success then 0 else 1
