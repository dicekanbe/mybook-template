---
title: "第3章: Pandoc のインストール"
subtitle: "Homebrew + macOS Sequoia"
summary: |
  Homebrew を使った Pandoc 3.7 系の導入と、依存ツール (epubcheck, Kindle Previewer) の設定。
keywords: ["Homebrew", "インストール"]
chapter-start: 3
---

# Pandoc のインストール

## 前提条件

### 必要な環境

- macOS Sequoia 15.5 以降
- Homebrew がインストール済み
- ターミナルアプリケーション
- 管理者権限

### Homebrew の確認

```bash
brew --version
```

Homebrew が未インストールの場合は、以下のコマンドでインストール：

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Pandoc のインストール

### 基本インストール

```bash
brew update
brew install pandoc epubcheck fswatch
brew install --cask kindle-previewer
```

### バージョン確認

```bash
pandoc --version
```

期待される出力：
```
pandoc 3.7.x
```

### 依存パッケージの確認

```bash
brew list --versions pandoc
brew list --versions epubcheck
brew list --versions fswatch
```

## 追加ツールのインストール

### LaTeX 環境（PDF 出力用）

```bash
brew install --cask mactex
```

### 画像処理ツール

```bash
brew install imagemagick
brew install librsvg
```

### その他の便利ツール

```bash
brew install watch
brew install entr
```

## 環境設定

### シェル設定

`.zshrc` または `.bash_profile` に以下を追加：

```bash
# Pandoc のパス設定
export PATH="/usr/local/bin:$PATH"

# Pandoc のデフォルトテンプレートディレクトリ
export PANDOC_TEMPLATES="$HOME/.pandoc/templates"
```

### テンプレートディレクトリの作成

```bash
mkdir -p ~/.pandoc/templates
```

## 動作確認

### 基本的な変換テスト

```bash
echo "# Hello, World!" | pandoc -f markdown -t html
```

### EPUB 生成テスト

```bash
echo "# Test Chapter" > test.md
pandoc test.md -o test.epub
```

### バリデーションテスト

```bash
epubcheck test.epub
```

## トラブルシューティング

### よくある問題と解決策

1. **パスが通っていない**
   ```bash
   echo $PATH
   # 必要に応じて .zshrc を編集
   ```

2. **権限エラー**
   ```bash
   sudo chown -R $(whoami) /usr/local/bin
   ```

3. **バージョンの不一致**
   ```bash
   brew upgrade pandoc
   ```



## 次のステップ

インストールが完了したら、次の章で執筆ワークフローの構築に進みます。主なトピック：

- Makefile の作成
- 自動ビルドの設定
- テンプレートのカスタマイズ