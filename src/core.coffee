import {identity, unary, curry, flip, pipe, tee} from "@pandastrike/garden"
import * as k from "@dashkite/katana"
import {getter} from "./helpers"

lookup = curry flip getter

compose = (parent, child) ->
  if !parent?
    child
  else
    parent
      .split /,\s*/
      .map (parent) ->
        if child.includes "&"
          child.replace /\&/g, -> parent
        else
          "#{parent} #{child}"
      .join ", "

sheet = (ax) ->
  f = tee k.stack pipe ax
  f
    imports: []
    namespaces: []
    media: []
    supports: []
    frames: []
    styles: []
    page: []

select = curry (value, ax) ->
  pipe [
    k.spush (parent) ->
      selector: compose parent.selector, value
      properties: []
    pipe ax
    k.read "styles"
    k.smpop (styles, rule) ->
      if rule.properties.length > 0
        styles.push rule
  ]

media = curry (value, ax) ->
  pipe [
    k.spush (parent) ->
      query: value
      selector: parent.selector
      styles: []
    k.speek unary k.stack pipe ax
    k.read "media"
    k.smpop (rules, rule) ->
      if rule.styles.length > 0
        rules.push rule
  ]

frames = curry (value, ax) ->
  pipe [
    k.spush ->
      name: value
      steps: []
    k.speek unary k.stack pipe ax
    k.read "frames"
    k.smpop (rules, rule) ->
      if rule.steps.length > 0
        rules.push rule
  ]

frame = curry (value, ax) ->
  pipe [
    k.spush ->
      name: value
      properties: []
    pipe ax
    k.read "steps"
    k.smpop (steps, step) ->
      if step.properties.length > 0
        steps.push step
  ]

from = frame "from"

to = frame "to"

set = curry (name, value) ->
  k.speek (rule) ->
    switch value.constructor
      when Object
        Object.entries value
        .map ([suffix, value]) ->
          rule.properties.push [ "#{name}-#{suffix}", value]
      else
        rule.properties.push [ name, value ]

css =

  sheet: (sheet) ->
    [
      (css.media sheet.media)
      (css.frames sheet.frames)
      (css.styles sheet.styles)
    ]
      .filter identity
      .join " "

  media: (media) ->
    media
      .map ({query, styles}) ->
        css.block query, css.styles styles
      .join " "

  frames: (frames) ->
    frames
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

build = (sheet) ->
  r = new CSSStyleSheet
  r.replaceSync toString css.sheet
  r

export {
  sheet
  select
  media
  frames
  frame
  from
  to
  set
  lookup
  render
  build
}
