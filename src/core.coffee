import * as Fn from "@dashkite/joy/function"
import * as It from "@dashkite/joy/iterable"
import * as K from "@dashkite/katana/sync"
import { Rule, Rules } from "./toolkit"

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
  Fn.tee Fn.pipe [
    initialize
    K.read "styles"
    fx
  ]

select = Fn.curry ( selector, ax ) ->
  Fn.pipe [
    K.push ( parent ) -> Rule.initialize { selector, parent }
    K.read "styles"
    K.mpop Rules.append
  ]

set = Fn.curry (name, value) ->
  K.peek (rule) ->
    switch value.constructor
      when Object
        Object.entries value
        .map ([suffix, value]) ->
          rule.properties.push [ "#{name}-#{suffix}", value]
      else
        rule.properties.push [ name, value ]

render = ( f ) ->

  Fn.pipe [

    f
    K.clear

    K.read "fonts"
    K.poke ( fonts ) ->
      It.join "\n", 
        for { properties } in fonts
          Rule.render MetaRule.make "@font-face", properties

    K.read "media"
    K.poke ( media ) ->
      It.join "\n",
        for { query, rules } in fonts
          Rule.render MetaRule.make "@media #{ query }", styles

    K.read "supports"
    K.poke ( supports ) ->
      It.join "\n", 
        for { query, rules } in supports
          Rule.render MetaRule.make "@supports #{ query }", styles

    K.read "keyframes"
    K.poke ( keyframes ) ->
      It.join "\n", 
        for { name, steps } in keyframes
          It.join "\n", 
            for { name, properties } in steps
              Rule.render Rule.make name, properties

    K.read "styles"
    K.poke ( styles ) ->
      It.join "\n", 
        for { selector, properties } in styles
          Rule.render Rule.make name, properties

    K.stack
    K.poke It.join "\n"
    K.get

  ]

export { 
  select
  set
  sheet
  render
}