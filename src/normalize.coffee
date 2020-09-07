import {pipeWith} from "@pandastrike/garden"
import {reset} from "./reset"
import * as c from "./core"
import * as k from "./color"
import * as b from "./borders"
import * as t from "./typography"
import * as d from "./dimension"
import * as m from "./misc"

normalize = pipeWith c.lookup

  links: c.select "a, a:hover, a:visited", [
    d.display "inline-block"
    t.plain
    t.underline
    k.color "inherit"
  ]

  focus: c.select ":focus", [
    m.outline "none"
    m.shadow "0 0 0 1px #333"
  ]

export {normalize}
