import {curry} from "@pandastrike/garden"

first = (ax) -> ax[0]
last = (ax) -> ax[ax.length - 1]
getter = curry (key, object) -> object?[key]

export {getter, first, last}
