import std/unittest

import minim
import minim/helper
import minim/evals

suite "test if expression":
  test "(if(1 > 2) 2 else 1) == 1":
    check tIf(
      tGt(tInt(1), tInt(2)),
      tInt(2),
      tInt(1)
    ).evaluate() == 1
    check run("(if(1 > 2) 2 else 1)") == 1

suite "test while expression":
  test """
    i = 0
    while(i < 10) {
        i = i + 1
    }
    i
  """:
    check tProgram(
      @[],
      tAssign("i", tInt(0)),
      tWhile(
        tLt(tId("i"), tInt(10)),
        tSeq(
          tAssign("i", tAdd(tId("i"), tInt(1)))
        )
      ),
      tId("i")
    ).evaluate() == 10
    check run("""
      i = 0
      while(i < 10) {
        i = i + 1
      }
      i
    """) == 10