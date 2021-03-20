import {pipe} from "@pandastrike/garden"
import * as p from "parjs"
import * as c from "parjs/combinators"
import {r} from "../registry"
import {colors} from "../colors"

word = (p.regexp /[\w+\-]+/).pipe(
  c.map ([value]) -> value
)

colorLiteral = (p.regexp /\#[a-f0-9]{3,6}/).pipe(
  c.map ([value]) -> value
)

isColorName = (name) -> colors[name]?
getColorName = (name) -> colors[name]

colorName = word.pipe(
  c.must isColorName
  c.map getColorName
)

color = colorName.pipe(
  c.or colorLiteral
)

integer = (p.regexp /\d+/).pipe(
  c.map ([value]) -> Number value
)

fraction = integer.pipe(
  c.thenq "/"
  c.then integer
  c.map (value) ->
    [ numerator, denominator ] = value
    numerator / denominator
)

scalar = fraction.pipe(
  c.recover -> kind: "Soft"
  c.or p.float()
)

unit = (p.regexp /[\w]+/).pipe(
  c.map ([value]) -> value
)

conversions =
  r: (units) -> [ units, "rem" ]
  qrem: (units) -> [ ((Number.parseFloat units) / 4), "rem" ]
  qr: (units) -> conversions.qrem units
  hrem: (units) -> [ ((Number.parseFloat units) / 2), "rem" ]
  hr: (units) -> conversions.hrem units

measure = scalar.pipe(
  c.then unit
  c.map ([number, units]) ->
    if (conversion = conversions[units])?
      [ number, units ] = conversion number
    "#{number}#{units}"
)

operand = color.pipe(
  c.or measure, word
)

operands = operand.pipe(
  c.manySepBy p.whitespace()
)

getOperator = (name) -> r[name]

operator = word.pipe(
  c.map getOperator
)

property = operator.pipe(
  c.thenq p.whitespace()
  c.then operands
  c.map ([f, args]) -> if args.length == 0 then f else f args...
)

properties = property.pipe(
  c.between p.whitespace()
  c.manySepBy ","
  c.map pipe
)

import {render, sheet, select} from "../core"

q = (s) ->
  result = properties.parse s
  if result.kind == "OK"
    result.value
  else
    throw new Error result.toString()

export {q}
