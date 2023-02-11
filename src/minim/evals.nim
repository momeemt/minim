import exprs

import std/tables
import std/strformat

type
  UnknownBinaryOperatorError = object of ValueError

proc evaluate* (expr: Expr, variables: var Table[string, int]): int =
  case expr.kind
  of ekBinary:
    case expr.op
    of "+":
      result = evaluate(expr.lhs, variables) + evaluate(expr.rhs, variables)
    of "-":
      result = evaluate(expr.lhs, variables) - evaluate(expr.rhs, variables)
    of "*":
      result = evaluate(expr.lhs, variables) * evaluate(expr.rhs, variables)
    of "/":
      result = evaluate(expr.lhs, variables) div evaluate(expr.rhs, variables)
    of "<":
      result = int(evaluate(expr.lhs, variables) < evaluate(expr.rhs, variables))
    of ">":
      result = int(evaluate(expr.lhs, variables) > evaluate(expr.rhs, variables))
    of "<=":
      result = int(evaluate(expr.lhs, variables) <= evaluate(expr.rhs, variables))
    of ">=":
      result = int(evaluate(expr.lhs, variables) >= evaluate(expr.rhs, variables))
    of "==":
      result = int(evaluate(expr.lhs, variables) == evaluate(expr.rhs, variables))
    of "!=":
      result = int(evaluate(expr.lhs, variables) != evaluate(expr.rhs, variables))
  of ekInt:
    result = expr.value
  of ekSeq:
    for body in expr.bodies:
      result = evaluate(body, variables)
  of ekAssignment:
    variables[expr.assignmentName] = evaluate(expr.expr, variables)
    result = variables[expr.assignmentName]
  of ekIdent:
    result = variables[expr.identName]

proc evaluate* (expr: Expr): int =
  var variables = initTable[string, int]()
  result = evaluate(expr, variables)
