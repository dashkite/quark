import {pipe} from "@pandastrike/garden"
import * as g from "panda-grammar"
import {r} from "./registry"
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

conversions =
  qrem: (units) -> [ ((Number.parseFloat units) / 4), "rem" ]

# TODO add support for virtual measures
measure = g.rule (g.all (g.re /^[\d\.]+/), (g.re /^[\w]+/)), ({value}) ->
  [ number, units ] = value
  if (conversion = conversions[units])?
    [ number, units ] = conversion number
  "#{number}#{units}"


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

export {q}
