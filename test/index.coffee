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
  rows
  columns
  wrap
  render
  borders
  form
  reset
} from "../src"
import {color} from "./theme"
import Article from "./article"

diffCSS = (expected, actual) ->
  do ({color} = {}, message = "") ->
    for {added, removed, value} in (Diff.diffCss expected, actual)
      color = if added? then "green" else if removed? then "red" else "gray"
      message += (colors[color] value)
    message

verify = ({quark, css}) ->
  expected = css
  actual = render quark
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
          quark: styles [ select "main", [ set "display", "block" ] ]
          css: "main { display: block; }"

    ]


    test "dimension", [

      test "height"

      test "width", ->
        verify
          quark: styles [ select "main", [ width "90%" ] ]
          css: "main { width: 90%; }"

      test "minWidth", ->
        verify
          quark: styles [ select "main", [ minWidth "90%" ] ]
          css: "main { min-width: 90%; }"

      test "stretch", ->
        verify
          quark: styles [ select "main", [ width "stretch" ] ]
          css: "main { width: -webkit-fill-available; width: stretch; }"

    ]

    test "colors", [

      # TODO test fallback to browser colors?

      test "color", ->
        verify
          quark: styles [ select "main", [ color "dark-blue" ] ]
          css: "main { color: #00449e; }"

      test "background"

    ]

    test "typography", [

      test "text", ->
        verify
          quark: styles [ select "main", [ text "6rem", "2/3" ] ]
          css: "main { line-height: 6rem; font-size: calc(6rem * 2/3); }"

      test "type", ->
        verify
          quark: styles [ select "main", [ type "large heading" ] ]
          css: "main {
            font-family: sans-serif;
            font-weight: bold;
            line-height: 10rem;
            font-size: calc(10rem * 0.8);
          }"

      test "readable"

    ]

    test "borders", ->
      verify
        quark: styles [ select "main", [ borders [ "round" ] ] ]
        css: "main {
          border-style: solid;
          border-width: 1px;
          border-radius: 0.5rem;
        }"

    test "flexbox", [

      test "rows", ->
        verify
          quark: styles [ select "main", [ rows ] ]
          css: "main { display: flex; }"

      test "columns", ->
        verify
          quark: styles [ select "main", [ columns ] ]
          css: "main { display: flex; flex-direction: column; }"

      test "wrap", ->
        verify
          quark: styles [ select "main", [ rows, wrap ] ]
          css: "main { display: flex; flex-wrap: wrap; }"

    ]

    test "forms", ->
      render styles [ select "form", [ form [ "header", "section", "input" ] ]]


    test "tables"

    test "code"

    test "resets", [

      test "block", ->
        quark: styles [ select "main", [ reset [ "block" ] ]]
        css: "
          main {
            box-sizing: border-box;
            display: block;
            margin: 0;
            padding: 0;
            border: none;
            font-family: inherit;
            font-size: inherit;
            line-height: inherit;
          }"

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
