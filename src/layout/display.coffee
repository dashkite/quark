import {r} from "../registry"
import {display, block, inline, table, hidden, flex, grid} from "../properties"

r["block"] = block
r["inline-block"] = display "inline-block"
r["inline"] = inline
r["flex"] = flex
r["inline-flex"] = display "inline-flex"
r["table"] = table
r["table-caption"] = display "table-caption"
r["table-cell"] = display "table-cell"
r["table-column"] = display "table-column"
r["table-column-group"] = display "table-column-group"
r["table-footer-group"] = display "table-footer-group"
r["table-header-group"] = display "table-header-group"
r["table-row-group"] = display "table-row-group"
r["table-row"] = display "table-row"
r["flow-root"] = display "flow-root"
r["grid"] = grid
r["inline-grid"] = display "inline-grid"
r["contents"] = display "contents"
r["hidden"] = hidden
