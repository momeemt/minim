import exprs

proc tAdd* (a, b: AST): AST =
  result = exprBinary("+", a, b)

proc tSub* (a, b: AST): AST = 
  result = exprBinary("-", a, b)

proc tMul* (a, b: AST): AST = 
  result = exprBinary("*", a, b)

proc tDiv* (a, b: AST): AST = 
  result = exprBinary("/", a, b)

proc tInt* (value: int): AST = 
  result = exprInt(value)

proc tLt* (a, b: AST): AST = 
  result = exprBinary("<", a, b)

proc tGt* (a, b: AST): AST = 
  result = exprBinary(">", a, b)

proc tLte* (a, b: AST): AST = 
  result = exprBinary("<=", a, b)

proc tGte* (a, b: AST): AST = 
  result = exprBinary(">=", a, b)

proc tAssign* (name: string, value: AST): AST =
  result = exprAssignment(name, value)

proc tId* (name: string): AST =
  result = exprIdent(name)

proc tSeq* (bodies: varargs[AST]): AST =
  result = exprSeq(@bodies)

proc tIf* (condition, then, els: AST): AST =
  result = exprIf(condition, then, els)

proc tWhile* (condition: AST, bodies: varargs[AST]): AST =
  result = exprWhile(condition, @bodies)

proc tProgram* (bodies: varargs[AST]): AST =
  result = exprSeq(@bodies)