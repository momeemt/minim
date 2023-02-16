import std/unittest

import minim/tokens
import minim/tokenizer

suite "test tokenize":
  test "add operator":
    let
      program = "1 +    1"
      tokens = @[
        mtNumber("1"),
        mtOperator("+"),
        mtNumber("1")
      ]
    check tokenize(program) == tokens

  test "complex operator expression":
    let
      program = "(450 + 2)    * 4 / 2"
      tokens = @[
        mtOperator("("),
        mtNumber("450"),
        mtOperator("+"),
        mtNumber("2"),
        mtOperator(")"),
        mtOperator("*"),
        mtNumber("4"),
        mtOperator("/"),
        mtNumber("2")
      ]
    check tokenize(program) == tokens

  test "assignment expression":
    let
      program = "a = 10"
      tokens = @[
        mtIdent("a"),
        mtOperator("="),
        mtNumber("10")
      ]
    check tokenize(program) == tokens

  test "if expression":
    let
      program = "(if(1 > 2) 2 else 1)"
      tokens = @[
        mtOperator("("),
        mtKeyword("if"),
        mtOperator("("),
        mtNumber("1"),
        mtOperator(">"),
        mtNumber("2"),
        mtOperator(")"),
        mtNumber("2"),
        mtKeyword("else"),
        mtNumber("1"),
        mtOperator(")")
      ]
    check tokenize(program) == tokens
  
  test "function definition":
    let
      program = "function add(a, b) { a+b }"
      tokens = @[
        mtKeyword("function"),
        mtIdent("add"),
        mtOperator("("),
        mtIdent("a"),
        mtOperator(","),
        mtIdent("b"),
        mtOperator(")"),
        mtOperator("{"),
        mtIdent("a"),
        mtOperator("+"),
        mtIdent("b"),
        mtOperator("}")
      ]
    check tokenize(program) == tokens
