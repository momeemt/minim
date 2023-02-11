type
  ASTKind* = enum
    ekBinary
    ekInt
    ekAssignment
    ekIdent
    ekSeq
    ekIf
    ekWhile
    ekProgram

  AST* = ref ASTObj

  ASTObj* = object
    case kind*: ASTKind
    of ekBinary:
      op*: string
      lhs*: AST
      rhs*: AST
    of ekInt:
      value*: int
    of ekAssignment:
      assignmentName*: string
      expr*: AST
    of ekIdent:
      identName*: string
    of ekSeq:
      seqBodies*: seq[AST]
    of ekIf:
      ifCondition*: AST
      ifThenClause*: AST
      ifElseClause*: AST
    of ekWhile:
      whileCondition*: AST
      whileBodies*: seq[AST]
    of ekProgram:
      programs*: seq[AST]

proc exprBinary* (op: string, lhs, rhs: AST): AST =
  result = AST(kind: ekBinary)
  result[].op = op
  result[].lhs = lhs
  result[].rhs = rhs

proc exprInt* (value: int): AST =
  result = AST(kind: ekInt)
  result[].value = value

proc exprAssignment* (name: string, expr: AST): AST =
  result = AST(kind: ekAssignment)
  result[].assignmentName = name
  result[].expr = expr

proc exprIdent* (name: string): AST =
  result = AST(kind: ekIdent)
  result[].identName = name

proc exprSeq* (bodies: seq[AST]): AST =
  result = AST(kind: ekSeq)
  result[].seqBodies = bodies

proc exprIf* (condition, then, els: AST): AST =
  result = AST(kind: ekIf)
  result[].ifCondition = condition
  result[].ifThenClause = then
  result[].ifElseClause = els

proc exprWhile* (condition: AST, bodies: seq[AST]): AST =
  result = AST(kind: ekWhile)
  result[].whileCondition = condition
  result[].whileBodies = bodies

proc exprProgram* (programs: seq[AST]): AST =
  result = AST(kind: ekProgram)
  result[].programs = programs