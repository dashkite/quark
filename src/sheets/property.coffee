import * as Fn from "@dashkite/joy/function"
import { generic } from "@dashkite/joy/generic"
import * as Type from "@dashkite/joy/type"
import * as It from "@dashkite/joy/iterable"
import { getters } from "../helpers"

class Property

  @make: do ({ f } = {}) ->

    f = generic name: "Property.make"

    generic f,
      ( Type.isObject ),
      ({ name, value }) -> 
        Object.assign ( new Property ), { name, value }

    generic f,
      ( Type.isString ),
      ( Type.isDefined ),
      ( name, value ) -> f { name, value }

    f

  @from: ([ name, value ]) -> Property.make { name, value }

  @set: ( name, value ) -> { name: "--#{ name }", value }

  @get: ( name ) -> "var(--#{ name })"

  render: -> "#{ @name }: #{ @value };"

class Properties

  @make: -> Object.assign ( new Properties ), list: []

  # TODO check for whether the nested value is an object
  #      so we can support non-hyphenated properties too
  @from: ( object ) ->
    list = []
    for prefix, values of object 
      for suffix, value of values
        list.push Property.make { name: "#{prefix}-#{suffix}", value }
    Object.assign ( new Properties ), { list }

  getters @,
    isEmpty: -> @list.length == 0

  append: ( property ) -> @list.push property

  render: -> 
    It.join " ", ( property.render() for property in @list )
        
export {
  Property
  Properties
}