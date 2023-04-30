import * as Type from "@dashkite/joy/type"
import * as It from "@dashkite/joy/iterable"
import { block } from "../helpers"
import { Properties } from "./property"
import { Rule, Rules } from "./rule"

Font = {}

class Font.Rule extends Rule
  
  @make: -> Object.assign ( new Font.Rule ), Rule.initialize()

  render: -> block "@font-face", [ @properties ]

class Font.Rules extends Rules

  @make: -> Object.assign ( new Font.Rules ), Rules.initialize()

export {
  Font
}