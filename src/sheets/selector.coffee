import * as It from "@dashkite/joy/iterable"

Selector =

  compose: ( parent, child ) ->
    if parent?
      parents = parent.split /,\s*/
      It.join ", ",
        if child.includes "&"
          for parent in parents
            child.replace /\&/g, -> parent
        else
          for parent in parents
            "#{ parent } #{ child }"
    else child  

export {
  Selector
}