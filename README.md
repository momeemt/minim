# minim
[![build](https://github.com/momeemt/minim/actions/workflows/build.yml/badge.svg)](https://github.com/momeemt/minim/actions/workflows/build.yml)

ini ← この辺が泣き顔に見えて  
m ← これが甲殻類系の手足に見えるので  
minim ← かなり、泣いてるカニ

## これはカニですか？
残念ながら、カニではありません。これは、簡易なインタプリタです。
抽象構文木を与えると、計算を行います。

```nim
assert(
    tProgram(
      tFunc("add", @["a", "b"], tAdd(tId("a"), tId("b"))),
      tCall("add", tInt(1), tInt(2))
    ).evaluate() == 3
)
```

[GB27001 ソフトウェアサイエンス特別講義A](https://kdb.tsukuba.ac.jp/syllabi/2022/GB27001/jpn/0)の講義で紹介された、[minis](https://github.com/kmizu/minis)のNim実装です。

## 泣いているなんて、可哀想だとは思いませんか？
> m'n'm  
> 泣いていて可哀想だったので泣き止ませました

これを見た[友人](https://github.com/uekann)が泣き止ませてくれました。よかったですね。
