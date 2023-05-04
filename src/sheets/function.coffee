F =

  url: ( text ) -> "url(\"#{ text }\")"

  calc: ( expression ) -> "calc(#{ expression })"

  var: ( name )  -> "var(--#{ name })"

export {
  F
}