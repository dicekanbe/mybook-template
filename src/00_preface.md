---
title: "はじめに"
author: "Abe Daisuke"
date: "2025-06-15"
summary: |
  本書の背景と目的、読者に期待する前提知識、全体構成を簡潔に紹介します。
keywords: ["Preface", "Pandoc", "電子書籍"]
---

# はじめに

## 本書の背景と目的
本書では **Markdown + Pandoc** を用いて、原稿を "1 コマンド" で EPUB に変換し、
KDP にアップロードするまでの完全ワークフローを解説します。  
対象は **macOS Sequoia 15.5** 以降で Homebrew を利用できるエンジニア/クリエイター。

### 本書で扱う内容

- Pandoc のインストールと基本コマンド
- Markdown 拡張記法とベストプラクティス
- Makefile + fswatch による自動ビルド
- Kindle Previewer／Apple Books を使ったプレビュー
- GitHub Actions で CI/CD & 自動出版
