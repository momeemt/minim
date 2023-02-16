import minim/tokenizer
import minim/parser
import minim/evals

proc run* (program: string): int =
  result = program.tokenize().parse().evaluate()

proc runCommand (path: string): int =
  let program = block:
    let f = open(path)
    defer: f.close()
    f.readAll
  echo run(program)
  return 0

when isMainModule:
  import cligen
  dispatch(runCommand, help = {"path": "実行するminimファイルのパスを与えてください"})
