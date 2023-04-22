import * as Fn from "@dashkite/joy/function"
import * as Type from "@dashkite/joy/type"
import * as It from "@dashkite/joy/iterable"
import * as K from "@dashkite/katana/sync"
import { Property, Properties, Rule, Rules, MetaRule } from "./sheets"

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

sheet = ( fx ) ->
  Fn.pipe [
    initialize
    Fn.pipe fx
  ]

select = Fn.curry ( selector, fx ) ->
  Fn.pipe [
    K.push ( parent ) -> Rule.make { selector, parent }
    Fn.pipe fx
    K.read "styles"
    K.mpop Rules.append
  ]

set = Fn.curry (name, value) ->
  K.peek ( rule ) ->
    if Type.isObject value
      for suffix, _value of value
        Properties.append rule.properties,
          Property.make "#{name}-#{suffix}", _value
    else
      Properties.append rule.properties,
        Property.make name, value

render = ( f ) ->

  Fn.pipe [

    f
    clear

    K.read "fonts"
    K.poke ( fonts ) ->
      for { properties } in fonts
        Rule.render Rule.make { selector: "@font-face", properties }
    K.poke join

    K.read "media"
    K.poke ( media ) ->
      for { query, rules } in media
        MetaRule.render MetaRule.make { selector: "@media #{ query }", rules }
    K.poke join

    K.read "supports"
    K.poke ( supports ) ->
      for { query, rules } in supports
        MetaRule.render MetaRule.make { selector: "@supports #{ query }", rules }
    K.poke join

    K.read "keyframes"
    K.poke ( keyframes ) ->
      for { name, steps } in keyframes
        join do ->
          for { selector, properties } in steps
            Rule.render Rule.make { selector, properties }
    K.poke join

    K.read "styles"
    K.poke ( styles ) ->
      for { selector, properties } in styles
        Rule.render Rule.make { selector, properties }
    K.poke join

    stack
    K.poke Fn.pipe [
      It.select ( text ) -> text != ""
      join
    ]
    K.get

  ]

export { 
  select
  set
  sheet
  render
}