import asts

import std/tables

type
  CannotDefineFunctionInBodyError* = object of ValueError

proc evaluate* (ast: AST, variables: var Table[string, int], functions: var Table[string, AST]): int =
  case ast.kind
  of akBinary:
    case ast.op
    of "+":
      result = evaluate(ast.lhs, variables, functions) + evaluate(ast.rhs, variables, functions)
    of "-":
      result = evaluate(ast.lhs, variables, functions) - evaluate(ast.rhs, variables, functions)
    of "*":
      result = evaluate(ast.lhs, variables, functions) * evaluate(ast.rhs, variables, functions)
    of "/":
      result = evaluate(ast.lhs, variables, functions) div evaluate(ast.rhs, variables, functions)
    of "<":
      result = int(evaluate(ast.lhs, variables, functions) < evaluate(ast.rhs, variables, functions))
    of ">":
      result = int(evaluate(ast.lhs, variables, functions) > evaluate(ast.rhs, variables, functions))
    of "<=":
      result = int(evaluate(ast.lhs, variables, functions) <= evaluate(ast.rhs, variables, functions))
    of ">=":
      result = int(evaluate(ast.lhs, variables, functions) >= evaluate(ast.rhs, variables, functions))
    of "==":
      result = int(evaluate(ast.lhs, variables, functions) == evaluate(ast.rhs, variables, functions))
    of "!=":
      result = int(evaluate(ast.lhs, variables, functions) != evaluate(ast.rhs, variables, functions))
  of akInt:
    result = ast.value
  of akSeq:
    for body in ast.seqBodies:
      result = evaluate(body, variables, functions)
  of akAssignment:
    variables[ast.assignmentName] = evaluate(ast.ast, variables, functions)
    result = variables[ast.assignmentName]
  of akIdent:
    result = variables[ast.identName]
  of akIf:
    if ast.ifCondition.evaluate(variables, functions) != 0:
      result = evaluate(ast.ifThenClause, variables, functions)
    else:
      result = evaluate(ast.ifElseClause, variables, functions)
  of akWhile:
    while ast.whileCondition.evaluate(variables, functions) != 0:
      result = evaluate(ast.whileBody, variables, functions)
  of akProgram:
    for function in ast.functions:
      functions[function.funcName] = function
    for program in ast.programs:
      result = evaluate(program, variables, functions)
  of akCall:
    let
      fn = functions[ast.callName]
    var args: seq[int] = @[]
    for arg in ast.callArgs:
      args.add evaluate(arg, variables, functions)
    var newVariables = variables
    block:
      var i = 0
      for arg in args:
        newVariables[fn.funcParams[i]] = arg
        i += 1
    result = evaluate(fn.funcBody, newVariables, functions)
  of akFunc:
    raise newException(CannotDefineFunctionInBodyError, "body内に関数定義を置くことはできません")

proc evaluate* (ast: AST): int =
  var
    variables = initTable[string, int]()
    functions = initTable[string, AST]()
  result = evaluate(ast, variables, functions)
