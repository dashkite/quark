import { make, block } from "../helpers"
import { Scope, Scopes } from "./scope"

Supports = {}

class Supports.Scope extends Scope

  @make: ( query ) ->
    Object.assign ( new Supports.Scope ),
      Scope.initialize(),
      { query }
  
  render: -> block "@supports #{ @query }", [ @rules ]

class Supports.Scopes extends Scopes

  @make: ->
    Object.assign ( new Supports.Scopes ),
      Scopes.initialize()

class Supports.Query

  # for now we don't compose
  @compose: ( parent, child ) -> child

export {
  Supports
}