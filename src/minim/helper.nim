import asts

proc tAdd* (a, b: AST): AST =
  result = astBinary("+", a, b)

proc tSub* (a, b: AST): AST = 
  result = astBinary("-", a, b)

proc tMul* (a, b: AST): AST = 
  result = astBinary("*", a, b)

proc tDiv* (a, b: AST): AST = 
  result = astBinary("/", a, b)

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

proc tWhile* (condition: AST, bodies: varargs[AST]): AST =
  result = astWhile(condition, @bodies)

proc tProgram* (bodies: varargs[AST]): AST =
  result = astSeq(@bodies)