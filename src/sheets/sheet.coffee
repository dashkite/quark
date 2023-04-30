import * as Fn from "@dashkite/joy/function"
import { generic } from "@dashkite/joy/generic"
import * as Type from "@dashkite/joy/type"
import * as It from "@dashkite/joy/iterable"
import { make } from "../helpers"
import { Rules } from "./rule"
import { Style } from "./style"
import { Font } from "./font"
import { Media } from "./media"
import { Keyframes } from "./keyframes"
import { Supports } from "./supports"
import { Layer } from "./layer"

append = generic name: "append"

# used to instantiate an instance
properties =
  fonts: Font.Rules
  media: Media.Scopes
  keyframes: Keyframes.Scopes
  supports: Supports.Scopes
  layers: Layer.Scopes
  styles: Style.Rules

# reverse lookup to get property from type
types = new Map [
  [ Font.Rule, "fonts" ]
  [ Media.Scope, "media" ]
  [ Keyframes.Scope, "keyframes" ]
  [ Supports.Scope, "supports" ]
  [ Layer.Scope, "layers" ]
  [ Style.Rule, "styles" ]
]

class Sheet extends Rules

  @getKey: ( value ) -> types.get value.constructor

  @make: make @, ->
    result = {}
    for key, type of properties
      result[ key ] = type.make()
    result

  @append: ( sheet, value ) -> sheet.append value

  @render: ( sheet ) -> sheet.render()

  append: ( value ) -> 
    @[ @constructor.getKey value ].append value
    
  render: ->
    It.join " ",
      for value in Object.values @ when !( value.isEmpty )
        value.render()


export {
  Sheet
}