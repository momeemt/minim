import std/unittest

import minim/helper
import minim/evals

suite "test seq":
  test "{a = 100; a} == 100":
    check tSeq(
      tAssign("a", tInt(100)),
      tId("a")
    ).evaluate() == 100

  test "{a = 100; b = a + 1; b} == 101":
    check tSeq(
      tAssign("a", tInt(100)),
      tAssign("b", tAdd(
        tId("a"), tInt(1)
      )),
      tId("b")
    ).evaluate() == 101

suite "test while":
  test """
    i = 0;
    while(i < 10) {
        i = i + 1;
    };
    i
  """:
    check tProgram(
      tAssign("i", tInt(0)),
      tWhile(
        tLt(tId("i"), tInt(10)),
        tAssign("i", tAdd(tId("i"), tInt(1))),
      ),
      tId("i")
    ).evaluate() == 10