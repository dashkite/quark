import * as Fn from "@dashkite/joy/function"
import { generic } from "@dashkite/joy/generic"
import * as Type from "@dashkite/joy/type"
import * as It from "@dashkite/joy/iterable"
import { Property, Properties } from "./property"
import { make } from "../helpers"

block = ( identifier, list ) -> 
  "#{ identifier } { #{ list } }"

append = generic name: "append"

class Rule

  @isKind: Type.isKind @

  @isEmpty: ( rule ) -> Properties.isEmpty rule.properties

  @initialize: -> properties: Properties.make()

  @append: Fn.curry Fn.binary append

  @render: ({ selector, properties }) ->
    block selector, Properties.render properties

class Rules
  
  @isKind: Type.isKind @

  @isEmpty: ( rules ) -> rules.list.length == 0

  @initialize: -> list: []

  @make: make @, @initialize

  @append: Fn.curry Fn.binary append
  
  @render: ( rules ) ->
    It.join " ",
      ( Rule.render rule for rule in rules.list )

generic append, Rule.isKind, Property.isType, ( rule, property ) ->
  Properties.append rule.properties, property

generic append, Rule.isKind, Properties.isType, ( rule, properties ) ->
  append rule, property for property in properties.list

generic append, Rules.isKind, Rule.isKind, ( rules, rule ) ->
  rules.list.push rule unless Rule.isEmpty rule

export {
  Rule
  Rules
}