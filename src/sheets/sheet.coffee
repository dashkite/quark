import * as It from "@dashkite/joy/iterable"
import { Rules } from "./rule"

class Sheet extends Rules

  @make: -> Object.assign ( new Sheet ), content: []

  @append: ( sheet, value ) -> sheet.append value

  @render: ( sheet ) -> sheet.render()

  append: ( value ) -> @content.push value
    
  render: ->
    It.join " ",
      for value in @content when !( value.isEmpty )
        value.render()


export {
  Sheet
}