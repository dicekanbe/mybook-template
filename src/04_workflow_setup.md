---
title: "第4章: 執筆ワークフローの構築"
subtitle: "Makefile と自動ビルド"
summary: |
  Makefile と fswatch を用いて、保存と同時に EPUB を再生成するホットリロード環境を作ります。
keywords: ["Makefile", "fswatch", "自動ビルド"]
chapter-start: 4
---

# 執筆ワークフローの構築

## プロジェクト構造

### 推奨ディレクトリ構成

```
mybook/
├── src/
│   ├── 00_preface.md
│   ├── 01_chapter1.md
│   ├── 02_chapter2.md
│   └── images/
│       ├── figure-01.svg
│       └── figure-02.png
├── templates/
│   ├── default.epub
│   └── custom.css
├── dist/
│   ├── mybook.epub
│   └── mybook.pdf
├── Makefile
└── metadata.yaml
```

### メタデータファイル

`metadata.yaml` の例：

```yaml
---
title: "Pandoc で作る電子書籍"
author: "著者名"
date: "2025-06-15"
language: "ja"
publisher: "出版社名"
rights: "© 2025 著者名"
---
```

## Makefile の作成

### 基本的な Makefile

```
# 変数定義
SRC_DIR = src
DIST_DIR = dist
TEMPLATE_DIR = templates
METADATA = metadata.yaml

# ソースファイル
SRC_FILES = $(wildcard $(SRC_DIR)/*.md)
SRC_FILES_SORTED = $(sort $(SRC_FILES))

# ターゲット
all: epub pdf

# EPUB 生成
epub: $(DIST_DIR)/mybook.epub

$(DIST_DIR)/mybook.epub: $(SRC_FILES_SORTED) $(METADATA)
	@mkdir -p $(DIST_DIR)
	pandoc \
		--from markdown \
		--to epub3 \
		--template=$(TEMPLATE_DIR)/default.epub \
		--metadata-file=$(METADATA) \
		--css=$(TEMPLATE_DIR)/custom.css \
		--output=$@ \
		$(SRC_FILES_SORTED)

# PDF 生成
pdf: $(DIST_DIR)/mybook.pdf

$(DIST_DIR)/mybook.pdf: $(SRC_FILES_SORTED) $(METADATA)
	@mkdir -p $(DIST_DIR)
	pandoc \
		--from markdown \
		--to pdf \
		--template=$(TEMPLATE_DIR)/default.tex \
		--metadata-file=$(METADATA) \
		--output=$@ \
		$(SRC_FILES_SORTED)

# クリーンアップ
clean:
	rm -rf $(DIST_DIR)/*

.PHONY: all epub pdf clean
```

## 自動ビルドの設定

### fswatch による監視

```bash
# 監視スクリプト
watch.sh:
#!/bin/bash
fswatch -o src/ | while read; do
    make epub
done
```

### 実行権限の付与

```bash
chmod +x watch.sh
```

## テンプレートのカスタマイズ

### EPUB テンプレート

`templates/default.epub` の例：

```html
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>$title$</title>
    <link rel="stylesheet" href="custom.css">
</head>
<body>
    $body$
</body>
</html>
```

### CSS カスタマイズ

`templates/custom.css` の例：

```css
body {
    font-family: "Hiragino Sans", "Hiragino Kaku Gothic ProN", sans-serif;
    line-height: 1.6;
    margin: 2em;
}

h1 {
    font-size: 2em;
    border-bottom: 1px solid #ccc;
    padding-bottom: 0.3em;
}

img {
    max-width: 100%;
    height: auto;
}
```

## 高度な機能

### 目次の自動生成

```makefile
# 目次生成ルールを追加
toc: $(DIST_DIR)/toc.md

$(DIST_DIR)/toc.md: $(SRC_FILES_SORTED)
	@mkdir -p $(DIST_DIR)
	pandoc \
		--from markdown \
		--to markdown \
		--toc \
		--toc-depth=3 \
		--output=$@ \
		$(SRC_FILES_SORTED)
```

### 画像の最適化

```makefile
# 画像最適化ルール
optimize-images:
	find $(SRC_DIR)/images -type f -name "*.png" -exec convert {} -strip -quality 85 {} \;
```

## 演習問題

1. 上記の Makefile を実装し、以下のコマンドが動作することを確認してください：
   - `make epub`
   - `make pdf`
   - `make clean`

2. fswatch を使用して、ファイルの変更を監視するスクリプトを作成してください。

3. カスタム CSS を作成し、以下の要素をスタイリングしてください：
   - 見出し
   - コードブロック
   - 表
   - 脚注

## トラブルシューティング

### よくある問題

1. **パーミッションエラー**
   ```bash
   chmod -R 755 src/
   ```

2. **依存関係のエラー**
   ```bash
   make clean && make
   ```

3. **テンプレートのパスエラー**
   ```bash
   pandoc --print-default-template epub3 > templates/default.epub
   ```

## 次のステップ

次の章では、以下の高度な機能について学びます：

- Lua フィルタの作成
- クロスリファレンスの設定
- 目次のカスタマイズ
