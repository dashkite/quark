import {pipeWith, pipe} from "@pandastrike/garden"
import {reset} from "./reset"
import * as c from "./core"
import * as k from "./color"
import * as b from "./borders"
import * as t from "./typography"
import * as d from "./dimension"
import * as m from "./misc"
import * as u from "./units"

normalize = pipeWith c.lookup

  links: pipe [
    c.select "a, a:hover, a:visited", [
      d.display "inline-block"
      t.plain
      t.underline
      k.color "inherit"
      c.set "border", "0.25rem solid transparent"
      c.set "border-radius", "0.25rem"
    ]

    c.select "a:focus", [
      m.outline "none"
      c.set "box-shadow", "0 0 0 2px currentColor"
    ]

    c.select "p > a, p > a:hover, p > a:visited", [
      d.display "inline"
    ]
  ]

  focus: c.select ":focus", [
    m.outline "none"
    m.shadow "0 0 0 1px #333"
  ]

export {normalize}
