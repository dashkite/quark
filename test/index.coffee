import assert from "assert"
import {print, test, success} from "amen"
import "source-map-support/register"
colors = require "colors"
Diff = require "diff"

import {tee, pipe} from "@pandastrike/garden"
import {
  styles
  select
  set
  setWith
  width
  min
  text
  type
  toString
} from "../src"
import {color} from "./theme"
import Article from "./article"

diffCSS = (expected, actual) ->
  do ({color} = {}, message = "") ->
    for {added, removed, value} in (Diff.diffCss expected, actual)
      color = if added? then "green" else if removed? then "red" else "gray"
      message += (colors[color] value)
    message

verify = ({generator, css}) ->
  expected = css
  actual = toString generator()
  try
    assert.equal expected, actual
  catch error
    console.error "CSS mismatch, diff:", diffCSS expected, actual
    throw error

{article} = Article.bind {type, color}

do ->

  print await test "Neutrino", [

    test "core", [

      test "set", ->
        verify
          generator: styles [ select "main", [ set "display", "block" ] ]
          css: "main { display: block; }"

      test "setWith", ->
        foo = setWith "display", (value) ->
          if value == "bar" then "block" else "span"
        verify
          generator: styles [ select "main", [ foo "bar" ] ]
          css: "main { display: block; }"
    ]


    test "dimension", [

      test "height"

      test "min height"

      test "max height"

      test "width", ->
        verify
          generator: styles [ select "main", [ width "90%" ] ]
          css: "main { width: 90%; }"

      test "min width", ->
        verify
          generator: styles [ select "main", [ min width "90%" ] ]
          css: "main { min-width: 90%; }"

      test "max width"

    ]

    test "colors", [

      # TODO test fallback to browser colors?

      test "color", ->
        verify
          generator: styles [ select "main", [ color "dark-blue" ] ]
          css: "main { color: #00449e; }"

      test "background"

    ]

    test "typography", [

      test "text", ->
        verify
          generator: styles [ select "main", [ text "6rem", "2/3" ] ]
          css: "main { line-height: 6rem; font-size: calc(6rem * 2/3); }"

      test "type", ->
        verify
          generator: styles [ select "main", [ type "large heading" ] ]
          css: "main {
            font-family: sans-serif;
            font-weight: bold;
            line-height: 10rem;
            font-size: calc(10rem * 0.8);
          }"

      test "readable"

    ]

    test "borders"

    test "flexbox", [

      test "rows"

      test "columns"

      test "wrap"

    ]

    test "forms"

    test "tables"

    test "code"

    test "resets", [

      test "block"

      test "lists"

    ]

    test "normalize", [

      test "h1"

      test "p"

      test "ul"

    ]

    test "article", [

      test "h1"

      test "p"

      test "ul"
      
    ]


  ]

  process.exit if success then 0 else 1
