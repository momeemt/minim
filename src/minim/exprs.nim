type
  ExprKind* = enum
    ekBinary
    ekInt
    ekAssignment
    ekIdent
    ekSeq
    ekIf

  Expr* = ref ExprObj

  ExprObj* = object
    case kind*: ExprKind
    of ekBinary:
      op*: string
      lhs*: Expr
      rhs*: Expr
    of ekInt:
      value*: int
    of ekAssignment:
      assignmentName*: string
      expr*: Expr
    of ekIdent:
      identName*: string
    of ekSeq:
      bodies*: seq[Expr]
    of ekIf:
      condition*: Expr
      thenClause*: Expr
      elseClause*: Expr

proc exprBinary* (op: string, lhs, rhs: Expr): Expr =
  result = Expr(kind: ekBinary)
  result[].op = op
  result[].lhs = lhs
  result[].rhs = rhs

proc exprInt* (value: int): Expr =
  result = Expr(kind: ekInt)
  result[].value = value

proc exprAssignment* (name: string, expr: Expr): Expr =
  result = Expr(kind: ekAssignment)
  result[].assignmentName = name
  result[].expr = expr

proc exprIdent* (name: string): Expr =
  result = Expr(kind: ekIdent)
  result[].identName = name

proc exprSeq* (bodies: seq[Expr]): Expr =
  result = Expr(kind: ekSeq)
  result[].bodies = bodies

proc exprIf* (condition, then, els: Expr): Expr =
  result = Expr(kind: ekIf)
  result[].condition = condition
  result[].thenClause = then
  result[].elseClause = els
