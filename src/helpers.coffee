import * as Fn from "@dashkite/joy/function"
import * as It from "@dashkite/joy/iterable"

make = ( type, initializer ) ->
  Fn.curry Fn.arity initializer.length,
    ( args... ) -> Object.assign ( new type ), initializer args...

block = ( identifier, list ) ->
  content = It.join " ", ( item.render() for item in list )
  "#{ identifier } { #{ content } }"

# TODO this should be in Katana
clear = Fn.tee ( daisho ) -> daisho.stack = []

# TODO this *is* in Katana but doesn't copy the stack
#      so it ends up including itself :/
stack = Fn.tee ( daisho ) -> daisho.stack.unshift structuredClone daisho.stack

log = ( label ) ->
  Fn.tee ( daisho ) ->
    console.log label, daisho.stack


export {
  make
  block
  clear
  stack
  log
}