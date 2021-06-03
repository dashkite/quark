import {set} from "./core"
import * as _registry from "./properties"

registry = {_registry...}

r = new Proxy registry,
  get: (target, name) ->
    if target[name]?
      target[name]
    else
      set name
  set: (target, name, value) ->
    target[name] = value

export {r}
