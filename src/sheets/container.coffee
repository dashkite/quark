import { getters, block } from "../helpers"
import { Scope, Scopes } from "./scope"

# TODO anonymous layers
# TODO nested layers

Container = {}

class Container.Scope extends Scope

  @make: ( query ) ->
    Object.assign ( new Container.Scope ), { query, content: [] }

  getters @,
    isEmpty: -> @content.length == 0

  append: ( value ) -> @content.push value

  render: ->
    block "@container #{ @query }", @content

class Container.Scopes extends Scopes

  @make: -> Object.assign ( new Container.Scopes ), Scopes.initialize()

export {
  Container
}