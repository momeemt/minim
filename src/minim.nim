import minim/tokenizer
import minim/parser
import minim/evals

proc run* (program: string): int =
  result = program.tokenize().parse().evaluate()
