import { getters, block } from "../helpers"
import { Scope, Scopes } from "./scope"

# TODO anonymous layers
# TODO nested layers

Layer = {}

class Layer.Scope extends Scope

  @make: ( name ) ->
    Object.assign ( new Layer.Scope ), { name, content: [] }

  # Layers can be empty, so effectively they're never empty
  getters @,
    isEmpty: -> false

  append: ( value ) -> @content.push value

  render: ->
    if @isEmpty
      "@layer #{ @name }"
    else
      block "@layer #{ @name }", @content

class Layer.Scopes extends Scopes

  @make: -> Object.assign ( new Layer.Scopes ), Scopes.initialize()

export {
  Layer
}