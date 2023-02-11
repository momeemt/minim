import std/unittest

import minim/helper
import minim/evals

suite "test if expression":
  test "(if(1 > 2) 2 else 1) == 1":
    check tIf(
      tGt(tInt(1), tInt(2)),
      tInt(2),
      tInt(1)
    ).evaluate() == 1
