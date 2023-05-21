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

# generally, rules pass the value up the tree
generic attach,
    ( Node.contains Rule ),
    ( Type.isKind Scope ),
    ( node, scope ) -> attach node.parent, scope

# scopes do the same
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
  ( node, container ) -> node.value.append container


# bubbling for media rules
generic attach, 
  ( Node.contains Style.Rule ),
  ( Type.isType Media.Scope ),
  ( node, media ) ->
    Replacement =
      # 1. create a new (empty) rule based on the parent's selector
      rule: Style.Rule.make node.value.selector
      # 2. create a new (empty) replacement container query 
      #    based on the container's query
      scope: Media.Scope.make media.query
    # 3. create a replacement Node to wrap the rule
    #    this is a peer node to the given rule so it has 
    #    the same parent
    Replacement.node = Node.make
      parent: node.parent
      value: Replacement.rule
    # 4. attach the container content to the replacement node
    console.log { media }
    ( attach Replacement.node, item ) for item in media.rules.list
    # 4. append the new rule to the replacement container
    #    this is the only content for the replacement container
    Replacement.scope.append Replacement.rule
    # 5. attach the replacement to the next node up in the tree
    attach node.parent, Replacement.scope


# bubbling for container rules
generic attach, 
  ( Node.contains Style.Rule ),
  ( Type.isType Container.Scope ),
  ( node, container ) ->
    Replacement =
      # 1. create a new (empty) rule based on the parent's selector
      rule: Style.Rule.make node.value.selector
      # 2. create a new (empty) replacement container query 
      #    based on the container's query
      scope: Container.Scope.make container.query
    # 3. create a replacement Node to wrap the rule
    #    this is a peer node to the given rule so it has 
    #    the same parent
    Replacement.node = Node.make
      parent: node.parent
      value: Replacement.rule
    # 4. attach the container content to the replacement node
    ( attach Replacement.node, item ) for item in container.content
    # 4. append the new rule to the replacement container
    #    this is the only content for the replacement container
    Replacement.scope.append Replacement.rule
    # 5. attach the replacement to the next node up in the tree
    attach node.parent, Replacement.scope





      
export { Node }
