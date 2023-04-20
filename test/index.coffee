import assert from "@dashkite/assert"
import {test, success} from "@dashkite/amen"
import print from "@dashkite/amen-console"

# MUT
import {
  Property
  Properties
  Rule
} from "../src/"

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


  ]

  process.exit if success then 0 else 1
