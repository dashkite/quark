import * as Fn from "@dashkite/joy/function"
import * as Meta from "@dashkite/joy/metaclass"
import { Rule, Rules } from "./rule"

Style = {}

class Style.Rule extends Rule

  @make: ( selector ) ->
    Object.assign ( new Style.Rule ),
      Rule.initialize(),
      { selector }

class Style.Rules extends Rules

  @make: ->
    Object.assign ( new Style.Rules ),
      Rules.initialize()

export { Style }