import * as Type from "@dashkite/joy/type"
import * as It from "@dashkite/joy/iterable"
import { make, block } from "../helpers"
import { Properties } from "./property"
import { Rule, Rules } from "./rule"

Font = {}

class Font.Rule extends Rule

  @make: make @, Rule.initialize

  render: -> block "@font-face", [ @properties ]

class Font.Rules extends Rules

  @make: make @, Rules.initialize

export {
  Font
}