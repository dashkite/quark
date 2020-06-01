import {speek as peek} from "@dashkite/katana"
import {pipe, curry} from "@pandastrike/garden"
import {property} from "../core"

set = curry (name, value) -> peek property name, value
setd = curry (name, d, value) -> peek property name, d[value] ? value

export {set, setd}
