# Pandoc 電書入門

Markdown + Pandoc を用いて、原稿を "1 コマンド" で EPUB に変換し、KDP にアップロードするまでの完全ワークフローを解説する電子書籍テンプレートです。

## 特徴

- Markdown で原稿を執筆
- Pandoc による EPUB 生成
- Makefile + fswatch による自動ビルド
- Kindle Previewer／Apple Books を使ったプレビュー
- GitHub Actions で CI/CD & 自動出版

## 必要条件

- macOS Sequoia 15.5 以降
- Homebrew
- Pandoc
- XeLaTeX (PDF生成用)

## セットアップ

1. リポジトリをクローン
```bash
git clone https://github.com/yourusername/pandoc-ebook-template.git
cd pandoc-ebook-template
```

2. 必要なツールをインストール
```bash
# Pandoc のインストール
brew install pandoc

# PDF生成に必要な XeLaTeX のインストール
brew install texlive
```

## 使用方法

### EPUB の生成

```bash
make clean && make
```

### PDF の生成

```bash
make pdf
```

### ファイル監視と自動ビルド

```bash
make watch
```

## プロジェクト構造

```
.
├── src/                    # 原稿ファイル
│   ├── 00_preface.md      # はじめに
│   ├── 01_intro.md        # 導入
│   └── ...
├── css/                    # スタイルシート
│   └── ebook.css          # EPUB用CSS
├── images/                 # 画像ファイル
│   └── cover.png          # 表紙画像
├── dist/                   # 生成ファイル
│   ├── pandoc-ebook.epub  # EPUBファイル
│   └── pandoc-ebook.pdf   # PDFファイル
├── Makefile               # ビルド設定
└── metadata.yaml          # メタデータ
```

## カスタマイズ

### メタデータの編集

`metadata.yaml` を編集して、書籍のタイトル、著者、ISBN などを設定します。

### スタイルのカスタマイズ

`css/ebook.css` を編集して、EPUB のスタイルをカスタマイズできます。
