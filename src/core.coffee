import {
  identity
  unary
  curry
  flip
  pipe
  tee
} from "@dashkite/joy/function"

import * as k from "@dashkite/katana/sync"
import {getter} from "./helpers"

lookup = curry flip getter

compose = (parent, child) ->
  parent ?= ""
  parent
    .split /,\s*/
    .map (parent) ->
      if child.includes "&"
        child.replace /\&/g, -> parent
      else if parent == ""
        child
      else
        "#{parent} #{child}"
    .join ", "

sheet = (ax) ->
  f = tee pipe [
    k.read "styles"
    pipe ax
  ]
  f
    imports: []
    namespaces: []
    fonts: []
    media: []
    supports: []
    keyframes: []
    styles: []
    page: []

select = curry (value, ax) ->
  pipe [
    k.push (parent) ->
      selector: compose parent.selector, value
      properties: []
    pipe ax
    k.read "styles"
    k.mpop (styles, rule) ->
      if rule.properties.length > 0
        styles.push rule
  ]

fonts = curry (ax) ->
  pipe [
    k.push (parent) ->
      selector: parent.selector
      properties: []
    k.peek pipe ax
    k.read "fonts"
    k.mpop (rules, rule) ->
      if rule.properties.length > 0
        rules.push rule
  ]

# TODO this now works with properties, but it's not
#      very elegant and i'm loathe to use it elsewhere
#      (which maybe only affects `supports`?)
media = curry (value, ax) ->
  pipe [
    k.push (parent) ->
      query: value
      styles: []
      selector: parent.selector
      properties: []
    pipe ax
    k.read "media"
    k.mpop (rules, rule) ->
      if rule.properties.length > 0
        rules.push
          query: value
          styles: [
            selector: rule.selector
            properties: rule.properties
          ]
      if rule.styles.length > 0
        rules.push rule
  ]

supports = curry (value, ax) ->
  pipe [
    k.push (parent) ->
      query: value
      selector: parent.selector
      styles: []
    k.peek pipe ax
    k.read "supports"
    k.mpop (styles, rule) ->
      if rule.styles.length > 0
        styles.push rule
  ]

keyframes = curry (value, ax) ->
  pipe [
    k.push ->
      name: value
      steps: []
    k.peek pipe ax
    k.read "keyframes"
    k.mpop (rules, rule) ->
      if rule.steps.length > 0
        rules.push rule
  ]

keyframe = curry (value, ax) ->
  pipe [
    k.push ->
      name: value
      properties: []
    pipe ax
    k.read "steps"
    k.mpop (steps, step) ->
      if step.properties.length > 0
        steps.push step
  ]

from = keyframe "from"

to = keyframe "to"

set = curry (name, value) ->
  k.peek (rule) ->
    switch value.constructor
      when Object
        Object.entries value
        .map ([suffix, value]) ->
          rule.properties.push [ "#{name}-#{suffix}", value]
      else
        rule.properties.push [ name, value ]

compound = (rules) -> rules.join ", "

css =

  sheet: (sheet) ->
    [
      (css.fonts sheet.fonts)
      (css.media sheet.media)
      (css.supports sheet.supports)
      (css.keyframes sheet.keyframes)
      (css.styles sheet.styles)
    ]
      .filter identity
      .join " "

  fonts: (fonts) ->
    fonts
      .map ({properties}) ->
        css.block "@font-face", css.properties properties
      .join " "

  media: (media) ->
    media
      .map ({query, styles}) ->
        css.block "@media #{query}", css.styles styles
      .join " "

  supports: (supports) ->
    supports
      .map ({query, styles}) ->
        css.block "@supports #{query}", css.styles styles
      .join " "

  keyframes: (keyframes) ->
    keyframes
      .map ({name, steps}) ->
        css.block "@keyframes #{name}", css.steps steps
      .join " "

  steps: (steps) ->
    steps
      .map ({name, properties}) ->
        css.block name, css.properties properties
      .join " "

  styles: (styles) ->
    styles
      .map ({selector, properties}) ->
        css.block selector, css.properties properties
      .join " "

  properties: (px) ->
    px
      .map ([key, value]) -> "#{key}: #{value};"
      .join " "

  block: (label, content) -> "#{label} { #{content} }"

render = css.sheet

export {
  sheet
  select
  fonts
  media
  supports
  keyframes
  keyframe
  from
  to
  set
  compound
  lookup
  render
}
