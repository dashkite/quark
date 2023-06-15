suffix = ( s ) ->
  ( text ) -> "#{ text }#{ s }"

Units =

  du: ( n ) -> Units.rem n * 18

  vu: ( n ) -> Units.rem n * 12

  ch: suffix "ch"

  px: suffix "px"

  rem: suffix "rem"

  em: suffix "em"

  pct: suffix "%"

  qrem: ( n ) -> Units.rem n/4

  hrem: ( n ) -> Units.rem n/2

  vw: suffix "vw"

  vh: suffix "vh"

  lvw: suffix "lvw"

  lvh: suffix "lvh"

  svw: suffix "svw"

  svh: suffix "svh"

  dvw: suffix "dvw"

  dvh: suffix "dvh"

  deg: suffix "deg"

  fr: suffix "fr"

  lh: suffix "lh"

  rlh: suffix "rlh"

export { Units }