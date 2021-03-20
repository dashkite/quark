import {pipe} from "@pandastrike/garden"
import * as g from "panda-grammar"
import {q as properties} from "./properties"

log = (p) ->
  (s) ->
    console.log "input:", s
    r = p s
    console.log "output:", r
    r

memoize = (p) ->
  cache = {}
  (s) -> cache[s] ?= p s

#
# beginning/end of line parsing
#

[ bol, indent ] = do (lead = []) ->

  [

    (s) ->
      p = g.all lead...
      if (m = p s)?
        {rest} = m
        {rest}

    (q, p) ->
      (s) ->
        lead.push q
        m = p s
        lead.pop()
        m

  ]

eof = (s) -> if s == "" then rest: ""

eol = g.any (g.string "\n"), eof

blank = g.all bol, eol

propertiesDelimiter = g.re /^\s*%\s*/

propertiesClause = g.all propertiesDelimiter, properties

selector = g.re /^[\w\s\-\>\+\*]+/

rule = g.rule (g.all bol, (indent (g.string "  "),
  (g.all selector, (g.optional propertiesClause),
    (g.optional g.forward -> rules)))), ({value}) ->
      [ s, px, rx ] = value[1]
      console.log s, px, rx
      value

rules = g.list eol, rule

quark = g.grammar rules

export {quark}
