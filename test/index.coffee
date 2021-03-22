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

  print await test "Quark", [

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
          quark: q.sheet [ q.select "main", [ q.r.width "90%" ] ]
          css: "main { width: 90%; }"

      # test "minWidth", ->
      #   verify
      #     quark: q.sheet [ q.select "main", [ q.minWidth "90%" ] ]
      #     css: "main { min-width: 90%; }"
      #
      # test "stretch", ->
      #   verify
      #     quark: q.sheet [ q.select "main", [ q.width "stretch" ] ]
      #     css: "main { width: -webkit-fill-available; width: -moz-available; width: stretch; }"

    ]

    # test "colors", [
    #
    #   # TODO test fallback to browser colors?
    #
    #   test "color", ->
    #     verify
    #       quark: q.sheet [ q.select "main", [ q.color "dark-blue" ] ]
    #       css: "main { color: #00449e; }"
    #
    #   test "background"
    #
    # ]

    # test "typography", [
    #
    #   test "text", ->
    #     verify
    #       quark: q.sheet [ q.select "main", [ q.text "6rem", "2/3" ] ]
    #       css: "main { line-height: 6rem; font-size: calc(6rem * 2/3); }"
    #
    #   test "type", ->
    #     verify
    #       quark: q.sheet [ q.select "main", [ q.type "large heading" ] ]
    #       css: "main {
    #         font-family: sans-serif;
    #         font-weight: bold;
    #         line-height: 2.25rem;
    #         font-size: calc(2.25rem * 0.85);
    #       }"
    #
    #   test "readable"
    #
    # ]

    # test "borders", ->
    #   verify
    #     quark: q.sheet [ q.select "main", [ q.borders [ "round" ] ] ]
    #     css: "main {
    #       border-style: solid;
    #       border-width: 1px;
    #       border-radius: 0.5rem;
    #     }"

    test "flexbox", [

      test "rows", ->
        verify
          quark: q.sheet [ q.select "main", [ q.r.rows ] ]
          css: "main { display: flex; flex-direction: row; }"

      test "columns", ->
        verify
          quark: q.sheet [ q.select "main", [ q.r.columns ] ]
          css: "main { display: flex; flex-direction: column; }"

      # test "wrap", ->
      #   verify
      #     quark: q.sheet [ q.select "main", [ q.r.flex, q.r["flex-wrap"] ] ]
      #     css: "main { display: flex; flex-wrap: wrap; }"

    ]

    # test "forms", ->
    #   q.render q.sheet [
    #     q.select "form", [
    #       q.form [ "header", "section", "input" ]
    #     ]]


    # test "tables"
    #
    # test "code"
    #
    # test "resets", [
    #
    #   test "block", ->
    #     verify
    #       quark: q.sheet [ q.select "main", [ q.reset [ "block" ] ]]
    #       css: "
    #         main {
    #           box-sizing: border-box;
    #           display: block;
    #           margin: 0;
    #           padding: 0;
    #           border: none;
    #           font-family: inherit;
    #           font-size: inherit;
    #           line-height: inherit;
    #         }"
    #
    #   test "lists"
    #
    # ]
    #
    # test "normalize", [
    #
    #   test "h1"
    #
    #   test "p"
    #
    #   test "ul"
    #
    # ]
    #
    # test "article", [
    #
    #   test "h1"
    #
    #   test "p"
    #
    #   test "ul"
    #
    # ]
    #
    test "selector munging", [

      test "&.", ->
        verify
          quark: q.sheet [
            q.select "img", [
              q.select "&.avatar", [
                q.r.height  q.hrem 6
                q.r.width  q.hrem 6
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
              q.select "figure", [
                q.media "screen and (min-width: 800px)", [
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
              q.from [ q.r.opacity 0 ]
              q.to [ q.r.opacity 1 ]
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
              q.r.margin bottom: q.hrem 2
            ]
          ]
          css: "
            p {
              margin-bottom: 1rem;
            }
          "
    ]

    test "parsing", [

      test "implicit rule", ->
        verify
          quark: q.sheet [ q.select "p", [ q.q "justify-items 2rem" ] ]
          css: "
            p {
              justify-items: 2rem;
            }
          "

      test "single rule", ->
        verify
          quark: q.sheet [ q.select "p", [ q.q "inset 1rem" ] ]
          css: "
            p {
              top: 1rem;
              right: 1rem;
              bottom: 1rem;
              left: 1rem;
            }
          "
      test "compound rule", ->
        verify
          quark: q.sheet [ q.select "p", [ q.q "inline-block, inset 1rem" ] ]
          css: "
            p {
              display: inline-block;
              top: 1rem;
              right: 1rem;
              bottom: 1rem;
              left: 1rem;
            }
          "
      test "radius", ->
        verify
          quark: q.sheet [ q.select "p", [ q.q "radius sm l" ] ]
          css: "
            p {
              border-top-left-radius: 0.25rem;
              border-bottom-left-radius: 0.25rem;
            }
          "

      test "color substitution", ->
        verify
          quark: q.sheet [ q.select "p", [ q.q "color indigo-300" ] ]
          css: "
            p {
              color: #a5b4fc;
            }
          "

      test "color literal", ->
        verify
          quark: q.sheet [ q.select "p", [ q.q "color #a5b4fc" ] ]
          css: "
            p {
              color: #a5b4fc;
            }
          "

      test "color name", ->
        verify
          quark: q.sheet [ q.select "p", [ q.q "color olive" ] ]
          css: "
            p {
              color: olive;
            }
          "
      test "unit conversion", ->
        verify
          quark: q.sheet [ q.select "p", [ q.q "m 1qrem" ] ]
          css: "
            p {
              margin: 0.25rem;
            }
          "

      test "fractional units", ->
        verify
          quark: q.sheet [ q.select "p", [ q.q "width 1/4vw" ] ]
          css: "
            p {
              width: 0.25vw;
            }
          "

      test "examples", [

        test "p 1rem, border gray-200, radius sm", ->
          verify
            quark: q.sheet [
              q.select "p", [ q.q "p 1rem, border gray-200, radius sm" ] ]
            css: "
              p {
                padding: 1rem;
                border: #e4e4e7;
                border-radius: 0.25rem;
              }
            "
        test "rows, align-items center,
          mb 1r, pb 1r, bb gray-200", ->
          verify
            quark: q.sheet [
              q.select "p", [
                q.q "rows, align-items center,
                  mb 1r, pb 1r, bb gray-200" ] ]
            css: "
              p {
                display: flex;
                flex-direction: row;
                align-items: center;
                margin-bottom: 1rem;
                padding-bottom: 1rem;
                border-bottom: #e4e4e7;
              }
            "
        test "width 8qr, fit contain, mr 1r", ->
          verify
            quark: q.sheet [
              q.select "p", [
                q.q "width 8qr, fit contain, mr 1r" ] ]
            css: "
              p {
                width: 2rem;
                object-fit: contain;
                margin-right: 1rem;
              }
            "

        test "mb 1rem, text xl, leading tight", ->
          verify
            quark: q.sheet [
              q.select "p", [
                q.q "mb 1rem, text xl, leading tight" ] ]
            css: "
              p {
                margin-bottom: 1rem;
                line-height: 1.75rem;
                font-size: 1.25rem;
                line-height: 1.375;
              }
            "

        test "fit contain, max-height 1/4vh", ->
          verify
            quark: q.sheet [
              q.select "p", [
                q.q "fit contain, max-height 1/4vh" ] ]
            css: "p { object-fit: contain; max-height: 0.25vh; }"
      ]

      test "quark parser", ->
        assert.equal "
          p .byline { font-weight: bold; }
          p { margin-bottom: 2rem; border: 1px; }
          h1 { line-height: 1.75rem; font-size: 1.25rem; }
          ", q.parse """
            p % mb 2rem, border 1px
              .byline % bold
            h1 % text xl
            """

    ]
  ]

  process.exit if success then 0 else 1
