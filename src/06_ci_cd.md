---
title: "第6章: CI/CD と自動公開"
subtitle: "GitHub Actions でタグ→Release→EPUB 配布"
summary: |
  macos-15 ランナーで EPUB を自動ビルドし、epubcheck を通過したファイルだけ Release に添付します。
keywords: ["GitHub Actions", "CI/CD"]
---

# 第6章: CI/CD と自動公開

`.github/workflows/ci.yml` で以下を定義します。

```bash
name: Build eBook

on:
  push:
    tags: [ 'v*' ]   # タグを切ったときだけ実行

jobs:
  build:
    runs-on: macos-15
    steps:
      - uses: actions/checkout@v4

      - name: Install tools (Homebrew)
        run: |
          brew install pandoc epubcheck

      - name: Build EPUB
        run: make

      - name: Validate EPUB
        run: epubcheck dist/pandoc-ebook.epub

      - name: Upload to Release
        uses: softprops/action-gh-release@v2
        with:
          files: dist/pandoc-ebook.epub
```