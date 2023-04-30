import * as It from "@dashkite/joy/iterable"
import { getters } from "../helpers"
import { Rules } from "./rule"

class Scope
  
  @initialize: -> rules: Rules.make()

  getters @,
    isEmpty: -> @rules.isEmpty

  append: ( rule ) -> @rules.append rule

  render: -> @rules.render()

class Scopes

  @initialize: -> list: []

  @make: -> Object.assign ( new Scopes ), @initialize()

  getters @,
    isEmpty: -> @list.length == 0

  append: ( scope ) -> @list.push scope

  render: -> It.join " ", ( scope.render() for scope in @list )

export {
  Scope
  Scopes
}