type
  ASTKind* = enum
    akBinary
    akInt
    akAssignment
    akIdent
    akSeq
    akIf
    akWhile
    akProgram
    akFunc

  AST* = ref ASTObj

  ASTObj* = object
    case kind*: ASTKind
    of akBinary:
      op*: string
      lhs*: AST
      rhs*: AST
    of akInt:
      value*: int
    of akAssignment:
      assignmentName*: string
      ast*: AST
    of akIdent:
      identName*: string
    of akSeq:
      seqBodies*: seq[AST]
    of akIf:
      ifCondition*: AST
      ifThenClause*: AST
      ifElseClause*: AST
    of akWhile:
      whileCondition*: AST
      whileBodies*: seq[AST]
    of akProgram:
      programs*: seq[AST]
    of akFunc:
      funcName*: string
      funcParams*: seq[AST]
      funcBody*: seq[AST]

proc astBinary* (op: string, lhs, rhs: AST): AST =
  result = AST(kind: akBinary)
  result[].op = op
  result[].lhs = lhs
  result[].rhs = rhs

proc astInt* (value: int): AST =
  result = AST(kind: akInt)
  result[].value = value

proc astAssignment* (name: string, ast: AST): AST =
  result = AST(kind: akAssignment)
  result[].assignmentName = name
  result[].ast = ast

proc astIdent* (name: string): AST =
  result = AST(kind: akIdent)
  result[].identName = name

proc astSeq* (bodies: seq[AST]): AST =
  result = AST(kind: akSeq)
  result[].seqBodies = bodies

proc astIf* (condition, then, els: AST): AST =
  result = AST(kind: akIf)
  result[].ifCondition = condition
  result[].ifThenClause = then
  result[].ifElseClause = els

proc astWhile* (condition: AST, bodies: seq[AST]): AST =
  result = AST(kind: akWhile)
  result[].whileCondition = condition
  result[].whileBodies = bodies

proc astProgram* (programs: seq[AST]): AST =
  result = AST(kind: akProgram)
  result[].programs = programs

proc astFunc* (name: string, params, body: seq[AST]): AST =
  result = AST(kind: akFunc)
  result[].funcName = name
  result[].funcParams = params
  result[].funcBody = body