import * as Fn from "@dashkite/joy/function"
import * as Type from "@dashkite/joy/type"
import * as Meta from "@dashkite/joy/metaclass"
import { generic } from "@dashkite/joy/generic"
import * as It from "@dashkite/joy/iterable"
import { make, block, merge } from "../helpers"
import { Scope, Scopes } from "./scope"
import { Rule } from "./rule"

# TODO anonymous layers
# TODO nested layers

Layer = {}

class Layer.Scope extends Scope

  # TODO allow for anonymous layers

  append: ( value ) -> @content.push value

  @make: make @, ( name ) -> { name, content: [] }
  
  Meta.mixin @::, [

    Meta.getters
      isEmpty: -> @content.length == 0

  ]

  render: ->
    if @isEmpty
      "@layer #{ @name }"
    else
      block "@layer #{ @name }", @content

class Layer.Scopes extends Scopes

  @make: make @, Scopes.initialize

export {
  Layer
}