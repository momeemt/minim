type
  ExprKind* = enum
    ekBinary
    ekInt

  Expr* = ref ExprObj

  ExprObj* = object
    case kind*: ExprKind
    of ekBinary:
      op*: string
      lhs*: Expr
      rhs*: Expr
    of ekInt:
      value*: int

proc exprBinary* (op: string, lhs, rhs: Expr): Expr =
  result = Expr(kind: ekBinary)
  result[].op = op
  result[].lhs = lhs
  result[].rhs = rhs

proc exprInt* (value: int): Expr =
  result = Expr(kind: ekInt)
  result[].value = value
