---
title: "付録: 参考資料・用語集"
subtitle: "参考資料・用語集"
summary: |
  pandoc-crossref と Lua フィルタで図表番号、相互参照、目次カスタマイズを行います。
keywords: ["Lua filter", "crossref"]
chapter-start: 8
---

# 付録: 用語集

## A.1 基本用語

| 用語          | 意味・説明                                   |
|---------------|----------------------------------------------|
| **EPUB 3**    | 国際電子出版フォーラム (IDPF) が策定した電子書籍標準 |
| **CSL**       | Citation Style Language。Pandoc の文献引用書式 |
| **Lua フィルタ** | Pandoc の中間 AST を Lua で操作する拡張機能 |

## A.2 技術用語

| 用語          | 意味・説明                                   |
|---------------|----------------------------------------------|
| **AST**       | Abstract Syntax Tree。文書の構造を表現する木構造 |
| **YAML**      | データ記述言語。Pandoc のメタデータに使用     |
| **XHTML**     | XML ベースの HTML。EPUB の本文に使用         |

## A.3 ツール関連

| 用語          | 意味・説明                                   |
|---------------|----------------------------------------------|
| **Pandoc**    | 文書変換ツール。Markdown から EPUB への変換に使用 |
| **epubcheck** | EPUB ファイルの検証ツール                    |
| **fswatch**   | ファイル変更監視ツール。自動ビルドに使用     |

# 参考リンク

## B.1 公式ドキュメント

- Pandoc 公式ドキュメント <https://pandoc.org/>
- Kindle Publishing Guidelines <https://kdp.amazon.com/>
- EPUB 3 仕様書 <https://www.w3.org/publishing/epub3/>

## B.2 ツールとライブラリ

- Homebrew <https://brew.sh/>
- GitHub Actions <https://docs.github.com/actions>
- Lua フィルタ <https://pandoc.org/lua-filters.html>

## B.3 コミュニティリソース

- Pandoc ユーザーグループ <https://groups.google.com/forum/#!forum/pandoc-discuss>
- Stack Overflow の Pandoc タグ <https://stackoverflow.com/questions/tagged/pandoc>
- GitHub の Pandoc リポジトリ <https://github.com/jgm/pandoc>

# 索引

## C.1 コマンド一覧

| コマンド | 説明 | ページ |
|----------|------|--------|
| `pandoc` | 文書変換 | 15 |
| `epubcheck` | EPUB 検証 | 25 |
| `fswatch` | ファイル監視 | 45 |

## C.2 設定ファイル

| ファイル | 説明 | ページ |
|----------|------|--------|
| `metadata.yaml` | メタデータ | 30 |
| `Makefile` | ビルド設定 | 40 |
| `custom.css` | スタイル設定 | 50 |

## C.3 トラブルシューティング

| 問題 | 解決策 | ページ |
|------|--------|--------|
| ビルドエラー | キャッシュクリア | 100 |
| プレビュー問題 | 設定リセット | 110 |
| アップロード失敗 | メタデータ修正 | 120 |

# 謝辞

本書の執筆にあたり、以下の方々に感謝の意を表します：

- Pandoc 開発チーム
- 電子書籍制作コミュニティ
- 技術書執筆の先達

# 著者プロフィール

## 略歴

- 2020年: 技術書執筆開始
- 2022年: 電子書籍出版
- 2025年: 本書執筆

## 連絡先

- メール: author@example.com
- Twitter: @author
- GitHub: github.com/author
