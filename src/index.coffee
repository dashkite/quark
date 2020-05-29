import {curry, rtee} from "panda-garden"
import {push} from "@dashkite/katana"

class Container
  constructor: (@children = []) ->
  append: (value) -> @children.push value
  toString: -> @children.reduce ((s,p) -> s += p.toString()), ""

class Styles extends Container
  @create: -> new Styles

class Rule extends Container

  @create: (selector, parent) ->
    switch parent.constructor
      when Styles
        rval = (new Rule selector, parent)
        parent.append rval
      when Rule
        rval = (new Rule "#{parent.selector} #{selector}", parent.styles)
        parent.styles.append rval
    rval

  constructor: (@selector, @styles) ->
    super()

  toString: ->
    if @children.length > 0
      "#{@selector} { #{super.toString()} }\n"
    else ""

class Property

  @create: (key, value, rule) ->
    rule.append rval = new Property key, value
    rval

  constructor: (@key, @value) ->

  toString: -> "#{@key}: '#{@value}';"

styles = Styles.create

rule = curry Rule.create


property = curry Property.create

export {styles, rule, property}
