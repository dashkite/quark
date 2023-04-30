import * as Fn from "@dashkite/joy/function"
import { generic } from "@dashkite/joy/generic"
import * as Type from "@dashkite/joy/type"
import * as Meta from "@dashkite/joy/metaclass"
import * as It from "@dashkite/joy/iterable"
import { make } from "../helpers"
import { Rule, Rules } from "./rule"

append = generic name: "append"

class Scope
  
  Meta.mixin @::, [

    Meta.getters
      isEmpty: -> @rules.isEmpty

  ]

  @initialize: -> rules: Rules.make()

  append: ( rule ) -> @rules.append rule

  render: -> @rules.render()

class Scopes

  Meta.mixin @::, [

    Meta.getters
      isEmpty: -> @list.length == 0

  ]

  @initialize: -> list: []

  @make: make @, @initialize

  append: ( scope ) -> @list.push scope

  render: -> It.join " ", ( scope.render() for scope in @list )

export {
  Scope
  Scopes
}