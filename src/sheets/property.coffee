import * as Type from "@dashkite/joy/type"
import * as It from "@dashkite/joy/iterable"
import * as Meta from "@dashkite/joy/metaclass"
import { make } from "../helpers"

class Property

  @make: make @, ( key, value ) -> { key, value }

  @set: ( name, value ) -> { key: "--#{ name }", value }

  @get: ( name ) -> "var(--#{ name })"

  render: -> "#{ @key }: #{ @value };"

class Properties

  @isType: Type.isType @

  @make: make @, -> list: []
  
  @from: make @, ( prefix, values ) -> 
    list: 
      for suffix, value of values
        Property.make "#{prefix}-#{suffix}", value

  Meta.mixin @::, [

    Meta.getters
      isEmpty: -> @list.length == 0

  ]

  append: ( property ) -> @list.push property

  render: -> 
    It.join " ", ( property.render() for property in @list )
        
export {
  Property
  Properties
}