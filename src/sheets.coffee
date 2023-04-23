import * as Fn from "@dashkite/joy/function"
import { generic } from "@dashkite/joy/generic"
import * as Type from "@dashkite/joy/type"
import * as It from "@dashkite/joy/iterable"

suffix = ( s ) ->
  ( text ) -> "#{ text }#{ s }"

block = ( identifier, list ) -> 
  "#{ identifier } { #{ list } }"

Units =

  du: ( n ) -> Units.px n * 320

  vu: ( n ) -> Units.px n * 192

  ch: suffix "ch"

  px: suffix "px"

  rem: suffix "rem"

  em: suffix "em"

  pct: suffix "%"

  qrem: ( n ) -> Units.rem n/4

  hrem: ( n ) -> Units.rem n/2

  vw: suffix "vw"

  vh: suffix "vh"

  deg: suffix "deg"

Functions =

  url: ( text ) ->
    """
      url("#{ text }")
    """

Property =

  make: ( key, value ) -> { key, value }

  set: ( name, value ) -> { key: "--#{ name }", value }

  get: ( name ) -> "var(--#{ name })"

  render: ({ key, value }) -> "#{ key }: #{ value };"

Properties =

  append: ( properties, property ) -> 
    properties.push property

  render: ( properties ) ->
    It.join " ",
      for property in properties
        Property.render property

Rule =

  render: ({ selector, properties }) ->
    block selector, Properties.render properties

Rules =

  append: do ->
    _append = generic name: "append"
    generic _append, Type.isArray, Type.isObject, ( rules, rule ) ->
      rules.push rule if rule.properties.length > 0
    generic _append, Type.isObject, Type.isObject, ( { rules }, rule ) ->
      _append rules, rule
    Fn.binary _append

  render: ( rules ) -> Rule.render rule for rule in rules    

FontRule =

  make: -> { properties: [] }

  render: ({ properties }) ->
    block "@font-face",
      Properties.render properties

FontRules =

  append: Rules.append

MediaRule =

  make: ({ parent, query }) ->
    # TODO if parent is a media query itself, compose the queries
    { query, rules: [] }

  render: ({ query, rules }) ->
    block "@media #{ query }",
      Rules.render rules

MediaRules =

  append: ( media, context ) ->
    if context.rules.length > 0
      media.push context

# SupportsRule =

#   make: ({ parent, query }) ->

#   render:

# SupportsRules =

#   append:

# KeyFramesRule =

#   make: ({ parent, name }) ->

#   render:

# KeyFramesRules =

#   append:

StyleRule =

  make: ({ selector, parent, properties }) ->
    properties ?= []
    if parent?.selector?
      parents = parent.selector.split /,\s*/
      selector = It.join ", ",
        if selector.includes "&"
          for parent in parents
            selector.replace /\&/g, -> parent
        else
          for parent in parents
            "#{ parent } #{ selector }"
    { selector, properties }

  render: ({ selector, properties }) ->
    "#{ selector } { #{ Properties.render properties } }"


Sheet = 

  render: ( sheet ) ->
    sheet
      .map Rule.render
      .join " "

export {
  Property
  Properties
  Rules
  FontRule
  FontRules
  MediaRule
  MediaRules
  StyleRule
  Sheet
  Units
  Functions
}