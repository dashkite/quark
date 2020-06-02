import {speek as peek} from "@dashkite/katana"
import {pipe, curry} from "@pandastrike/garden"
import {property} from "../core"

setd = curry (name, d, value) -> peek property name, d[value] ? value

export {setd}
