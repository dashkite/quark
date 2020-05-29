import "source-map-support/register"
import {wrap, tee, flow} from "panda-garden"
import {stack, push, pop, peek, log} from "@dashkite/katana"

import {rule} from "../src"
import {stylesheet, toString} from "./helpers"
import theme from "./theme"
import Article from "./article"

{article} = Article.bind theme

sheet = stylesheet flow [
  push rule "main"
  article
]

do -> console.log toString await sheet()
