import asts

import std/tables

type
  UnknownBinaryOperatorError = object of ValueError

proc evaluate* (ast: AST, variables: var Table[string, int]): int =
  case ast.kind
  of akBinary:
    case ast.op
    of "+":
      result = evaluate(ast.lhs, variables) + evaluate(ast.rhs, variables)
    of "-":
      result = evaluate(ast.lhs, variables) - evaluate(ast.rhs, variables)
    of "*":
      result = evaluate(ast.lhs, variables) * evaluate(ast.rhs, variables)
    of "/":
      result = evaluate(ast.lhs, variables) div evaluate(ast.rhs, variables)
    of "<":
      result = int(evaluate(ast.lhs, variables) < evaluate(ast.rhs, variables))
    of ">":
      result = int(evaluate(ast.lhs, variables) > evaluate(ast.rhs, variables))
    of "<=":
      result = int(evaluate(ast.lhs, variables) <= evaluate(ast.rhs, variables))
    of ">=":
      result = int(evaluate(ast.lhs, variables) >= evaluate(ast.rhs, variables))
    of "==":
      result = int(evaluate(ast.lhs, variables) == evaluate(ast.rhs, variables))
    of "!=":
      result = int(evaluate(ast.lhs, variables) != evaluate(ast.rhs, variables))
  of akInt:
    result = ast.value
  of akSeq:
    for body in ast.seqBodies:
      result = evaluate(body, variables)
  of akAssignment:
    variables[ast.assignmentName] = evaluate(ast.ast, variables)
    result = variables[ast.assignmentName]
  of akIdent:
    result = variables[ast.identName]
  of akIf:
    if ast.ifCondition.evaluate(variables) != 0:
      result = evaluate(ast.ifThenClause, variables)
    else:
      result = evaluate(ast.ifElseClause, variables)
  of akWhile:
    while ast.whileCondition.evaluate(variables) != 0:
      for body in ast.whileBodies:
        discard evaluate(body, variables)
    # todo: return none[int]()
    result = -1 
  of akProgram:
    for program in ast.programs:
      result = evaluate(program, variables)
  of akFunc:
    discard

proc evaluate* (ast: AST): int =
  var variables = initTable[string, int]()
  result = evaluate(ast, variables)
