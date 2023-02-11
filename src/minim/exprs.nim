type
  ExprKind* = enum
    ekBinary
    ekInt
    ekAssignment
    ekIdent
    ekSeq
    ekIf
    ekWhile
    ekProgram

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
      seqBodies*: seq[Expr]
    of ekIf:
      ifCondition*: Expr
      ifThenClause*: Expr
      ifElseClause*: Expr
    of ekWhile:
      whileCondition*: Expr
      whileBodies*: seq[Expr]
    of ekProgram:
      programs*: seq[Expr]

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
  result[].seqBodies = bodies

proc exprIf* (condition, then, els: Expr): Expr =
  result = Expr(kind: ekIf)
  result[].ifCondition = condition
  result[].ifThenClause = then
  result[].ifElseClause = els

proc exprWhile* (condition: Expr, bodies: seq[Expr]): Expr =
  result = Expr(kind: ekWhile)
  result[].whileCondition = condition
  result[].whileBodies = bodies

proc exprProgram* (programs: seq[Expr]): Expr =
  result = Expr(kind: ekProgram)
  result[].programs = programs