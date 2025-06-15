---
title: "第2章: Markdown 基礎（フロントマター）"
subtitle: "Pandoc 拡張記法と注意点"
summary: |
  見出し・リスト・表・脚注など、Pandoc がサポートする Markdown 拡張を押さえます。
keywords: ["Markdown", "Pandoc extensions"]
---

# 第2章: Markdown 基礎（本文）

Markdown はシンプルですが、Pandoc ではさらに以下の拡張が利用できます。

| 機能               | 記法例                                   |
|--------------------|------------------------------------------|
| 脚注               | `これは脚注[^1]`                         |
| 図表キャプション   | `![図: フロー](images/flow.svg){#fig:flow}` |
| 定義リスト         | `用語 : 説明`                            |

![図: フロー](images/flow.svg){#fig:flow}

[^1]: フッター部分に自動で脚注が生成されます。

