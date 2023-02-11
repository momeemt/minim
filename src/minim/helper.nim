import exprs

proc tAdd* (a, b: Expr): Expr =
  result = exprBinary("+", a, b)

proc tSub* (a, b: Expr): Expr = 
  result = exprBinary("-", a, b)

proc tMul* (a, b: Expr): Expr = 
  result = exprBinary("*", a, b)

proc tDiv* (a, b: Expr): Expr = 
  result = exprBinary("/", a, b)

proc tInt* (value: int): Expr = 
  result = exprInt(value)

proc tLt* (a, b: Expr): Expr = 
  result = exprBinary("<", a, b)

proc tGt* (a, b: Expr): Expr = 
  result = exprBinary(">", a, b)

proc tLte* (a, b: Expr): Expr = 
  result = exprBinary("<=", a, b)

proc tGte* (a, b: Expr): Expr = 
  result = exprBinary(">=", a, b)

proc tAssign* (name: string, value: Expr): Expr =
  result = exprAssignment(name, value)

proc tId* (name: string): Expr =
  result = exprIdent(name)

proc tSeq* (bodies: varargs[Expr]): Expr =
  result = exprSeq(@bodies)

proc tIf* (condition, then, els: Expr): Expr =
  result = exprIf(condition, then, els)
