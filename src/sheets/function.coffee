import * as Type from "@dashkite/joy/type"
import { generic } from "@dashkite/joy/generic"
import * as It from "@dashkite/joy/iterable"

F =

  url: ( text ) -> "url(\"#{ text }\")"

  calc: ( expression ) -> "calc(#{ expression })"

  var: do ({f} = {}) ->
    f = generic name: "var"
    generic f, Type.isString, ( name )  -> "var(--#{ name })"
    generic f, Type.isArray, ([ name, fallback ]) ->
      "var(--#{ name }, #{ fallback })"
    f
  
  max: ( args ) -> "max( #{ It.join ', ', args })"

  min: ( args ) -> "min( #{ It.join ', ', args })"

export {
  F
}