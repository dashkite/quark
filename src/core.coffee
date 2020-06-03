import {flip, curry, pipe, rtee} from "@pandastrike/garden"
import {
  spush as push
  speek as peek
  spop as pop
  smpop as mpop
  log
} from "@dashkite/katana"
import {getter} from "./helpers"

append = (child, parent) ->
  parent.children.push child
  child

styles = (f) ->
  ->
    f [ (styles = children: []) ]
    styles

selector = curry (value, parent) ->
  styles: parent.styles ? parent
  selector: if parent.selector? then "#{parent.selector} #{value}" else value
  children: []

property = curry (name, value) -> {name, value}

select = curry (value, f) ->
  pipe [
    push selector value
    push getter "styles"
    pop flip append
    f
  ]

set = curry (name, value) ->
  pipe [
    push -> property name, value
    pop append
  ]

setWith = curry (name, f, value) -> set name, f value

lookup = curry flip getter

join = (ax) -> ax.join " "

toString = ({children, selector}) ->
  if selector?
    join do ({name, value} = {})->
      for {name, value} in children
        "#{name}: '#{value}';"
  else
    join do ({rule} = {})->
      for rule in children when rule.children.length > 0
        "#{rule.selector} { #{toString rule} }"

export {styles, selector, property, select, set, lookup, setWith, toString}
