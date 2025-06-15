---
title: "第3章: Pandoc のインストール"
subtitle: "Homebrew + macOS Sequoia"
summary: |
  Homebrew を使った Pandoc 3.7 系の導入と、依存ツール (epubcheck, Kindle Previewer) の設定。
keywords: ["Homebrew", "インストール"]
---

# 第3章: Pandoc のインストール

```bash
brew update
brew install pandoc epubcheck fswatch
brew install --cask kindle-previewer
```

インストール後、pandoc --version が 3.7.x であることを確認します。