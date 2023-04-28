import assert from "@dashkite/assert"
import {test, success} from "@dashkite/amen"
import print from "@dashkite/amen-console"

import * as Fn from "@dashkite/joy/function"
import * as Prettier from "prettier"

format = ( css ) ->
  # for some reason prettier adds a newline at the end
  ( Prettier.format css, parser: "css" ).trim()

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

{ Property, Properties, Style, Units, Functions } = Q


do ->

  print await test "Quark", [

    test "sheets", [

      test "property", ->
        property = Property.make "color", "green"
        assert.equal "color: green;", Property.render property

      test "properties", ->
        assert.equal "padding-top: 2rem; padding-left: 1rem;", 
          Properties.render Properties.from "padding", 
            top: Units.rem 2
            left: Units.rem 1


      test "rule", ->
        rule = Style.Rule.make "article"
        Style.Rule.append rule,
          Properties.from "padding", 
            top: Units.rem 2
            left: Units.rem 1
        assert.equal "article { padding-top: 2rem; padding-left: 1rem; }", 
          Style.Rule.render rule

    ]

    test "combinators", [

      test "basic", ->
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

    test "nesting", [

      test "&.", ->
        verify
          quark: Q.sheet [
            Q.select "img", [
              Q.select "&.avatar", [
                Q.height  Units.hrem 6
                Q.width  Units.hrem 6
              ] ] ]
          css: "img.avatar { height: 3rem; width: 3rem; }"

      test "&:", ->
        verify
          quark: Q.sheet [
            Q.select "input", [
              Q.select "&:focus", [
                Q.border color: "blue"
              ] ] ]
          css: "input:focus { border-color: blue; }"


    ]

    test "@-rules", [

      test "@font-family", ->

        verify
          quark: Q.sheet [
            Q.fonts [
              Q.font
                family: "Geo"
                style: "normal"
              Q.src Functions.url "fonts/geo_sans_light/GensansLight.ttf"
            ]
          ]
          css: """
            @font-face {
              font-family: Geo;
              font-style: normal;
              src: url("fonts/geo_sans_light/GensansLight.ttf");
            }
          """

      test "@media", ->

        verify
          quark: Q.sheet [
            Q.media "print", [
              Q.select "#header, #footer", [
                Q.hidden
              ]
            ]
          ]
          css: """
            @media print {
              #header,
              #footer {
                display: none;
              }
            }          
          """

    ]
  ]

  process.exit if success then 0 else 1
