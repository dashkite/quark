import assert from "@dashkite/assert"
import {test, success} from "@dashkite/amen"
import print from "@dashkite/amen-console"

import * as Fn from "@dashkite/joy/function"
import * as Prettier from "prettier"
import * as Diff from "diff"
import chalk from "chalk"

format = ( css ) ->
  # for some reason prettier adds a newline at the end
  ( Prettier.format css, parser: "css" ).trim()

diff = ({ actual, expected }) ->
  diff = Diff.diffChars expected, actual
  for part in diff
    [ color, indicator ] = if part.added?
      [ "green", "+" ]
    else if part.removed?
      [ "red", "-" ]
    else [ "gray", ":" ]
    console.log chalk[ color ] indicator, part.value

verify = ({ quark, css }) ->
  expected = format css
  actual = format do Q.render quark
  try
    assert.equal expected, actual
  catch error
    diff { actual, expected }
    throw error

# MUT
import * as Q from "../src"

{ Property, Properties, Style, Units, Type, F } = Q

render = ( value ) -> value.render()

do ->

  print await test "Quark", [

    test "sheets", [

      test "property", ->
        property = Property.make "color", "green"
        assert.equal "color: green;", property.render()

      test "properties", ->
        assert.equal "padding-top: 2rem; padding-left: 1rem;", 
          render Properties.from
            padding: 
              top: Units.rem 2
              left: Units.rem 1


      test "rule", ->
        rule = Style.Rule.make "article"
        rule.append Properties.from
          padding: 
            top: Units.rem 2
            left: Units.rem 1
        assert.equal "article { padding-top: 2rem; padding-left: 1rem; }", 
        render rule

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
              Q.max width: Units.rem 16
            ]
          ]
          css: "main { 
            max-width: 16rem;
          }"

      test "array values", ->
        verify
          quark: Q.sheet [
            Q.select "main", [
              Q.border
                bottom: [
                  Units.px 1
                  "solid"
                  F.var "primary-accent"
                ]
            ]
          ]
          css: "main {
            border-bottom: 1px solid var(--primary-accent);
          }"
      
      test "function values", ->
        verify
          quark: Q.sheet [
            Q.select "main", [
              Q.padding
                bottom: [
                  F.min [
                    Units.rem 1
                    Units.vw 10
                  ]
                  "solid"
                  F.var [
                    "primary-accent"
                    "silver"
                  ]
                ]
            ]
          ]
          css: "main {
            padding-bottom: min(1rem, 10vw) solid var(--primary-accent, silver);
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

      test "@import"

      test "@font-face", ->

        verify
          quark: Q.sheet [
            Q.fonts [
              Q.font
                family: "Geo"
                style: "normal"
              Q.src F.url "fonts/geo_sans_light/GensansLight.ttf"
            ]
          ]
          css: """
            @font-face {
              font-family: Geo;
              font-style: normal;
              src: url("fonts/geo_sans_light/GensansLight.ttf");
            }
          """

      test "@media", [

        test "simple", ->

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

        test "bubbling", ->

          verify
          
            quark: Q.sheet [
              Q.select ".widget", [
                Q.padding Units.px 10
                Q.media "(min-width: 600px)", [
                  Q.padding Units.px 20
                ]
              ]
            ] 
          
            css: """
              @media (min-width: 600px) {
                .widget {
                  padding: 20px;
                }
              }
              .widget {
                padding: 10px;
              }              
            """
        
        test "bubbling with nested rules", ->

          verify
          
            quark: Q.sheet [
              Q.select ".widget", [
                Q.padding Units.px 10
                Q.media "(min-width: 600px)", [
                  Q.select "& > header", [
                    Q.padding Units.px 20
                  ]
                ]
              ]
            ] 
          
            css: """
              @media (min-width: 600px) {
                .widget > header {
                  padding: 20px;
                }
              }
              .widget {
                padding: 10px;
              }              
            """
      ]
      
      test "@keyframes", ->

        verify
          quark: Q.sheet [
            Q.keyframes "pulse", [
              Q.keyframe ( Units.pct 0 ), [ Q.transparent ]
              Q.keyframe ( Units.pct 20 ), [ Q.opacity 0.2 ]
              Q.keyframe ( Units.pct 40 ), [ Q.opacity 0.4 ]
              Q.keyframe ( Units.pct 60 ), [ Q.opacity 0.6 ]
              Q.keyframe ( Units.pct 80 ), [ Q.opacity 0.8 ]
              Q.keyframe ( Units.pct 100 ), [ Q.opaque ]
            ]
          ]
          css: """
            @keyframes pulse {
              0% {
                opacity: 0;
              }
              20% {
                opacity: 0.2;
              }
              40% {
                opacity: 0.4;
              }
              60% {
                opacity: 0.6;
              }
              80% {
                opacity: 0.8;
              }
              100% {
                opacity: 1;
              }
            }
          """

      test "@supports", ->

        verify
          quark: Q.sheet [
            Q.supports "(display: flex)", [
              Q.select "div", [
                Q.display "flex"
              ]
            ]
          ]
          css: """
            @supports (display: flex) {
              div {
                display: flex;
              }
            }
          """

      test "@layer", [

        test "named", ->

          verify
            quark: Q.sheet [
              Q.layer "article", [
                Q.select "p", [
                  Q.margin block: Units.rem 1
                ]
              ]
            ]
            css: """
              @layer article {
                p {
                  margin-block: 1rem;
                }
              }          
              """
        test "anonymous"

        test "nested", ->

          verify
            quark: Q.sheet [
              Q.layer "framework", [
                Q.layer "article", [
                  Q.select "p", [
                    Q.margin block: Units.rem 1
                  ]
                ]
              ]
            ]
            css: """
              @layer framework {
                @layer article {
                  p {
                    margin-block: 1rem;
                  }
                }
              }
              """

      ]

      test "@container", [

        test "anonymous", ->
          verify
            quark: Q.sheet [
              Q.container "(width < 650px)", [
                Q.select ".card", [
                  Q.width Units.pct 50
                  Q.background color: "gray"
                  Q.font size: Units.em 1
                ]
              ]
            ]
            css: """
              @container (width < 650px) {
                .card {
                  width: 50%;
                  background-color: gray;
                  font-size: 1em;
                }
              }        
              """

        test "named", ->
          verify
            quark: Q.sheet [
              Q.container "summary (min-width: 400px)", [
                Q.select ".card", [
                  Q.font size: Units.em 1.5
                ]
              ]
            ]
            css: """
              @container summary (min-width: 400px) {
                .card {
                  font-size: 1.5em;
                }
              }
              """

        test "nested", ->

          verify
            quark: Q.sheet [
              Q.container "summary (min-width: 400px)", [
                Q.container "(min-width: 800px)", [
                  Q.select ".card", [
                    Q.font size: Units.em 1.5
                  ]
                ]
              ]
            ]
            
            css: """
              @container summary (min-width: 400px) {
                @container (min-width: 800px) {
                  .card {
                    font-size: 1.5em;
                  }
                }
              }
              """
              
        test "bubbling", ->

          verify
          
            quark: Q.sheet [
              Q.select ".widget", [
                Q.padding Units.px 10
                Q.container "(min-width: 600px)", [
                  Q.padding Units.px 20
                ]
              ]
            ] 
          
            css: """
              @container (min-width: 600px) {
                .widget {
                  padding: 20px;
                }
              }
              .widget {
                padding: 10px;
              }              
            """

        test "bubbling with nested rules", ->

          verify 

            quark: Q.sheet [

              Q.select ".navigation.gadget", [

                Q.height "min-content"

                Q.select "& > nav", [
                  Q.display "flex"
                  Q.justify content: "end"
                  Q.gap Units.rem 1
                ]

                Q.select "& > details", [
                  Q.set "cursor", "pointer"
                  Q.text align: "right"
                  Q.select "& > summary", [
                    Q.set "list-style-type", "none"
                    Q.margin bottom: Units.rem 1
                    Q.select "& > *", [
                      Q.display "inline"
                    ]
                  ]
                ]         

                Q.container "( width > 40rem )", [
                  Q.select "& > details", [
                    Q.display "none"
                  ]
                ]
              
                Q.container "( width <= 40rem )", [
                  Q.select "& > nav", [
                    Q.display "none"
                  ]
                ]
              ]
            ]

            css: """
              .navigation.gadget > nav {
                  display: flex;
                  justify-content: end;
                  gap: 1rem;
              }
              .navigation.gadget > details > summary > * {
                  display: inline;
              }
              .navigation.gadget > details > summary {
                  list-style-type: none;
                  margin-bottom: 1rem;
              }
              .navigation.gadget > details {
                  cursor: pointer;
                  text-align: right;
              }
              @container ( width > 40rem ) {
                .navigation.gadget > details {
                    display: none;
                }
              }
              @container ( width <= 40rem ) {
                .navigation.gadget > nav {
                    display: none;
                }
              }
              .navigation.gadget {
                  height: min-content;
              }
            """
        
      ]

      test "@property", ->

        verify
          quark: Q.sheet [
            Q.property "brand-color", [
              Q.set "syntax", Type.text "<color>"
              Q.set "inherits", "false"
              Q.set "initial-value", "#c0ffee"
            ]
          ]
          css: """
            @property --brand-color {
              syntax: "<color>";
              inherits: false;
              initial-value: #c0ffee;
            }
            """

      test "@charset"

      test "@color-profile"

      test "@counter-style"

      test "@font-feature-values"

      test "@font-palette-values"

      test "@page"

      test "@namespace"

    ]
  ]

  process.exit if success then 0 else 1
