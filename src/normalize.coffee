import {pipeWith, pipe} from "@pandastrike/garden"
import {reset} from "./reset"
import * as c from "./core"
import * as k from "./color"
import * as b from "./borders"
import * as t from "./typography"
import * as d from "./dimension"
import * as m from "./misc"
import * as u from "./units"

typographicAnchor = c.select "a", [

  c.select "&:focus", [
    m.outline "none"
    m.shadow "none"
    c.set "border-radius", 0
    b.border
      left: "none"
      right: "none"
      top: "1px dashed"
      bottom: "1px dashed"
    d.padding
      top: u.qrem 1
      bottom: u.qrem 1
  ]

  c.select "&, &:hover, &:visited", [
    d.display "inline"
] ]

normalize = pipeWith c.lookup

  links: pipe [
    c.select "& a, & a:hover, & a:visited", [
      d.display "inline-block"
      t.plain
      t.underline
      k.color "inherit"
    ]

    c.select "& a:focus", [
      m.outline "none"
      c.set "border-radius", u.hrem 1
      m.shadow "0 0 0 1px currentColor"
    ]

    # WARNING: this selector has been in Chrome since 2016,
    # but is not implemented by non-Chromium browsers.
    c.select ":host-context", [
      c.select "&(p), &(h1), &(h2), &(h3), &(h4),
        &(h5), &(h6), &(li), &(blockquote), &(td), &(th)", [
        typographicAnchor
    ] ]

    c.select "& p, & li, & blockquote, & td, & th", [
      typographicAnchor
    ]
  ]

export {normalize}
