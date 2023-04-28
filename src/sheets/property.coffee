import * as Type from "@dashkite/joy/type"
import * as It from "@dashkite/joy/iterable"
import { make } from "../helpers"

class Property

  @isType: Type.isType @

  @make: make @, ( key, value ) -> { key, value }

  @set: ( name, value ) -> { key: "--#{ name }", value }

  @get: ( name ) -> "var(--#{ name })"

  @render: ({ key, value }) -> "#{ key }: #{ value };"

class Properties

  @isType: Type.isType @

  @isEmpty: ( properties ) -> properties.list.length == 0

  @make: make @, -> list: []
  
  @from: make @, ( prefix, values ) -> 
    list: 
      for suffix, value of values
        Property.make "#{prefix}-#{suffix}", value

  @append: ( properties, property ) -> 
    properties.list.push property

  @render: ( properties ) ->
    It.join " ",
      for property in properties.list
        Property.render property

export {
  Property
  Properties
}