import assert from "assert"
import {print, test, success} from "amen"
import "source-map-support/register"
colors = require "colors"
Diff = require "diff"

import {tee, pipe} from "@pandastrike/garden"
import * as q from "../src"
import {color} from "./theme"

diffCSS = (expected, actual) ->
  do ({color} = {}, message = "") ->
    for {added, removed, value} in (Diff.diffCss expected, actual)
      color = if added? then "green" else if removed? then "red" else "gray"
      message += (colors[color] value)
    message

verify = ({quark, css}) ->
  expected = css
  actual = q.render quark
  try
    assert.equal expected, actual
  catch error
    console.error "CSS mismatch, diff:", diffCSS expected, actual
    throw error

do ->

  print await test "Neutrino", [

    test "core", [

      test "set", ->
        verify
          quark: q.sheet [ q.select "main", [ q.set "display", "block" ] ]
          css: "main { display: block; }"

    ]


    test "dimension", [

      test "height"

      test "width", ->
        verify
          quark: q.sheet [ q.select "main", [ q.width "90%" ] ]
          css: "main { width: 90%; }"

      test "minWidth", ->
        verify
          quark: q.sheet [ q.select "main", [ q.minWidth "90%" ] ]
          css: "main { min-width: 90%; }"

      test "stretch", ->
        verify
          quark: q.sheet [ q.select "main", [ q.width "stretch" ] ]
          css: "main { width: -webkit-fill-available; width: stretch; }"

    ]

    test "colors", [

      # TODO test fallback to browser colors?

      test "color", ->
        verify
          quark: q.sheet [ q.select "main", [ q.color "dark-blue" ] ]
          css: "main { color: #00449e; }"

      test "background"

    ]

    test "typography", [

      test "text", ->
        verify
          quark: q.sheet [ q.select "main", [ q.text "6rem", "2/3" ] ]
          css: "main { line-height: 6rem; font-size: calc(6rem * 2/3); }"

      test "type", ->
        verify
          quark: q.sheet [ q.select "main", [ q.type "large heading" ] ]
          css: "main {
            font-family: sans-serif;
            font-weight: bold;
            line-height: 2.5rem;
            font-size: calc(2.5rem * 0.8);
          }"

      test "readable"

    ]

    test "borders", ->
      verify
        quark: q.sheet [ q.select "main", [ q.borders [ "round" ] ] ]
        css: "main {
          border-style: solid;
          border-width: 1px;
          border-radius: 0.5rem;
        }"

    test "flexbox", [

      test "rows", ->
        verify
          quark: q.sheet [ q.select "main", [ q.rows ] ]
          css: "main { display: flex; }"

      test "columns", ->
        verify
          quark: q.sheet [ q.select "main", [ q.columns ] ]
          css: "main { display: flex; flex-direction: column; }"

      test "wrap", ->
        verify
          quark: q.sheet [ q.select "main", [ q.rows, q.wrap ] ]
          css: "main { display: flex; flex-wrap: wrap; }"

    ]

    test "forms", ->
      q.render q.sheet [
        q.select "form", [
          q.form [ "header", "section", "input" ]
        ]]


    test "tables"

    test "code"

    test "resets", [

      test "block", ->
        verify
          quark: q.sheet [ q.select "main", [ q.reset [ "block" ] ]]
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

    test "selector munging", [

      test "&.", ->
        verify
          quark: q.sheet [
            q.select "img", [
              q.select "&.avatar", [
                q.height  q.hrem 6
                q.width  q.hrem 6
              ] ] ]
          css: "img.avatar { height: 3rem; width: 3rem; }"

      test "&:", ->
        verify
          quark: q.sheet [
            q.select "input", [
              q.select "&:focus", [
                q.set "border-color", "blue"
              ] ] ]
          css: "input:focus { border-color: blue; }"

    ]

    test "at-rules", [

      test "nested media queries", ->
        verify
          quark: q.sheet [
            q.select "article", [
              q.media "screen and (min-width: 800px)", [
                q.select "figure", [
                  q.set "float", "right"
                ]
              ]
            ]
          ]
          css: "
            @media screen and (min-width: 800px) {
              article figure {
                float: right;
              }
            }"

      test "keyframes", ->
        verify
          quark: q.sheet [
            q.keyframes "fade", [
              q.from [ q.opacity 0 ]
              q.to [ q.opacity 1 ]
            ]
          ]
          css: "
            @keyframes fade {
              from { opacity: 0; }
              to { opacity: 1; }
            }"
    ]

    test "object values", [
      test "bottom margin", ->
        verify
          quark: q.sheet [
            q.select "p", [
              q.margin bottom: q.hrem 2
            ]
          ]
          css: "
          p {
            margin-bottom: 1rem;
          }
          "
    ]
  ]

  process.exit if success then 0 else 1
