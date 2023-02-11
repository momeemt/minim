import exprs

import std/strformat

type
  UnknownBinaryOperatorError = object of ValueError

proc evaluate* (expr: Expr): int =
  case expr.kind
  of ekBinary:
    case expr.op
    of "+":
      result = evaluate(expr.lhs) + evaluate(expr.rhs)
    of "-":
      result = evaluate(expr.lhs) - evaluate(expr.rhs)
    of "*":
      result = evaluate(expr.lhs) * evaluate(expr.rhs)
    of "/":
      result = evaluate(expr.lhs) div evaluate(expr.rhs)
  of ekInt:
    result = expr.value
  else:
    raise newException(UnknownBinaryOperatorError, &"定義されていない構文木: {expr.kind}")