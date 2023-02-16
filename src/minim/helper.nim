import asts

proc tAdd* (a, b: AST): AST =
  result = astBinary("+", a, b)

proc tSub* (a, b: AST): AST = 
  result = astBinary("-", a, b)

proc tMul* (a, b: AST): AST = 
  result = astBinary("*", a, b)

proc tDiv* (a, b: AST): AST = 
  result = astBinary("/", a, b)

proc tMod* (a, b: AST): AST =
  result = astBinary("%", a, b)

proc tInt* (value: int): AST = 
  result = astInt(value)

proc tLt* (a, b: AST): AST = 
  result = astBinary("<", a, b)

proc tGt* (a, b: AST): AST = 
  result = astBinary(">", a, b)

proc tLte* (a, b: AST): AST = 
  result = astBinary("<=", a, b)

proc tGte* (a, b: AST): AST = 
  result = astBinary(">=", a, b)

proc tAssign* (name: string, value: AST): AST =
  result = astAssignment(name, value)

proc tId* (name: string): AST =
  result = astIdent(name)

proc tSeq* (bodies: varargs[AST]): AST =
  result = astSeq(@bodies)

proc tIf* (condition, then, els: AST): AST =
  result = astIf(condition, then, els)

proc tWhile* (condition: AST, body: AST): AST =
  result = astWhile(condition, body)

proc tProgram* (functions: seq[AST], bodies: varargs[AST]): AST =
  result = astProgram(functions, @bodies)

proc tFunc* (name: string, params: seq[string], body: AST): AST =
  result = astFunc(name, params, body)

proc tCall* (name: string, args: varargs[AST]): AST =
  result = astCall(name, @args)