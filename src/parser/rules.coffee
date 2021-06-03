import {pipe} from "@dashkite/joy/function"
import * as p from "@dashkite/parse"
import * as r from "./properties"
# import {render, sheet, select as $} from "../core"
import * as q from "../core"

bol = p.skip p.pipe [
  p.get "indent", []
  p.apply p.all
]

block = (f, g) -> p.push "indent", f, g

pdelim = p.re /^\s*%\s*/, "%"

pclause = p.first p.all [
    p.skip pdelim
    r.properties
  ]

selector = p.pipe [
  p.re /^[^%\n]+/, "selector"
  p.map (s) -> s.trim()
]

indent = p.text "  "

eol = p.any [
  p.all [
    p.text "//"
    p.re /.*/
    p.eol
  ]
  p.eol
]

empty = p.all [
  p.trim p.ws
  eol
]

nested = block indent, p.forward -> sclauses

sclause = p.pipe [
  p.all [
    p.trim p.many empty
    bol
    p.assign "result", "selector", selector
    p.assign "result", "properties", p.optional pclause
    p.skip p.eol
    p.assign "result", "nested", p.optional nested
  ]
  p.get "result"
  p.map (value) ->
    value.nested ?= []
    q.select value.selector,
      if value.properties?
        [ value.properties, value.nested... ]
      else value.nested
]

sclauses = p.many sclause

rules = p.pipe [
  sclauses
  p.map (r) -> q.render q.sheet r
]

parse = p.parser rules

export {parse}
