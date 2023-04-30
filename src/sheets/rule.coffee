import * as Fn from "@dashkite/joy/function"
import { generic } from "@dashkite/joy/generic"
import * as Type from "@dashkite/joy/type"
import * as Meta from "@dashkite/joy/metaclass"
import * as It from "@dashkite/joy/iterable"
import { Property, Properties } from "./property"
import { make, block } from "../helpers"

append = generic name: "append"

class Rule

  @initialize: -> properties: Properties.make()

  Meta.mixin @::, [

    Meta.getters
      isEmpty: -> @properties.isEmpty

  ]

  append: ( value ) -> append @, value

  render: -> block @selector, [ @properties ]

class Rules
  
  @initialize: -> list: []

  @make: make @, @initialize

  Meta.mixin @::, [

    Meta.getters
      isEmpty: -> @list.length == 0

  ]

  append: ( rule ) -> @list.push rule unless rule.isEmpty
  
  render: -> It.join " ", ( rule.render() for rule in @list )

generic append, ( Type.isKind Rule ), ( Type.isType Property ), ( rule, property ) ->
  rule.properties.append property

generic append, ( Type.isKind Rule ), ( Type.isType Properties ), ( rule, properties ) ->
  rule.properties.append property for property in properties.list

export {
  Rule
  Rules
}