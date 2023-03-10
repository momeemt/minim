import std/unittest

import minim
import minim/helper
import minim/evals

suite "test addition":
  test "1 + 1 == 2":
    check tAdd(tInt(1), tInt(1)).evaluate() == 2
    check run("1 + 1") == 2

  test "1 + 2 + 3 == 6":
    check tAdd(tAdd(tInt(1), tInt(2)), tInt(3)).evaluate() == 6
    check run("1 + 2 + 3") == 6

suite "test subtraction":
  test "1 - 1 == 0":
    check tSub(tInt(1), tInt(1)).evaluate() == 0
    check run("1 - 1") == 0
  
  test "1 - 2 == -1":
    check tSub(tInt(1), tInt(2)).evaluate() == -1
    check run("1 - 2") == -1

suite "test multiplication":
  test "1 * 1 == 1":
    check tMul(tInt(1), tInt(1)).evaluate() == 1
    check run("1 * 1") == 1
  
  test "1 * 0 == 0":
    check tMul(tInt(1), tInt(0)).evaluate() == 0
    check run("1 * 0") == 0

  test "2 * 2 == 4":
    check tMul(tInt(2), tInt(2)).evaluate() == 4
    check run("2 * 2") == 4

suite "test division":
  test "0 / 1 == 0":
    check tDiv(tInt(0), tInt(1)).evaluate() == 0
    check run("0 / 1") == 0

  test "2 / 1 == 2":
    check tDiv(tInt(2), tInt(1)).evaluate() == 2
    check run("2 / 1") == 2

  test "6 / 2 == 3":
    check tDiv(tInt(6), tInt(2)).evaluate() == 3
    check run("6 / 2") == 3

suite "test modulo":
  test "4 % 2 == 0":
    check tMod(tInt(4), tInt(2)).evaluate() == 0
    check run("4 % 2") == 0

  test "7 % 5 == 2":
    check tMod(tInt(7), tInt(5)).evaluate() == 2
    check run("7 % 5") == 2

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
    check run("(1 + (2 * 3) - 1) / 2") == 3
