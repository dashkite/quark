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
    c.select "& a, & a:hover, & a:visited", [
      d.display "inline-block"
      d.padding
        top: u.qrem 1
        bottom: u.qrem 1
      t.plain
      t.underline
      k.color "inherit"
    ]

    c.select "a:focus", [
      m.outline "none"
      b.border
        top: "1px dashed"
        bottom: "1px dashed"
    ]

    c.select "& p, & ul", [
      c.select "& a", [
        c.select "&, &:hover, &:visited", [
          d.display "inline"
  ] ] ] ]

export {normalize}
