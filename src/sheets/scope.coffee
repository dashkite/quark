import * as Fn from "@dashkite/joy/function"
import { generic } from "@dashkite/joy/generic"
import * as Type from "@dashkite/joy/type"
import * as It from "@dashkite/joy/iterable"
import { make } from "../helpers"
import { Rule, Rules } from "./rule"

append = generic name: "append"

class Scope
  
  @isKind: Type.isKind @

  @isEmpty: ( scope ) -> Rules.isEmpty scope.rules

  @initialize: -> rules: Rules.make()

  @append: Fn.curry Fn.binary append

  @render: ( scope ) -> Rules.render scope.rules

class Scopes

  @isKind: Type.isKind @

  @isEmpty: ( scope ) -> scope.list.length == 0

  @initialize: -> list: []

  @make: make @, @initialize

  @append: Fn.curry Fn.binary append

  @render: ( scopes ) ->
    It.join " ",
      ( Scope.render scope for scope in scopes.list )

generic append, Scope.isKind, Rule.isKind, ( scope, rule ) ->
  Rules.append scope.rules, rule

generic append, Scopes.isKind, Scope.isKind, ( scopes, scope ) ->
  scopes.list.push scope unless scope.constructor.isEmpty scope

export {
  Scope
  Scopes
}