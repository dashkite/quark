import * as Type from "@dashkite/joy/type"
import * as It from "@dashkite/joy/iterable"
import { make, block } from "../helpers"
import { Properties } from "./property"
import { Rule, Rules } from "./rule"

Font = {}

class Font.Rule extends Rule

  @isType: Type.isType @

  @make: make @, Rule.initialize

  @render: ({ properties }) ->
    block "@font-face",
      Properties.render properties

class Font.Rules extends Rules

  @make: make @, Rules.initialize

  @render: ( rules ) ->
    It.join " ",
      ( Font.Rule.render rule for rule in rules.list )

export {
  Font
}