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
