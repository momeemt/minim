import std/unittest

import minim
import minim/helper
import minim/evals

suite "test functions":
  test """
  function add(a, b) {
    return a + b;
  },
  add(1, 2) == 3
  """:
    check tProgram(
      @[
        tFunc("add", @["a", "b"], tAdd(tId("a"), tId("b")))
      ],
      tCall("add", tInt(1), tInt(2))
    ).evaluate() == 3
    check run("""
      function add(a, b) {
        a + b
      }
      add(1, 2)
    """) == 3
