import { generic } from "@dashkite/joy/generic"
import * as Type from "@dashkite/joy/type"
import * as It from "@dashkite/joy/iterable"
import { Property, Properties } from "./property"
import { getters, block } from "../helpers"

class Rule

  @initialize: -> properties: Properties.make()

  getters @,
    isEmpty: -> @properties.isEmpty

  append: ( value ) -> append @, value

  render: -> block @selector, [ @properties ]

append = generic name: "append"

generic append,
  ( Type.isKind Rule ),
  ( Type.isType Property ), 
  ( rule, property ) ->
    rule.properties.append property

generic append,
  ( Type.isKind Rule ), 
  ( Type.isType Properties ), 
  ( rule, properties ) ->
    for property in properties.list
      rule.properties.append property 

class Rules
  
  @initialize: -> list: []

  @make: ->
    Object.assign ( new Rules ), Rules.initialize()

  getters @,
    isEmpty: -> @list.length == 0

  append: ( rule ) -> @list.push rule
  
  render: ->
    It.join " ",
      rule.render() for rule in @list when !( rule.isEmpty )

export {
  Rule
  Rules
}