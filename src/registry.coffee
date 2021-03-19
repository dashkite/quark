import {set} from "./core"
import * as _r from "./properties"

r = new Proxy _r,
  get: (target, name) ->
    if target[name]?
      target[name]
    else
      set name

export {r}
