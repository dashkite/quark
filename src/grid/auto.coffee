import {r} from "../registry"
import {set} from "../core"

r["grid-flow-row"] = set "grid-auto-flow", "row"
r["grid-flow-col"] = set "grid-auto-flow", "column"
r["grid-flow-row-dense"] = set "grid-auto-flow", "row dense"
r["grid-flow-col-dense"] = set "grid-auto-flow", "column dense"

r["grid-columns-auto"] = set "grid-auto-columns", "auto"
r["grid-columns-min"] = set "grid-auto-columns", "min-content"
r["grid-columns-max"] = set "grid-auto-columns", "max-content"
r["grid-columns-fr"] = set "grid-auto-columns", "minmax(0, 1fr)"

r["grid-rows-auto"] = set "grid-auto-rows", "auto"
r["grid-rows-min"] = set "grid-auto-rows", "min-content"
r["grid-rows-max"] = set "grid-auto-rows", "max-content"
r["grid-rows-fr"] = set "grid-auto-rows", "minmax(0, 1fr)"
