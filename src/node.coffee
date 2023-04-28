import * as Fn from "@dashkite/joy/function"
import { generic } from "@dashkite/joy/generic"
import * as Type from "@dashkite/joy/type"
import { make } from "./helpers"

import {
  Property
  Properties
  Rule
  Scope
  Media
  Style
  Sheet
  Selector
} from "./sheets"

class Node

  @make: make @, ({ parent, value }) -> { parent, value }

  @contains: Fn.curry ( type, { value }) -> 
    Type.isKind type, value

  @attach: ( node ) ->
    attach node.parent, node.value

  @get: ({ value }) -> value

attach = generic name: "attach"

# add a value to a sheet
generic attach, ( Node.contains Sheet ), Type.isDefined, ( node, value ) ->
  Sheet.append node.value, value

# add property to rule
generic attach, ( Node.contains Rule ), Property.isType, ( node, property ) ->
  Rule.append node.value, property

# add properties to rule
generic attach, ( Node.contains Rule ), Properties.isType, ( node, properties ) ->
  Rule.append node.value, properties

# style rules compose selectors, pass the value up the tree
generic attach, ( Node.contains Style.Rule ), Style.Rule.isType, ( node, style ) ->
  style.selector = Selector.compose node.value.selector, style.selector
  attach node.parent, style

# add rule to scope
generic attach, ( Node.contains Scope ), Rule.isKind, ( node, rule ) ->
  Scope.append node.value, rule

# generally, scopes pass the value up the tree
generic attach, ( Node.contains Scope ), Scope.isKind, ( node, scope ) ->
  attach node.parent, scope

# for media scope, compose the queries, and pass it up the tree
generic attach, ( Node.contains Media.Scope ), Media.Scope.isType, ( node, scope ) ->
  scope.query = Media.Query.compose node.value.query, scope.query
  attach node.parent, scope

export { Node }
