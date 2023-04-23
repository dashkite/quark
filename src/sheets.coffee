import * as Fn from "@dashkite/joy/function"
import { generic } from "@dashkite/joy/generic"
import * as Type from "@dashkite/joy/type"
import * as It from "@dashkite/joy/iterable"

suffix = ( s ) ->
  ( text ) -> "#{ text }#{ s }"

block = ( identifier, list ) -> 
  "#{ identifier } { #{ list } }"

make = ( type, properties ) ->
  Object.assign ( new type ), properties

hasRules = ( value ) -> value.rules?

append = generic name: "append"

generic append, Type.isArray, Type.isDefined, ( rules, rule ) ->
  rules.push rule if rule.properties.length > 0

generic append, hasRules, Type.isDefined, ({ rules }, rule ) ->
  append rules, rule

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

class Property

  @make: ( key, value ) -> make @, { key, value }

  @set: ( name, value ) -> { key: "--#{ name }", value }

  @get: ( name ) -> "var(--#{ name })"

  @render: ({ key, value }) -> "#{ key }: #{ value };"

class Properties

  @append: ( properties, property ) -> 
    properties.push property

  @render: ( properties ) ->
    It.join " ",
      for property in properties
        Property.render property

class Rule

  @render: ({ selector, properties }) ->
    block selector, Properties.render properties

class Rules

  @append: Fn.binary append

  @render: ( rules ) ->
    It.join " ",
      ( Rule.render rule for rule in rules )

class FontRule extends Rule

  @make: -> make @, { properties: [] }

  @render: ({ properties }) ->
    block "@font-face",
      Properties.render properties

class FontRules

  @append: Rules.append

  @render: ( rules ) ->
    It.join " ",
      ( FontRule.render rule for rule in rules )

class MediaRule extends Rule

  @make: ({ parent, query }) ->
    # TODO if parent is a media query itself, compose the queries
    make @, { query, rules: [] }
    # { query, rules: [] }

  @render: ({ query, rules }) ->
    block "@media #{ query }",
      Rules.render rules

class MediaRules

  @append: ( media, context ) ->
    if context.rules.length > 0
      media.push context
  
  @render: ( rules ) ->
    It.join " ",
      ( MediaRule.render rule for rule in rules )


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

class StyleRule

  @make: ({ selector, parent, properties }) ->
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
    make @, { selector, properties }

  @render: ({ selector, properties }) ->
    block selector,
      Properties.render properties

class StyleRules

  @render: ( rules ) ->
    It.join " ",
      ( StyleRule.render rule for rule in rules )

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
  StyleRules
  Sheet
  Units
  Functions
}