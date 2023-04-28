suffix = ( s ) ->
  ( text ) -> "#{ text }#{ s }"

Units =

  du: ( n ) -> Units.px n * 320

  vu: ( n ) -> Units.px n * 192

  ch: suffix "ch"

  px: suffix "px"

  rem: suffix "rem"

  em: suffix "em"

  pct: suffix "%"

  qrem: ( n ) -> Units.rem n/4

  hrem: ( n ) -> Units.rem n/2

  vw: suffix "vw"

  vh: suffix "vh"

  deg: suffix "deg"

export { Units }