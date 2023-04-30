import * as Fn from "@dashkite/joy/function"
import * as Type from "@dashkite/joy/type"
import * as It from "@dashkite/joy/iterable"
import { block } from "../helpers"
import { Scope, Scopes } from "./scope"
import { Rules } from "./rule"

Keyframes = {}

class Keyframes.Scope extends Scope

  @make: ( name ) ->
    Object.assign ( new Keyframes.Scope ),
      Scope.initialize()
      { name }
  
  render: ->
    block "@keyframes #{ @name }", [ @rules ]

class Keyframes.Scopes extends Scopes

  @make: -> Object.assign ( new Keyframes.Scopes ), Scopes.initialize()


export {
  Keyframes
}