import exprs

import std/tables

type
  UnknownBinaryOperatorError = object of ValueError

proc evaluate* (expr: AST, variables: var Table[string, int]): int =
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
    for body in expr.seqBodies:
      result = evaluate(body, variables)
  of ekAssignment:
    variables[expr.assignmentName] = evaluate(expr.expr, variables)
    result = variables[expr.assignmentName]
  of ekIdent:
    result = variables[expr.identName]
  of ekIf:
    if expr.ifCondition.evaluate(variables) != 0:
      result = evaluate(expr.ifThenClause, variables)
    else:
      result = evaluate(expr.ifElseClause, variables)
  of ekWhile:
    while expr.whileCondition.evaluate(variables) != 0:
      for body in expr.whileBodies:
        discard evaluate(body, variables)
    # todo: return none[int]()
    result = -1 
  of ekProgram:
    for program in expr.programs:
      result = evaluate(program, variables)

proc evaluate* (expr: AST): int =
  var variables = initTable[string, int]()
  result = evaluate(expr, variables)
