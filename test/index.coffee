import assert from "@dashkite/assert"
import {test, success} from "@dashkite/amen"
import print from "@dashkite/amen-console"

import Diff from "diff"
import colors from "colors"

import * as Fn from "@dashkite/joy/function"

diffCSS = ( expected, actual ) ->
  do ({ color } = {}, message = "") ->
    for {added, removed, value} in (Diff.diffCss expected, actual)
      color = if added? then "green" else if removed? then "red" else "gray"
      message += (colors[color] value)
    message

verify = ({ quark, css }) ->
  expected = css
  actual = do Q.render quark
  try
    assert.equal expected, actual
  catch error
    console.error "CSS mismatch, diff:", diffCSS expected, actual
    throw error

# MUT
import {
  Property
  Properties
  Rule
} from "../src/toolkit"

import * as Q from "../src/core"

do ->

  print await test "Quark", [

    test "basic CSS", [

      test "property", ->
        property = Property.make "color", "green"
        render = Property.render indent: 0
        assert.equal "color: green;",  render property

      test "properties", ->
        assert.equal """
          color: green;
          padding: 1rem;
          """, Properties.render indent: 0, [
            Property.make "color", "green"
            Property.make "padding", "1rem"
          ]

      test "rule", ->
        assert.equal """
          article {
            color: green;
            padding: 1rem;
          }
          """, Rule.render Rule.make "article", [
          Property.make "color", "green"
          Property.make "padding", "1rem"
        ]
    ]

    test "level 2", [
      test "set", ->
        verify
          quark: Q.sheet [ Q.select "main", [ Q.set "display", "block" ] ]
          css: "main { display: block; }"

    ]
  ]

  process.exit if success then 0 else 1
