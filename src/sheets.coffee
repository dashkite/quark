import {curry} from "@pandastrike/garden"

bind = (css) ->
  if css.constructor == CSSStyleSheet
    css
  else if css.apply?
    bind css()
  else
    r = new CSSStyleSheet()
    r.replaceSync css.toString()
    r

class Sheets

  constructor: (@root, @sheets = {}) ->

  get: (key) -> @sheets[key]

  set: (key, value) ->
    if value?
      @sheets[key] = bind value
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
