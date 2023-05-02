import * as Type from "@dashkite/joy/type"
import * as It from "@dashkite/joy/iterable"
import { block } from "../helpers"
import { Properties } from "./property"
import { Rule, Rules } from "./rule"

CustomProperty = {}

class CustomProperty.Rule extends Rule
  
  @make: ( name ) -> 
    Object.assign ( new CustomProperty.Rule ), 
      Rule.initialize(),
      { name }

  render: -> block "@property --#{ @name }", [ @properties ]

class CustomProperty.Rules extends Rules

  @make: -> Object.assign ( new CustomProperty.Rules ), Rules.initialize()

export {
  CustomProperty
}