import {pipe} from "@pandastrike/garden"
import * as p from "@dashkite/parse"
import {r} from "../registry"
import {colors} from "../colors"

spread = (f) -> (ax) -> f ax...

symbol = p.re /^[\w+\-]+/, "symbol"

integer = p.pipe [
  p.match p.re /^\d+/, "digit"
  p.map (value) -> Number.parseInt value, 10
]

float = p.pipe [
  p.match p.re /^\d+\.?\d*/, "decimal"
  p.map (text) -> Number.parseFloat text
]

colorLiteral = p.re /^\#[a-f0-9]{3,6}/, "color literal"

isColorName = (name) -> colors[name]?

getColorName = (name) -> colors[name]

colorName = p.pipe [
  p.match symbol
  p.test "color name", isColorName
  p.map getColorName
]

color = p.any [
  colorName
  colorLiteral
]

fraction = p.pipe [
  p.all [
    integer
    p.skip "/"
    integer
  ]
  p.map (value) ->
    [ numerator, denominator ] = value
    numerator / denominator
]

scalar = p.any [
  fraction
  float
]


unit = p.re /[\w]+/, "unit"

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

measure = p.pipe [
  p.all [
    scalar
    unit
  ]
  p.map spread convert
]


operand = p.any [
  color
  measure
  symbol
]

operands = p.list p.ws, operand

getOperator = (name) -> r[name]

operator = p.pipe [
  p.match symbol
  p.map getOperator
]

apply = (f, args) -> if !args? then f else f args...

property = p.pipe [
  p.all [
    operator
    # TODO this part seems clunky
    p.optional p.pipe [
      p.all [
        p.skip p.ws
        operands
      ]
      p.map ([operands]) -> operands
    ]
  ]
  p.map spread apply
]

comma = p.all [
  p.trim p.ws
  p.text ","
  p.trim p.ws
]

properties = p.pipe [
  p.all [
    p.trim p.ws
    p.list comma, property
  ]
  p.map spread pipe
]

q = p.parser properties

export {q}
