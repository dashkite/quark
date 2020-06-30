import {pipeWith} from "@pandastrike/garden"
import {reset} from "./reset"
import * as c from "./core"
import * as k from "./color"
import * as t from "./typography"
import * as d from "./dimension"

normalize = pipeWith c.lookup

  links: c.select "a, a:hover, a:visited", [
    d.display "inline-block"
    t.plain
    t.underline
    k.color "inherit"
  ]

export {normalize}
