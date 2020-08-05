import {curry} from "@pandastrike/garden"

_generate = (css) ->
  if css instanceof CSSStyleSheet
    css
  else if css.apply?
    _generate css()
  else
    r = new CSSStyleSheet()
    r.replaceSync css.toString()
    r

class Sheets

  constructor: (@root, @sheets = {}) ->

  get: (key) -> @sheets[key]

  set: (key, value) ->
    if value?
      @sheets[key] = _generate value
      @apply()
    else
      @remove key

  remove: (key) ->
    if @sheets[key]?
      delete @sheets[key]
      @apply()

  apply: -> @root.adoptedStyleSheets = @toArray()

  toArray: -> Object.values @sheets

sheets = (root) -> new Sheets root

export {sheets}
