from std/sugar import `=>`
from std/sequtils import toSeq, map
from std/strutils import Whitespace, Digits, IdentStartChars, IdentChars

type
  MinimTokenKind* = enum
    mtkIdent
    mtkOperator
    mtkNumber
    mtkKeyword

  MinimToken* = object
    kind*: MinimTokenKind
    value*: string

const
  MinimOperators* = @["<=", "<", ">=", ">", "=", "+", "-", "*", "/", ",", "(", ")", "{", "}"]
  MinimKeywords* = @["if", "else", "while", "function"]
  Digits* = Digits.toSeq.map(d => $d)
  Whitespaces* = Whitespace.toSeq.map(w => $w)
  Idents* = IdentChars.toSeq.map(i => $i)
  IdentStarts* = IdentStartChars.toSeq.map(i => $i)
  CloseableTokens* = Whitespaces & MinimOperators

func mtIdent* (ident: string): MinimToken =
  result = MinimToken(kind: mtkIdent, value: ident)

func mtOperator* (op: string): MinimToken =
  result = MinimToken(kind: mtkOperator, value: op)

func mtNumber* (num: string): MinimToken =
  result = MinimToken(kind: mtkNumber, value: num)

func mtKeyword* (kw: string): MinimToken =
  result = MinimToken(kind: mtkKeyword, value: kw)
