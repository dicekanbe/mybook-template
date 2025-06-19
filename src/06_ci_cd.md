---
title: "第6章: CI/CD と自動公開"
subtitle: "GitHub Actions でタグ→Release→EPUB 配布"
summary: |
  macos-15 ランナーで EPUB を自動ビルドし、epubcheck を通過したファイルだけ Release に添付します。
keywords: ["GitHub Actions", "CI/CD"]
chapter-start: 6
---

# CI/CD と自動公開

## GitHub Actions の基本

### ワークフローの構成

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

## 高度なワークフロー設定

### 複数フォーマットのビルド

```yaml
name: Build eBook

on:
  push:
    tags: [ 'v*' ]

jobs:
  build:
    runs-on: macos-15
    steps:
      - uses: actions/checkout@v4

      - name: Install tools
        run: |
          brew install pandoc epubcheck
          brew install --cask mactex

      - name: Build EPUB
        run: make epub

      - name: Build PDF
        run: make pdf

      - name: Validate EPUB
        run: epubcheck dist/pandoc-ebook.epub

      - name: Upload to Release
        uses: softprops/action-gh-release@v2
        with:
          files: |
            dist/pandoc-ebook.epub
            dist/pandoc-ebook.pdf
```

### キャッシュの活用

```yaml
      - name: Cache LaTeX packages
        uses: actions/cache@v3
        with:
          path: ~/Library/texlive
          key: ${{ runner.os }}-texlive-${{ hashFiles('**/*.tex') }}
          restore-keys: |
            ${{ runner.os }}-texlive-
```

## 品質チェックの自動化

### リンクチェック

```yaml
      - name: Check links
        uses: gaurav-nelson/github-action-markdown-link-check@v1
        with:
          use-quiet-mode: 'yes'
          use-verbose-mode: 'yes'
          folder-path: 'src'
```

### スペルチェック

```yaml
      - name: Check spelling
        uses: rojopolis/spellcheck-github-actions@0.24.0
        with:
          source_files: src/*.md
          language: en_US,ja_JP
```

## リリース管理

### バージョン管理

```yaml
      - name: Get version
        id: get_version
        run: echo "VERSION=${GITHUB_REF#refs/tags/}" >> $GITHUB_ENV

      - name: Update version in metadata
        run: |
          sed -i '' "s/date:.*/date: \"$(date +%Y-%m-%d)\"/" metadata.yaml
          sed -i '' "s/version:.*/version: \"${{ env.VERSION }}\"/" metadata.yaml
```

### リリースノートの生成

```yaml
      - name: Generate changelog
        uses: actions/github-script@v6
        with:
          script: |
            const { data: commits } = await github.rest.repos.compareCommits({
              owner: context.repo.owner,
              repo: context.repo.repo,
              base: 'v1.0.0',
              head: context.sha
            });
            
            const changelog = commits.commits
              .map(commit => `- ${commit.commit.message}`)
              .join('\n');
            
            await github.rest.repos.createRelease({
              owner: context.repo.owner,
              repo: context.repo.repo,
              tag_name: context.ref.replace('refs/tags/', ''),
              body: changelog
            });
```

## セキュリティ対策

### シークレットの管理

```yaml
      - name: Deploy to KDP
        env:
          KDP_API_KEY: ${{ secrets.KDP_API_KEY }}
          KDP_API_SECRET: ${{ secrets.KDP_API_SECRET }}
        run: |
          # KDP API を使用したデプロイ処理
```

### 依存関係のスキャン

```yaml
      - name: Security scan
        uses: snyk/actions/node@master
        env:
          SNYK_TOKEN: ${{ secrets.SNYK_TOKEN }}
```

## 演習問題

1. 以下の機能を持つ GitHub Actions ワークフローを作成してください：
   - EPUB と PDF の自動ビルド
   - 品質チェック（リンク、スペル）
   - リリースの自動作成

2. リリースノートを自動生成するワークフローを作成してください。

3. セキュリティスキャンを組み込んだワークフローを作成してください。

## トラブルシューティング

### よくある問題

1. **ビルドの失敗**
   ```bash
   # ローカルで再現
   make clean && make
   ```

2. **キャッシュの問題**
   ```bash
   # キャッシュをクリア
   rm -rf ~/Library/texlive
   ```

3. **権限エラー**
   ```bash
   # シークレットの確認
   echo $KDP_API_KEY
   ```

## 次のステップ

次の章では、以下のトピックについて学びます：

- トラブルシューティング
- パフォーマンス最適化
- メンテナンスとアップデート