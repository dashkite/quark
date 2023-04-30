import * as Type from "@dashkite/joy/type"
import * as It from "@dashkite/joy/iterable"
import { make, block, merge } from "../helpers"
import { Scope, Scopes } from "./scope"
import { Rules } from "./rule"

Keyframes = {}

class Keyframes.Scope extends Scope

  @make: make @, ( name ) ->
    scope = Scope.initialize()
    { scope..., name }
  
  render: ->
    block "@keyframes #{ @name }", [ @rules ]

class Keyframes.Scopes extends Scopes

  @make: make @, Scopes.initialize

export {
  Keyframes
}