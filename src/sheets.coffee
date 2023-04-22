import * as It from "@dashkite/joy/iterable"

suffix = ( s ) ->
  ( text ) -> "#{ text }#{ s }"

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

Property =

  make: ( key, value ) -> { key, value }

  set: ( name, value ) -> { key: "--#{ name }", value }

  get: ( name ) -> "var(--#{ name })"

  render: ({ key, value }) -> "#{ key }: #{ value };"

Properties =

  empty: -> []

  make: ( dictionary ) ->
    for key, value of dictionary
      Property.make key, value

  append: ( properties, property ) -> 
    properties.push property

  render: ( properties ) ->
    It.join " ",
      for property in properties
        Property.render property

Rule =

  make: ({ selector, parent, properties }) ->
    properties ?= []
    if parent?
      parents = parent.split /,\s*/
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

MetaRule =

  make: ({ selector, rules }) ->
    { selector, rules }

  render: ({ selector, rules }) ->
    "#{ selector } { #{ Rules.render rules } }"



Rules =

  append: ( rules, rule ) ->
    if rule.properties.length > 0
      rules.push rule

Sheet = 

  render: ( sheet ) ->
    sheet
      .map Rule.render
      .join " "

export {
  Property
  Properties
  Rule
  Rules
  MetaRule
  Sheet
  Units
}