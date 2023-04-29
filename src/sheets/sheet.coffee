import * as Fn from "@dashkite/joy/function"
import { generic } from "@dashkite/joy/generic"
import * as Type from "@dashkite/joy/type"
import * as It from "@dashkite/joy/iterable"
import { make, isNotEmpty } from "../helpers"
import { Rules } from "./rule"
import { Style } from "./style"
import { Font } from "./font"
import { Media } from "./media"
import { Keyframes } from "./keyframes"
import { Supports } from "./supports"
import { Layer } from "./layer"

append = generic name: "append"

class Sheet extends Rules

  @isType: Type.isType @

  @make: make @, ->
    # imports: []
    # namespaces: []
    fonts: Font.Rules.make()
    media: Media.Scopes.make()
    keyframes: Keyframes.Scopes.make()
    supports: Supports.Scopes.make()
    layers: Layer.Scopes.make()
    styles: Style.Rules.make()
  # page: []

  @append: Fn.curry Fn.binary append
    
  @render: ( sheet ) -> 
    It.join " ",
      It.select isNotEmpty,
        for value in Object.values sheet
          value.constructor.render value

generic append, Sheet.isType, Style.Rule.isType, ( sheet, rule ) ->
  Style.Rules.append sheet.styles, rule

generic append, Sheet.isType, Font.Rule.isType, ( sheet, rule ) ->
  Font.Rules.append sheet.fonts, rule

generic append, Sheet.isType, Media.Scope.isType, ( sheet, scope ) ->
  Media.Scopes.append sheet.media, scope

generic append, Sheet.isType, Keyframes.Scope.isType, ( sheet, keyframes ) ->
  Keyframes.Scopes.append sheet.keyframes, keyframes

generic append, Sheet.isType, Supports.Scope.isType, ( sheet, supports ) ->
  Supports.Scopes.append sheet.supports, supports

generic append, Sheet.isType, Layer.Scope.isType, ( sheet, layer ) ->
  Layer.Scopes.append sheet.layers, layer

export {
  Sheet
}