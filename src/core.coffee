import {flip, curry, pipe, tee} from "@pandastrike/garden"
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

styles = (ax) -> -> (pipe ax) [ (r = children: []) ]; r

munge = (parent, child) ->
  if child.includes "&"
    child.replace /\&/g, -> parent
  else if /^@/.test child
    # this is a bit hacky
    "#{child}&&#{parent}"
  else
    "#{parent} #{child}"

selector = curry (value, parent) ->
  styles: parent.styles ? parent
  selector: if parent.selector? then munge parent.selector, value else value
  children: []

property = curry (name, value) -> {name, value}

select = curry (value, ax) ->
  tee pipe [
    push selector value
    push getter "styles"
    pop flip append
    pipe ax
  ]

set = curry (name, value) ->
  pipe [
    push -> property name, value
    pop append
  ]

lookup = curry flip getter

any = (fx) ->
  (x) ->
    for f from fx
      if (r = f x)? then return r

join = (ax) -> ax.join " "

toString = ({children, selector}) ->
  if selector?
    join do ({name, value} = {})->
      for {name, value} in children
        switch value.constructor
          when Object
            join do ({suffix, suffixValue} = {}) ->
              for suffix, suffixValue of value
                "#{name}-#{suffix}: #{suffixValue};"
          else
            "#{name}: #{value};"
  else
    join do ({rule} = {})->
      for rule in children when rule.children.length > 0
        if /^@/.test rule.selector
          [atRule, selector] = rule.selector.split "&&"
          "#{atRule} { #{selector} { #{toString rule} } }"
        else
          "#{rule.selector} { #{toString rule} }"

render = (f) -> toString f()

export {
  styles
  selector
  property
  select
  set
  lookup
  any
  toString
  render
}
