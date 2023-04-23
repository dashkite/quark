import * as Fn from "@dashkite/joy/function"
import * as Type from "@dashkite/joy/type"
import * as It from "@dashkite/joy/iterable"
import * as K from "@dashkite/katana/sync"
import {
  Property
  Properties
  Rules
  FontRule
  FontRules
  MediaRule
  MediaRules
  SupportsRule
  SupportsRules
  KeyFramesRule
  KeyFramesRules
  StyleRule
} from "./sheets"

join = It.join " "

# TODO this should be in Katana
clear = Fn.tee ( daisho ) -> daisho.stack = []

# TODO this *is* in Katana but doesn't copy the stack
#      so it ends up including itself :/
stack = Fn.tee ( daisho ) -> daisho.stack.unshift structuredClone daisho.stack

log = ( label ) ->
  Fn.tee ( daisho ) ->
    console.log label, daisho.stack

initialize = ->
  imports: []
  namespaces: []
  fonts: []
  media: []
  supports: []
  keyframes: []
  styles: []
  page: []

set = Fn.curry (name, value) ->
  K.peek ( rule ) ->
    if Type.isObject value
      for suffix, _value of value
        Properties.append rule.properties,
          Property.make "#{name}-#{suffix}", _value
    else
      Properties.append rule.properties,
        Property.make name, value

fonts = Fn.curry ( fx ) ->
  Fn.pipe [
    K.push ( parent ) -> FontRule.make parent
    Fn.pipe fx
    K.read "fonts"
    K.mpop FontRules.append
  ]

media = Fn.curry ( query, fx ) ->
  Fn.pipe [
    # 'save' styles for later
    K.read "styles"
    K.push ( parent ) -> MediaRule.make { parent, query }
    # save the media query as the current selector context
    K.write "context"
    Fn.pipe fx
    K.read "media"
    K.mpop MediaRules.append
    # restore styles as the context
    K.write "context"
  ]
# 
# supports = Fn.curry ( query, fx ) ->
#   Fn.pipe [
#     K.push ( parent ) -> SupportsRule.make { parent, query }
#     Fn.pipe fx
#     K.read "styles"
#     K.mpop SupportsRule.append
#   ]

# keyframes = Fn.curry ( name, fx ) ->
#   Fn.pipe [
#     K.push ( parent ) -> KeyFramesRule.make { parent, name }
#     Fn.pipe fx
#     K.read "styles"
#     K.mpop KeyFramesRule.append
#   ]

select = Fn.curry ( selector, fx ) ->
  Fn.pipe [
    K.push ( parent ) -> StyleRule.make { selector, parent }
    Fn.pipe fx
    K.read "context"
    K.mpop Rules.append
  ]

sheet = ( fx ) ->
  Fn.pipe [
    initialize
    K.read "styles"
    K.write "context"
    Fn.pipe fx
  ]

render = ( f ) ->

  Fn.pipe [

    f
    clear

    K.read "fonts"
    K.poke ( rules ) ->
      for rule in rules
        FontRule.render rule
    K.poke join

    K.read "media"
    K.poke ( rules ) ->
      for rule in rules
        MediaRule.render rule
    K.poke join

    # K.read "supports"
    # K.poke ( rules ) ->
    #   for rule in rules
    #     SupportsRule.render rule
    # K.poke join

    # K.read "keyframes"
    # K.poke ( rules ) ->
    #   for rule in rules
    #     KeyFramesRule.render rule
    # K.poke join

    K.read "styles"
    K.poke ( rules ) ->
      for rule in rules
        StyleRule.render rule 
    K.poke join

    stack
    K.poke Fn.pipe [
      It.select ( text ) -> text != ""
      join
    ]
    K.get

  ]

export { 
  sheet
  set
  fonts
  media
  select
  render
}