import {pipe} from "@pandastrike/garden"
# import * as p from "parjs"
# import * as c from "parjs/combinators"
import {r} from "../registry"
import {colors} from "../colors"

ws = g.re /^\s+/

word = g.re /^[\w+\-]+/

integer = g.all [
  g.re /^\d+/
  g.map (value) -> Number.parseInt value, 10
]

float = g.all [
  g.re /^\d+\.?\d*/
  g.map (text) -> Number.parseFloat text
]

colorLiteral = g.re /^\#[a-f0-9]{3,6}/

isColorName = (name) -> colors[name]?

getColorName = (name) -> colors[name]

colorName = g.all [
  word
  g.test isColorName
  g.map getColorName
]

color = g.any [
  colorName
  colorLiteral
]

fraction = g.all [
  integer
  g.skip "/"
  integer
  g.map (value) ->
    [ numerator, denominator ] = value
    numerator / denominator
]

scalar = g.any [
  fraction
  float
]

unit = g.re /[\w]+/

conversions =
  r: (units) -> [ units, "rem" ]
  qrem: (units) -> [ ((Number.parseFloat units) / 4), "rem" ]
  qr: (units) -> conversions.qrem units
  hrem: (units) -> [ ((Number.parseFloat units) / 2), "rem" ]
  hr: (units) -> conversions.hrem units

convert = (number, units) ->
  if (conversion = conversions[units])?
    [ number, units ] = conversion number
  "#{number}#{units}"

measure = g.all [
  scalar
  unit
  g.map spread convert
]

operand = g.any [
  color
  measure
  word
]

operands = g.list ws, operand

getOperator = (name) -> r[name]

operator = g.all [
  word
  g.map getOperator
]

apply = ([f, args]) -> if args.length == 0 then f else f args...

property = g.all [
  operator
  g.skip ws
  operands
  g.map spread apply
]

comma = g.all [
  g.trim ws
  g.text ","
  g.trim ws
]

properties = g.all [
  g.trim ws
  g.list comma, property
  g.map pipe
  g.result
]

export {q}
