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

```sh
minim --path hello.minim # 25
```

## APIドキュメント
minimの字句解析器・構文解析器・評価器をライブラリとして提供しています。

- [APIドキュメント](https://momeemt.github.io/minim/minim.html)
