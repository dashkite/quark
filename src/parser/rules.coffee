import {pipe} from "@pandastrike/garden"
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

sclause = p.pipe [
  p.all [
    bol
    selector
    pclause
    p.skip p.eol
    p.optional block indent, p.forward -> sclauses
  ]
  p.map ([s, p, k]) ->
    q.select s, [ p, k... ]
]

sclauses = p.many sclause

rules = p.pipe [
  sclauses
  p.map (r) -> q.render q.sheet r
]

parse = p.parser rules

export {parse}
