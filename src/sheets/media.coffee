import * as Type from "@dashkite/joy/type"
import * as It from "@dashkite/joy/iterable"
import { make, block } from "../helpers"
import { Scope, Scopes } from "./scope"
import { Rules } from "./rule"

Media = {}
class Media.Scope extends Scope

  @isType: Type.isType @

  @make: make @, ( query ) -> { query, rules: Rules.make() }

  @render: ({ query, rules }) ->
    block "@media #{ query }", Rules.render rules

class Media.Scopes extends Scopes

  @make: make @, Scopes.initialize

  @render: ( scopes ) ->
    It.join " ",
      ( Media.Scope.render scope for scope in scopes.list )

export {
  Media
}