import * as Fn from "@dashkite/joy/function"
import { generic } from "@dashkite/joy/generic"
import * as Type from "@dashkite/joy/type"

import {
  Property
  Properties
  Rule
  Selector
  Sheet
  Scope
  Media
  Layer
  Container
  Style
} from "./sheets"

class Node

  @make: ({ parent, value }) -> Object.assign ( new Node ), { parent, value }

  @contains: Fn.curry ( type, { value }) -> 
    Type.isKind type, value

  @attach: ( node ) -> node.attach()

  @get: ({ value }) -> value

  attach: -> attach @parent, @value

attach = generic
  name: "attach"
  default: ( node, value ) -> node.value.append value

# style rules compose selectors, pass the value up the tree
generic attach,
  ( Node.contains Style.Rule ),
  ( Type.isType Style.Rule ),
  ( node, style ) ->
    style.selector = Selector.compose node.value.selector, style.selector
    attach node.parent, style

# generally, scopes pass the value up the tree
generic attach,
  ( Node.contains Scope ),
  ( Type.isKind Scope ),
  ( node, scope ) -> attach node.parent, scope

# for media scope, compose the queries, and pass it up the tree
generic attach,
  ( Node.contains Media.Scope ),
  ( Type.isType Media.Scope ),
  ( node, scope ) ->
    scope.query = Media.Query.compose node.value.query, scope.query
    attach node.parent, scope

# for layer scope, attach to parent, overrides general scope handling
generic attach, 
  ( Node.contains Layer.Scope ),
  ( Type.isType Layer.Scope ), 
  ( node, layer ) -> node.value.append layer

# for container scope, attach to parent, overrides general scope handling
generic attach, 
  ( Node.contains Container.Scope ),
  ( Type.isType Container.Scope ), 
  ( node, layer ) -> node.value.append layer

export { Node }
