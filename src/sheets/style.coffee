import * as Type from "@dashkite/joy/type"
import * as It from "@dashkite/joy/iterable"
import { make, block } from "../helpers"
import { Properties } from "./property"
import { Rule, Rules } from "./rule"
import { Font } from "./font"

Style = {}

class Style.Rule extends Rule

  @isType: Type.isType @

  @make: make @, ( selector ) ->
    { selector, properties: Properties.make() }

  @render: ({ selector, properties }) ->
    block selector,
      Properties.render properties

class Style.Rules extends Rules

  @make: make @, Rules.initialize

  @render: ( rules ) ->
    It.join " ",
      ( Style.Rule.render rule for rule in rules.list )

export { Style }