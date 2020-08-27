import {pipeWith, pipe} from "@pandastrike/garden"
import {reset} from "./reset"
import * as c from "./core"
import * as k from "./color"
import * as t from "./typography"
import * as d from "./dimension"
import * as m from "./misc"
import * as u from "./units"

normalize = pipeWith c.lookup

  links: pipe [
    c.select "a", [
      d.padding u.hrem 0.5
    ]

    c.select "p > a", [
      d.padding "0 0.125rem 0 0.125rem"
    ]

    c.select "a, a:hover, a:visited", [
      d.display "inline-block"
      t.plain
      t.underline
      k.color "inherit"
      c.set "border-radius", "0.25rem"
    ]

    c.select "a:focus", [
      m.outline "none"
      c.set "box-shadow", "0 0 0 3px #999"
    ]
  ]

export {normalize}
