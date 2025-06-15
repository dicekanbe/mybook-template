---
title: "第1章: 電子書籍制作の全体像"
subtitle: "Pandoc ワークフローを俯瞰する"
summary: |
  EPUB フォーマットの基本と Pandoc の立ち位置を理解し、制作フロー全体をイメージする。
keywords: ["EPUB", "ワークフロー"]
---

# 第1章: 電子書籍制作の全体像

電子書籍フォーマットには EPUB、PDF、かつて主流だった MOBI などがありますが、
**2025 年時点で Kindle も EPUB ネイティブ対応**となり、事実上 EPUB が標準です。

## 1.1 なぜ Pandoc なのか？

- **多フォーマット変換**：EPUB/PDF/HTML/DOCX を同時出力  
- **OSS エコシステム**：Lua フィルタやクロスリファレンスなど拡張が豊富  
- **CI/CD 連携**：GitHub Actions や GitLab CI で自動化しやすい  

