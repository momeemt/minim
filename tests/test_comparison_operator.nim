import std/unittest

import minim
import minim/helper
import minim/evals

suite "test comparison operator":
  test "1 < 2 == 1":
    check tLt(tInt(1), tInt(2)).evaluate() == 1
    check run("1 < 2") == 1

  test "2 > 1 == 1":
    check tGt(tInt(2), tInt(1)).evaluate() == 1
    check run("2 > 1") == 1

  test "1 <= 1 == 1":
    check tLte(tInt(1), tInt(1)).evaluate() == 1
    check run("1 <= 1") == 1
  
  test "1 >= 1 == 1":
    check tGte(tInt(1), tInt(1)).evaluate() == 1
    check run("1 >= 1") == 1
