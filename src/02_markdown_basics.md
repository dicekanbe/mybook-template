---
title: "第2章: Markdown 基礎（フロントマター）"
subtitle: "Pandoc 拡張記法と注意点"
summary: |
  見出し・リスト・表・脚注など、Pandoc がサポートする Markdown 拡張を押さえます。
keywords: ["Markdown", "Pandoc extensions"]
chapter-start: 2
---

# Markdown 基礎（本文）

Markdown はシンプルですが、Pandoc ではさらに以下の拡張が利用できます。

## 基本的な記法

### 見出し

```markdown
# 見出し1
## 見出し2
### 見出し3
```

### リスト

```markdown
- 箇条書き1
- 箇条書き2
  - ネスト1
  - ネスト2

1. 番号付きリスト1
2. 番号付きリスト2
```

### 強調

```markdown
*イタリック*
**太字**
***太字イタリック***
```

## Pandoc 拡張記法

### 表

| 機能               | 記法例                                   |
|--------------------|------------------------------------------|
| 脚注               | `これは脚注[^1]`                         |
| 図表キャプション   | `![図: フロー](images/flow.svg){#fig:flow}` |
| 定義リスト         | `用語 : 説明`                            |

### 脚注

脚注は以下のように記述します：

```markdown
これは脚注の例です[^1]。

[^1]: フッター部分に自動で脚注が生成されます。
```

### 図表

```markdown
![図: フロー](images/flow.svg){#fig:flow}

図 @fig:flow は、ワークフローの全体像を示しています。
```

## 高度な機能

### 数式

インライン数式：
```markdown
$E = mc^2$
```

ブロック数式：
```markdown
$$
\frac{d}{dx}e^x = e^x
$$
```

### コードブロック

```python
def hello():
    print("Hello, World!")
```

### 引用

```markdown
> これは引用です。
> 
> 複数行の引用も可能です。
```

## メタデータ

### YAML フロントマター

```yaml
---
title: "章タイトル"
author: "著者名"
date: "2025-06-15"
keywords: ["キーワード1", "キーワード2"]
---
```

### 変数

```markdown
$title$ は $author$ によって書かれました。
```

## ベストプラクティス

### ファイル構成

```
book/
├── src/
│   ├── 00_preface.md
│   ├── 01_chapter1.md
│   └── images/
│       └── flow.svg
├── templates/
│   └── default.epub
└── Makefile
```

### 命名規則

- ファイル名：`XX_chapter.md`（XX は章番号）
- 画像ファイル：`figure-XX.svg`（XX は連番）
- 変数名：`snake_case`

### 推奨設定

```yaml
---
documentclass: book
toc: true
number-sections: true
highlight-style: tango
---
```

## 演習問題

1. 以下の要素を含む Markdown ファイルを作成してください：
   - 見出し（3レベル）
   - 表
   - 脚注
   - 図表参照

2. 数式を含む Markdown ファイルを作成し、Pandoc で PDF に変換してください。

3. 複数の Markdown ファイルを結合して1つの EPUB を生成する方法を説明してください。





