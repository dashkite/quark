import * as Type from "@dashkite/joy/type"
import * as It from "@dashkite/joy/iterable"
import { make, block, merge } from "../helpers"
import { Scope, Scopes } from "./scope"
import { Rules } from "./rule"

Supports = {}

class Supports.Scope extends Scope

  @isType: Type.isType @

  @make: make @, ( query ) ->
    scope = Scope.initialize()
    { scope..., query }
  
  @render: ({ query, rules }) ->
    block "@supports #{ query }", Rules.render rules

class Supports.Scopes extends Scopes

  @make: make @, Scopes.initialize

  @render: ( scopes ) ->
    It.join " ",
      ( Supports.Scope.render scope for scope in scopes.list )

class Supports.Query

  # for now we don't compose
  @compose: ( parent, child ) -> child

export {
  Supports
}