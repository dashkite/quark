import * as Fn from "@dashkite/joy/function"
import * as Meta from "@dashkite/joy/metaclass"
import * as It from "@dashkite/joy/iterable"

getters = ( type, dictionary ) ->
  Meta.mixin type::, [
    Meta.getters dictionary
  ]

trim = ( text ) -> text.trim?()

block = ( identifier, list ) ->
  content = trim It.join " ", ( item.render() for item in list )
  if content.length > 0
    "#{ identifier } { #{ content } }"
  else ""

# TODO this should be in Katana
clear = Fn.tee ( daisho ) -> daisho.stack = []

# TODO this *is* in Katana but doesn't copy the stack
#      so it ends up including itself :/
stack = Fn.tee ( daisho ) -> daisho.stack.unshift structuredClone daisho.stack

log = ( label ) ->
  Fn.tee ( daisho ) ->
    console.log label, daisho.stack


export {
  getters
  block
  clear
  stack
  log
}