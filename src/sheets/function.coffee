Function =

  url: ( text ) ->
    """
      url("#{ text }")
    """

  calc: ( expression ) ->
    "calc(#{ expression })"

export {
  Function
}