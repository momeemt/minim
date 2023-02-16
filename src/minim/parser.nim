import asts
import tokens

import std/options
import std/strutils
import fusion/matching

type
  ParsedContext = (AST, seq[MinimToken])

proc parseFunction (tokens: seq[MinimToken]): Option[ParsedContext]
proc parseExpr (tokens: seq[MinimToken]): Option[ParsedContext]
proc parseIf (tokens: seq[MinimToken]): Option[ParsedContext]
proc parseWhile (tokens: seq[MinimToken]): Option[ParsedContext]
proc parseSeq (tokens: seq[MinimToken]): Option[ParsedContext]
proc parseCall (tokens: seq[MinimToken]): Option[ParsedContext]
proc parseAssignment (tokens: seq[MinimToken]): Option[ParsedContext]
proc parseRelational (tokens: seq[MinimToken]): Option[ParsedContext]
proc parseAdd (tokens: seq[MinimToken]): Option[ParsedContext]
proc parseMul (tokens: seq[MinimToken]): Option[ParsedContext]
proc parseUnary (tokens: seq[MinimToken]): Option[ParsedContext]
proc parsePrimary (tokens: seq[MinimToken]): Option[ParsedContext]

proc none (): Option[ParsedContext] =
  result = none[ParsedContext]()

proc pop (tokens: var seq[MinimToken]): MinimToken =
  result = tokens[0]
  tokens.delete(0)

proc check (tokens: seq[MinimToken], value: string): bool =
  result = (tokens.len > 0) and
           (tokens[0].kind == mtkKeyword or
            tokens[0].kind == mtkOperator) and
           (tokens[0].value == value)

proc check (tokens: seq[MinimToken], values: openArray[string]): bool =
  result = false
  for value in values:
    result = result or tokens.check(value)

proc consume (tokens: var seq[MinimToken], value: string): bool =
  result = check(tokens, value)
  if result:
    tokens.delete(0)

proc check (tokens: seq[MinimToken], kind: MinimTokenKind): bool =
  result = tokens[0].kind == kind

proc parse* (tokens: seq[MinimToken]): AST =
  result = astProgram(@[], @[])
  var tokens = tokens
  while tokens.len != 0:
    if Some(@res) ?= parseFunction(tokens):
      let (ast, newTokens) = res
      result.functions.add ast
      tokens = newTokens
    elif Some(@res) ?= parseExpr(tokens):
      let (ast, newTokens) = res
      result.programs.add ast
      tokens = newTokens
    else:
      raise newException(Exception, "パースエラー")

proc parseFunction (tokens: seq[MinimToken]): Option[ParsedContext] =
  var
    tokens = tokens
  if not tokens.consume("function"):
    return none()
  let name = if tokens.check(mtkIdent):
                let ident = tokens.pop()
                ident.value
             else:
                return none()
  if not tokens.consume("("):
    return none()
  var params = newSeq[string]()
  while tokens.check(mtkIdent):
    params.add tokens.pop().value
    if tokens.check(","):
      discard tokens.pop()
      continue
    elif tokens.check(")"):
      break
    else:
      return none()
  if not tokens.consume(")"):
    return none()
  let ast = if Some(@res) ?= parseSeq(tokens):
              let (ast, newTokens) = res
              tokens = newTokens
              ast
            else:
              return none()
  result = some((
    astFunc(name, params, ast),
    tokens
  ))

proc parseExpr (tokens: seq[MinimToken]): Option[ParsedContext] =
  var tokens = tokens
  let ast = if Some(@res) ?= parseCall(tokens):
              let (ast, newTokens) = res
              tokens = newTokens
              ast
            elif Some(@res) ?= parseAssignment(tokens):
              let (ast, newTokens) = res
              tokens = newTokens
              ast
            elif Some(@res) ?= parseRelational(tokens):
              let (ast, newTokens) = res
              tokens = newTokens
              ast
            elif Some(@res) ?= parseIf(tokens):
              let (ast, newTokens) = res
              tokens = newTokens
              ast
            elif Some(@res) ?= parseWhile(tokens):
              let (ast, newTokens) = res
              tokens = newTokens
              ast
            elif Some(@res) ?= parseSeq(tokens):
              let (ast, newTokens) = res
              tokens = newTokens
              ast
            else:
              return none()
  result = some((ast, tokens))

proc parseIf (tokens: seq[MinimToken]): Option[ParsedContext] =
  var tokens = tokens
  if not tokens.consume("if"):
    return none()
  if not tokens.consume("("):
    return none()
  let condition = if Some(@res) ?= parseExpr(tokens):
                    let (ast, newTokens) = res
                    tokens = newTokens
                    ast
                  else:
                    return none()
  if not tokens.consume(")"):
    return none()
  let then =  if Some(@res) ?= parseExpr(tokens):
                let (ast, newTokens) = res
                tokens = newTokens
                ast
              else:
                return none()
  if not tokens.consume("else"):
    return none()
  let els = if Some(@res) ?= parseExpr(tokens):
              let (ast, newTokens) = res
              tokens = newTokens
              ast
            else:
              return none()
  result = some((
    astIf(condition, then, els),
    tokens
  ))

proc parseWhile (tokens: seq[MinimToken]): Option[ParsedContext] =
  var tokens = tokens
  if not tokens.consume("while"):
    return none()
  if not tokens.consume("("):
    return none()
  let condition = if Some(@res) ?= parseExpr(tokens):
                    let (ast, newTokens) = res
                    tokens = newTokens
                    ast
                  else:
                    return none()
  if not tokens.consume(")"):
    return none()
  let body =  if Some(@res) ?= parseExpr(tokens):
                let (ast, newTokens) = res
                tokens = newTokens
                ast
              else:
                return none()
  result = some((
    astWhile(condition, body),
    tokens
  ))

