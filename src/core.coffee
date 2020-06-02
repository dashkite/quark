import {curry, rtee} from "@pandastrike/garden"
import {spush as push, speek as peek} from "@dashkite/katana"

class Container
  constructor: (@children = []) ->
  append: (value) -> @children.push value
  toString: ->
    @children
      .map ((value) -> value.toString())
      .filter ((value) -> value?)
      .join " "

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
      "#{@selector} { #{super.toString()} }"

class Property

  @create: (key, value, rule) ->
    rule.append rval = new Property key, value
    rval

  constructor: (@key, @value) ->

  toString: -> "#{@key}: '#{@value}';"

styles = (f) ->
  ->
    styles = Styles.create()
    await f [ styles ]
    styles

selector = curry Rule.create

select = (s) -> push selector s

property = curry Property.create

set = curry (name, value) -> peek property name, value

setWith = curry (name, f, value) -> set name, f value

lookup = curry (object, key) -> object[key]

export {styles, select, set, lookup, setWith}
