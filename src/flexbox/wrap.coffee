import {r} from "../registry"
import {set} from "../core"

r["flex-auto"] = set "flex", "1 1 auto"
r["flex-adapt"] = set "flex", "1 1 0%"
r["flex-shrink"] = set "flex", "0 1 auto"
r["flex-grow"] = set "flex", "1 0 auto"
r["flex-none"] = set "flex", "none"
