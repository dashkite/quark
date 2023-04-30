import * as Type from "@dashkite/joy/type"
import * as It from "@dashkite/joy/iterable"
import { make, block } from "../helpers"
import { Properties } from "./property"
import { Rule, Rules } from "./rule"
import { Font } from "./font"

Style = {}

class Style.Rule extends Rule

  @make: make @, ( selector ) ->
    rule = Rule.initialize()
    { rule..., selector }

class Style.Rules extends Rules

  @make: make @, Rules.initialize

export { Style }