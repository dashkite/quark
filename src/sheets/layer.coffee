import * as Fn from "@dashkite/joy/function"
import * as Type from "@dashkite/joy/type"
import { generic } from "@dashkite/joy/generic"
import * as It from "@dashkite/joy/iterable"
import { make, block, merge } from "../helpers"
import { Scope, Scopes } from "./scope"
import { Rules } from "./rule"

# TODO anonymous layers
# TODO nested layers

append = generic
  name: "append"
  default: Scope.append

Layer = {}

class Layer.Scope extends Scope

  @isType: Type.isType @

  @isEmpty: ({ rules, layers }) ->
    ( Rules.isEmpty rules ) && ( Layer.Scopes.isEmpty layers )

  # TODO allow for anonymous layers

  @append: Fn.curry Fn.binary append

  @make: make @, ( name ) ->
    scope = Scope.initialize()
    { scope..., name, layers: Layer.Scopes.make() }
  
  @render: ( layer ) ->
    { name, rules, layers } = layer
    if Layer.Scope.isEmpty layer
      "@layer #{ name }"
    else
      block "@layer #{ name }", 
        ( Layer.Scopes.render layers ) + 
          ( Rules.render rules )

class Layer.Scopes extends Scopes

  @make: make @, Scopes.initialize

  @render: ( scopes ) ->
    It.join " ",
      ( Layer.Scope.render scope for scope in scopes.list )

generic append, Layer.Scope.isType, Layer.Scope.isType, ( parent, child ) ->
  Layer.Scopes.append parent.layers, child

export {
  Layer
}