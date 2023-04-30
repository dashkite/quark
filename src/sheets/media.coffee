import * as Type from "@dashkite/joy/type"
import * as It from "@dashkite/joy/iterable"
import { block } from "../helpers"
import { Scope, Scopes } from "./scope"
import { Rules } from "./rule"

Media = {}

class Media.Scope extends Scope

  @make: ( query ) ->
    Object.assign ( new Media.Scope ),
      Scope.initialize(),
      { query }
  
  render: -> block "@media #{ @query }", [ @rules ]

class Media.Scopes extends Scopes

  @make: -> Object.assign ( new Media.Scopes ), Scopes.initialize()

class Media.Query

  # for now we don't compose
  @compose: ( parent, child ) -> child

export {
  Media
}