proc parseSeq (tokens: seq[MinimToken]): Option[ParsedContext] =
  var tokens = tokens
  if not tokens.consume("{"):
    return none()
  var asts = @[
    if Some(@res) ?= parseExpr(tokens):
      let (ast, newTokens) = res
      tokens = newTokens
      ast
    else:
      return none()
  ]
  while not tokens.check("}"):
    asts.add  if Some(@res) ?= parseExpr(tokens):
                let (ast, newTokens) = res
                tokens = newTokens
                ast
              else:
                return none()
  if not tokens.consume("}"):
    return none()
  return some((
    astSeq(asts),
    tokens
  ))

proc parseCall (tokens: seq[MinimToken]): Option[ParsedContext] =
  var tokens = tokens
  let name = if tokens.check(mtkIdent):
                let ident = tokens.pop()
                ident.value
             else:
                return none()
  if not tokens.consume("("):
    return none()
  var params = newSeq[AST]()
  while true:
    params.add  if Some(@res) ?= parseExpr(tokens):
                  let (ast, newTokens) = res
                  tokens = newTokens
                  ast
                else:
                  return none()
    if tokens.check(")"):
      break
    if not tokens.consume(","):
      return none()
  if not tokens.consume(")"):
    return none()
  result = some((
    astCall(name, params),
    tokens
  ))

proc parseAssignment (tokens: seq[MinimToken]): Option[ParsedContext] =
  var tokens = tokens
  let name = if tokens.check(mtkIdent):
                let ident = tokens.pop()
                ident.value
             else:
                return none()
  if not tokens.consume("="):
    return none()
  let rhs = if Some(@res) ?= parseExpr(tokens):
              let (ast, newTokens) = res
              tokens = newTokens
              ast
            else:
              return none()
  result = some((
    astAssignment(name, rhs),
    tokens
  ))

proc parseRelational (tokens: seq[MinimToken]): Option[ParsedContext] =
  var
    tokens = tokens
    ast = if Some(@res) ?= parseAdd(tokens):
            let (ast, newTokens) = res
            tokens = newTokens
            ast
          else:
            return none()
  while true:
    if tokens.check(["<", "<=", ">", ">="]):
      let
        op = tokens.pop().value
        primary = if Some(@res) ?= parseAdd(tokens):
                    let (ast, newTokens) = res
                    tokens = newTokens
                    ast
                  else:
                    return none()
      ast = astBinary(op, ast, primary)
    else:
      return some((ast, tokens))

proc parseAdd (tokens: seq[MinimToken]): Option[ParsedContext] =
  var
    tokens = tokens
    ast = if Some(@res) ?= parseMul(tokens):
            let (ast, newTokens) = res
            tokens = newTokens
            ast
          else:
            return none()
  while true:
    if tokens.check(["+", "-"]):
      let
        op = tokens.pop().value
        primary = if Some(@res) ?= parseMul(tokens):
                    let (ast, newTokens) = res
                    tokens = newTokens
                    ast
                  else:
                    return none()
      ast = astBinary(op, ast, primary)
    else:
      return some((ast, tokens))

proc parseMul (tokens: seq[MinimToken]): Option[ParsedContext] =
  var
    tokens = tokens
    ast = if Some(@res) ?= parseUnary(tokens):
            let (ast, newTokens) = res
            tokens = newTokens
            ast
          else:
            return none()
  while true:
    if tokens.check(["*", "/", "%"]):
      let
        op = tokens.pop().value
        primary = if Some(@res) ?= parseUnary(tokens):
                    let (ast, newTokens) = res
                    tokens = newTokens
                    ast
                  else:
                    return none()
      ast = astBinary(op, ast, primary)
    else:
      return some((ast, tokens))

proc parseUnary (tokens: seq[MinimToken]): Option[ParsedContext] =
  var tokens = tokens
  if tokens.check("+"):
    discard tokens.pop()
    let primary = if Some(@res) ?= parsePrimary(tokens):
                    let (ast, newTokens) = res
                    tokens = newTokens
                    ast
                  else:
                    return none()
    return some((primary, tokens))
  elif tokens.check("-"):
    discard tokens.pop()
    let primary = if Some(@res) ?= parsePrimary(tokens):
                    let (ast, newTokens) = res
                    tokens = newTokens
                    ast
                  else:
                    return none()
    return some((
      astBinary("-", astInt(0), primary),
      tokens
    ))
  if Some(@res) ?= parsePrimary(tokens):
    let (ast, newTokens) = res
    tokens = newTokens
    return some((ast, tokens))
  else:
    return none()

proc parsePrimary (tokens: seq[MinimToken]): Option[ParsedContext] =
  var tokens = tokens
  if tokens.check("("):
    discard tokens.pop()
    let exp = if Some(@res) ?= parseExpr(tokens):
                let (ast, newTokens) = res
                tokens = newTokens
                ast
              else:
                return none()
    if not tokens.consume(")"):
      return none()
    return some((exp, tokens))
  if tokens.check(mtkNumber):
    let number = tokens.pop().value
    return some((astInt(number.parseInt), tokens))
  elif tokens.check(mtkIdent):
    let ident = tokens.pop().value
    return some((astIdent(ident), tokens))
  return none()
