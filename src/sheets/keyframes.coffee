import * as Type from "@dashkite/joy/type"
import * as It from "@dashkite/joy/iterable"
import { make, block, merge } from "../helpers"
import { Scope, Scopes } from "./scope"
import { Rules } from "./rule"

Keyframes = {}

class Keyframes.Scope extends Scope

  @isType: Type.isType @

  @make: make @, ( name ) ->
    scope = Scope.initialize()
    { scope..., name }
  
  @render: ({ name, rules }) ->
    block "@keyframes #{ name }", Rules.render rules

class Keyframes.Scopes extends Scopes

  @make: make @, Scopes.initialize

  @render: ( scopes ) ->
    It.join " ",
      ( Keyframes.Scope.render scope for scope in scopes.list )

export {
  Keyframes
}