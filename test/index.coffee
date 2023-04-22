import assert from "@dashkite/assert"
import {test, success} from "@dashkite/amen"
import print from "@dashkite/amen-console"

import * as Fn from "@dashkite/joy/function"
import * as prettier from "prettier"

format = ( css ) ->
  # for some reason prettier adds a newline at the end
  ( prettier.format css, parser: "css" ).trim()

verify = ({ quark, css }) ->
  expected = format css
  actual = format do Q.render quark
  try
    assert.equal expected, actual
  catch error
    console.error "CSS mismatch:", { actual, expected }
    throw error

# MUT
import * as Q from "../src"

{ Property, Properties, Rule, Units } = Q


do ->

  print await test "Quark", [

    test "sheets", [

      test "property", ->
        property = Property.make "color", "green"
        assert.equal "color: green;", Property.render property

      test "properties", ->
        assert.equal "color: green; padding: 1rem;", 
          Properties.render [
            Property.make "color", "green"
            Property.make "padding", "1rem"
          ]

      test "rule", ->
        assert.equal "article { color: green; padding: 1rem; }", 
          Rule.render Rule.make
            selector: "article", 
            properties: [
              Property.make "color", "green"
              Property.make "padding", "1rem"
            ]
    ]

    test "combinators", [
      test "sheet / select / set", ->
        verify
          quark: Q.sheet [ Q.select "main", [ Q.set "display", "block" ] ]
          css: """
            main {
              display: block;
            }
          """

    ]

    test "properties", [

      test "width", ->
        verify
          quark: Q.sheet [ Q.select "main", [ Q.width Units.pct 90 ] ]
          css: "main { width: 90%; }"

      test "compound values", ->
        verify
          quark: Q.sheet [
            Q.select "main", [
              Q.margin
                top: Units.rem 1
                left: Units.hrem 1
            ]
          ]
          css: "main { 
            margin-top: 1rem;
            margin-left: 0.5rem;
          }"

      test "compound properties", ->
        verify
          quark: Q.sheet [
            Q.select "main", [
              Q.max.width Units.rem 16
            ]
          ]
          css: "main { 
            max-width: 16rem;
          }"
    ]
  ]

  process.exit if success then 0 else 1
