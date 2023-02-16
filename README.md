# minim
[![ci](https://github.com/momeemt/minim/actions/workflows/ci.yml/badge.svg)](https://github.com/momeemt/minim/actions/workflows/ci.yml)
[![docs](https://github.com/momeemt/minim/actions/workflows/docs.yml/badge.svg)](https://github.com/momeemt/minim/actions/workflows/docs.yml)
[![deploy](https://github.com/momeemt/minim/actions/workflows/pages/pages-build-deployment/badge.svg)](https://github.com/momeemt/minim/actions/workflows/pages/pages-build-deployment)

[GB27001 ソフトウェアサイエンス特別講義A](https://kdb.tsukuba.ac.jp/syllabi/2022/GB27001/jpn/0)の講義で紹介された、[minis](https://github.com/kmizu/minis)のNim実装です。

## インストール
```sh
nimble install https://github.com/momeemt/minim
```

## 実行
`path`オプションにminimファイルのパスを指定します。

```minim
result = 2023
result
```

```sh
minim --path hello.minim # 2023
```

## 文法
minimは関数定義・関数呼び出し・`if`式・`while`式・連接・代入式・比較演算子・四則演算子・モジュロ演算子をサポートし、値は全て数値です。
詳細な定義については[minim.ebnf](https://github.com/momeemt/minim/blob/main/minim.ebnf)を確認してください。

また、プログラムの最後に評価された値が標準出力に出力されます。

### 関数定義・関数呼び出し
`function`キーワードで関数を定義します。0個以上の仮引数と連接を受け取ります。
また、すでに定義した関数は`()`演算子と0個以上の実引数を渡すことで呼び出すことができます。

次のプログラムは、`8`と評価されます。

```
function f (i) {
  i + 1
  i + 2
  i + 3
}

f(5)
```

### 代入式
識別子に対して値を代入できます。代入式自身も、代入された値を返します。

次のプログラムは、`1`と評価されます。

```
hello = 1
hello
```

### `if`式・`while`式
条件式は、`0`の場合は偽、`0`以外の場合は真を取ります。
`if`式は`if`、`else`それぞれの最後に評価された式の値を返します。`while`式は最後に評価された式の値を返します。
`if`式は`else`句を省略できないことに注意してください。

次のプログラムは`25`と評価されます。

```
result = 0
i = 1
while (i < 10) {
  if (i % 2) {
    result = result + i
  } else {
    0
  }
  i = i + 1
}
result
```

### 比較・四則演算・モジュロ演算
四則演算子は、`+`、`-`、`*`、`/`です。
モジュロ演算子は`%`です。
比較演算子は、`<`、`<=`、`>`、`>=`をサポートしており、真の場合は`1`を、偽の場合は`0`を返します。

かっこ`()`で囲われた式の優先度が最も高く、次に単項演算子`+`・`-`、乗除演算・モジュロ演算、加減演算、比較演算子と続きます。

次のプログラムは`2`と評価されます。

```
(10 * 2 + 12 / 3 - (4 > -2)) % 7 + (3 < 2)
```

## APIドキュメント
minimの字句解析器・構文解析器・評価器をライブラリとして提供しています。

- [APIドキュメント](https://momeemt.github.io/minim/minim.html)

## ライセンス
minimはApache-2.0 Licenseでライセンスされています。

## 作者
- [momeemt](https://github.com/momeemt)