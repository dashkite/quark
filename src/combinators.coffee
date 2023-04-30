import * as Fn from "@dashkite/joy/function"
import { generic } from "@dashkite/joy/generic"
import * as Type from "@dashkite/joy/type"
import * as Obj from "@dashkite/joy/object"
import * as It from "@dashkite/joy/iterable"
import * as K from "@dashkite/katana/sync"

import {
  Property
  Properties
  Style
  Sheet
  Font
  Media
  Keyframes
  Supports
  Layer
} from "./sheets"

import { Node } from "./node"

import { log } from "./helpers"

_set = generic name: "set"

generic _set,
  Type.isString, 
  Type.isDefined,
  ( name, value ) ->
    Fn.pipe [
      K.push Fn.wrap [ name, value ]
      K.poke Property.from
      K.poke ( value, parent ) -> { value, parent }
      K.poke Node.make
      K.pop Node.attach
    ]

generic _set,
  Type.isString,
  Type.isObject,
  ( name, value ) ->
    Fn.pipe [
      K.push Fn.wrap [ name ]: value
      K.poke Properties.from
      K.poke ( value, parent ) -> { value, parent }
      K.poke Node.make
      K.pop Node.attach
    ]

set = Fn.curry Fn.binary _set

select = Fn.curry ( selector, fx ) ->
  Fn.pipe [
    K.push Fn.wrap selector
    K.poke Style.Rule.make
    K.poke ( value, parent ) -> { value, parent }
    K.poke Node.make
    Fn.pipe fx
    K.pop Node.attach
  ]

initialize = -> [ Node.make value: Sheet.make() ]

sheet = ( fx ) ->
  Fn.pipe [
    initialize
    K.write "sheet"
    Fn.pipe fx
  ]

render = ( f ) ->

  Fn.pipe [

    f    
    K.read "sheet"
    K.poke Node.get
    K.poke Sheet.render
    K.get

  ]

fonts = Fn.curry ( fx ) ->
  Fn.pipe [
    K.push Font.Rule.make
    K.poke ( value, parent ) -> { value, parent }
    K.poke Node.make
    Fn.pipe fx
    K.pop Node.attach
  ]

media = Fn.curry ( query, fx ) ->
  Fn.pipe [
    K.push Fn.wrap query
    K.poke Media.Scope.make
    K.poke ( value, parent ) -> { value, parent }
    K.poke Node.make 
    Fn.pipe fx
    K.pop Node.attach
  ]

# TODO customize for Keyframe rules?
keyframe = select

keyframes = Fn.curry ( name, fx ) ->
  Fn.pipe [
    K.push Fn.wrap name
    K.poke Keyframes.Scope.make
    K.poke ( value, parent ) -> { value, parent }
    K.poke Node.make 
    Fn.pipe fx
    K.pop Node.attach
  ]

supports = Fn.curry ( query, fx ) ->
  Fn.pipe [
    K.push Fn.wrap query
    K.poke Supports.Scope.make
    K.poke ( value, parent ) -> { value, parent }
    K.poke Node.make 
    Fn.pipe fx
    K.pop Node.attach
  ]

layer = Fn.curry ( query, fx ) ->
  Fn.pipe [
    K.push Fn.wrap query
    K.poke Layer.Scope.make
    K.poke ( value, parent ) -> { value, parent }
    K.poke Node.make 
    Fn.pipe fx
    K.pop Node.attach
  ]

export { 
  sheet
  set
  select
  render
  fonts
  media
  keyframe
  keyframes
  supports
  layer
}