suffix = ( s ) ->
  ( text ) -> "#{ text }#{ s }"

Units =

  du: ( n ) -> Units.px n * 320

  vu: ( n ) -> Units.px n * 192

  ch: suffix "ch"

  px: suffix "px"

  rem: suffix "rem"

  pct: suffix "%"

  qrem: ( n ) -> Units.rem n/4

  hrem: ( n ) -> Units.rem n/2

Property =

  make: ( key, value ) -> { key, value }

  set: ( name, value ) -> { key: "--#{ name }", value }

  get: ( name ) -> "var(--#{ name })"

  render: ({ indent }) ->
    indent = ' '.repeat indent
    ({ key, value }) -> "#{ indent }#{ key }: #{ value };"

Properties =

  empty: -> []

  make: ( dictionary ) ->
    for key, value of dictionary
      Property.make key, value

  render: ({ indent }, properties ) ->
    properties
      .map Property.render { indent }
      .join "\n"

Rule =

  make: ( selector, properties ) ->
    { selector, properties }

  initialize: ({ selector, parent }) ->
    parent ?= ""
    parent
      .split /,\s*/
      .map (parent) ->
        if selector.includes "&"
          selector.replace /\&/g, -> parent
        else if parent == ""
          selector
        else
          "#{ parent } #{ selector }"
      .join ", "


  render: ({ selector, properties }) ->
    """
      #{ selector } {
      #{ Properties.render indent: 2, properties }
      }
    """

Rules =

  append: ( rules, rule ) ->
    if rule.properties.length > 0
      rules.push rule

Sheet = 

  render: ( sheet ) ->
    sheet
      .map Rule.render
      .join "\n"

export {
  Property
  Properties
  Rule
  Rules
  Sheet
  Units
}