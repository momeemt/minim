import tokens

from std/options import Option, some, none
import fusion/matching

type
  SeparatedString = tuple[head: string, tail: string]

func separate* (program: string, len: int): Option[SeparatedString] =
  if program.len < len:
    return none[SeparatedString]()
  var separatedString = (head: "", tail: "")
  separatedString.head = program[0..(len-1)]
  separatedString.tail = program[len..program.high]
  result = some(separatedString)

proc consumeKeyword* (program: var string, token: string): bool =
  if Some(@ss) ?= separate(program, token.len):
    let (head, tail) = ss
    if head == token and $tail[0] in CloseableTokens:
      program = tail
      return true
  return false

proc consumeOperator* (program: var string, token: string): bool =
  if Some(@ss) ?= separate(program, token.len):
    let (head, tail) = ss
    if head == token:
      program = tail
      return true
  return false

proc consumeNumber* (program: var string): (bool, string) =
  var
    number = ""
    tmp = program
  while true:
    if Some(@ss) ?= separate(tmp, 1):
      let (head, tail) = ss
      if head in Digits:
        tmp = tail
        number &= head
        continue
      elif head in CloseableTokens:
        program = tmp
        return (true, number)
      else:
        return (false, "")
    program = tmp
    return (true, number)

proc consumeIdent* (program: var string): (bool, string) =
  var ident = ""
  if $program[0] notin IdentStarts:
    return (false, "")
  while true:
    if Some(@ss) ?= separate(program, 1):
      let (head, tail) = ss
      if head in Idents:
        program = tail
        ident &= head
        continue
      return (true, ident)
    return (true, ident)

proc skipWhitespace* (program: var string): bool =
  result = false
  while true:
    if Some(@ss) ?= separate(program, 1):
      let (head, tail) = ss
      if head in Whitespaces:
        program = tail
        result = true
        continue
      return
    return

proc tokenize* (program: string): seq[MinimToken] =
  var program = program
  while program != "":
    block consume:
      if skipWhitespace(program):
        continue
      for keyword in MinimKeywords:
        if consumeKeyword(program, keyword):
          result.add mtKeyword(keyword)
          break consume
      for operator in MinimOperators:
        if consumeOperator(program, operator):
          result.add mtOperator(operator)
          break consume
      block:
        let (res, number) = consumeNumber(program)
        if res:
          result.add mtNumber(number)
          continue
      block:
        let (res, ident) = consumeIdent(program)
        if res:
          result.add mtIdent(ident)
          continue
      raise newException(Exception, "解釈不能: " & program[0])
