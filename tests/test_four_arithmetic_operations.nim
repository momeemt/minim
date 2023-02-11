import std/unittest

import minim/helper
import minim/evals

suite "test addition":
  test "1 + 1 == 2":
    check tAdd(tInt(1), tInt(1)).evaluate() == 2

  test "1 + 2 + 3 == 6":
    check tAdd(tAdd(tInt(1), tInt(2)), tInt(3)).evaluate() == 6

suite "test subtraction":
  test "1 - 1 == 0":
    check tSub(tInt(1), tInt(1)).evaluate() == 0
  
  test "1 - 2 == -1":
    check tSub(tInt(1), tInt(2)).evaluate() == -1

suite "test multiplication":
  test "1 * 1 == 1":
    check tMul(tInt(1), tInt(1)).evaluate() == 1
  
  test "1 * 0 == 0":
    check tMul(tInt(1), tInt(0)).evaluate() == 0

  test "2 * 2 == 4":
    check tMul(tInt(2), tInt(2)).evaluate() == 4

suite "test division":
  test "0 / 1 == 0":
    check tDiv(tInt(0), tInt(1)).evaluate() == 0

  test "2 / 1 == 2":
    check tDiv(tInt(2), tInt(1)).evaluate() == 2

  test "6 / 2 == 3":
    check tDiv(tInt(6), tInt(2)).evaluate() == 3

suite "test complex expression":
  test "(1 + (2 * 3) - 1) / 2 == 3":
    check tDiv(
      tSub(
        tAdd(
          tInt(1),
          tMul(
            tInt(2),
            tInt(3)
          )
        ),
        tInt(1)
      ),
      tInt(2)
    ).evaluate() == 3
