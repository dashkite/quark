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

  var: ( name, value ) -> { key: "--#{name}", value }

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

  render: ({ selector, properties }) ->
    """
      #{ selector } {
      #{ Properties.render indent: 2, properties }
      }
    """

Sheet = 

  render: ( sheet ) ->
    sheet
      .map Rule.render
      .join "\n"

export {
  Property
  Properties
  Rule
  Sheet
  Units
}