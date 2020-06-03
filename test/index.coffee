import assert from "assert"
import {print, test, success} from "amen"
import "source-map-support/register"
colors = require "colors"
Diff = require "diff"

diffCSS = (expected, actual) ->
  try
    assert.equal expected, actual
  catch
    do ({color} = {}, message = "") ->
      # assert.equal expected, toString await sheet()
      for {added, removed, value} in (Diff.diffCss expected, actual)
        color = if added? then "green" else if removed? then "red" else "gray"
        message += (colors[color] value)
      throw new Error "CSS mismatch: #{message}"

import {tee, pipe} from "@pandastrike/garden"

import {styles, select, toString, type} from "../src"
import {color} from "./theme"
import Article from "./article"

{article} = Article.bind {type, color}

sheet = styles [
  select "main", [
    select "article", [
      article [ "block", "h1" ]
] ] ]


do ->

  print await test "Neutrino baseline test", ->

    expected = "main article {
        width: '-webkit-fill-available';
        width: 'stretch';
        min-width: '20em';
        max-width: '34em';
        margin-bottom: '4rem';
      }
      main article > h1 {
        font-family: 'sans-serif';
        font-weight: 'bold';
        line-height: '8rem';
        font-size: 'calc(8rem * 0.8)';
        color: '#111';
      }"
    diffCSS expected, toString sheet()

  process.exit if success then 0 else 1
