suffix = ( s ) ->
  ( text ) -> "#{ text }#{ s }"

quarter = ( f ) -> ( n ) -> f n/4

half = ( f ) -> ( n ) -> f n/2

Units =

  du: ( n ) -> Units.rem n * 18

  vu: ( n ) -> Units.rem n * 12

  ch: suffix "ch"

  px: suffix "px"

  rem: rem = suffix "rem"

  em: suffix "em"

  pct: suffix "%"

  qrem: quarter rem

  hrem: half rem

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

  rlh: rlh = suffix "rlh"

  qrlh: quarter rlh

  hrlh: half rlh

export { Units }