import {pipe, pipeWith} from "@pandastrike/garden"
import * as g from "panda-grammar"
import {set} from "./core"
import * as _r from "./properties"
import {colors} from "./colors"

condition = (p, c) ->
  (s) -> if (m = p s)? && (c m) then m

word = g.re /^[\w\-]+/

optional = (p) ->
  (s) ->
    if (m = p s)?
      m
    else
      rest: s

second = (a) -> a[1]

isOperator = ({value}) -> r[value]?

getOperator = ({value}) -> r[value]

# TODO add support for virtual measures
measure = g.re /^[\w\.]+/

colorLiteral = g.re /^\#[a-f0-9]{3,6}/

isColorName = ({value}) -> colors[value]?

getColorName = ({value}) -> colors[value]

colorName = g.rule (condition word, isColorName), getColorName

color = g.any colorName, colorLiteral

operand = g.any color, measure, word

operands =  g.list g.ws, operand

operator = g.rule (condition word, isOperator), getOperator

rule = g.rule (g.all operator, optional (g.all g.ws, operands)), ({value}) ->
  [ f, ax ] = value
  # skip ws
  if ax? then (f ax[1]...) else f

rules = g.rule (g.list (g.re /^,\s+/), rule), ({value}) -> pipe value

q = g.grammar rules

r = new Proxy _r,
  get: (target, name, receiver) ->
    if target[name]?
      target[name]
    else
      set name

export {r, q}
