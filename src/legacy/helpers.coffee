import {curry} from "@pandastrike/garden"

first = (ax) -> ax[0]
last = (ax) -> ax[ax.length - 1]
getter = curry (key, object) -> object?[key]

any = (fx) ->
  (x) ->
    for f from fx
      if (r = f x)? then return r

export {getter, first, last, any}
