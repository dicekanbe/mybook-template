# 第7章: トラブルシューティング

## 7.1 インストール関連の問題

### 基本的な問題

| 症状                                   | 原因                                   | 解決策                                     |
|----------------------------------------|----------------------------------------|--------------------------------------------|
| `pandoc: command not found`            | パスが通っていない / インストール漏れ | `brew install pandoc` 後シェルを再起動    |
| EPUBcheck で RSC-004 エラー            | `nav.xhtml` の MIME 宣言漏れ           | Pandoc 3.7 以上へのアップグレード         |
| Kindle Previewer 起動直後にクラッシュ  | 設定ファイル破損                       | `~/Library/Application Support/Kindle Previewer` を削除 |

### 詳細な対処法

1. **Pandoc の再インストール**
   ```bash
   brew uninstall pandoc
   brew install pandoc
   ```

2. **依存関係の確認**
   ```bash
   brew deps pandoc
   ```

3. **バージョンの確認**
   ```bash
   pandoc --version
   ```

## 7.2 ビルド時の問題

### 一般的なエラー

1. **メモリ不足**
   ```bash
   # メモリ制限を緩和
   pandoc --pdf-engine=xelatex --variable mainfont="Hiragino Sans" --variable CJKmainfont="Hiragino Sans"
   ```

2. **フォントの問題**
   ```bash
   # フォントの確認
   fc-list :lang=ja
   ```

3. **画像の変換エラー**
   ```bash
   # ImageMagick の再インストール
   brew reinstall imagemagick
   ```

### デバッグ方法

1. **詳細なログ出力**
   ```bash
   pandoc --verbose input.md -o output.epub
   ```

2. **中間ファイルの確認**
   ```bash
   pandoc --standalone input.md -o output.html
   ```

3. **エラーメッセージの解析**
   ```bash
   pandoc 2>&1 | grep -i error
   ```

## 7.3 プレビュー関連の問題

### Kindle Previewer の問題

1. **起動しない**
   ```bash
   # キャッシュの削除
   rm -rf ~/Library/Caches/com.amazon.kindlepreviewer
   ```

2. **表示が崩れる**
   ```bash
   # メタデータの確認
   pandoc --print-default-data-file reference.epub
   ```

3. **文字化け**
   ```bash
   # 文字エンコーディングの確認
   file -I input.md
   ```

### Apple Books の問題

1. **同期エラー**
   ```bash
   # ライブラリのリセット
   defaults delete com.apple.iBooksX
   ```

2. **表示の問題**
   ```bash
   # メタデータの修正
   pandoc --metadata-file=metadata.yaml input.md -o output.epub
   ```

## 7.4 KDP アップロードの問題

### 一般的なエラー

1. **ファイルサイズ制限**
   ```bash
   # 画像の最適化
   find . -name "*.png" -exec convert {} -strip -quality 85 {} \;
   ```

2. **メタデータの不整合**
   ```bash
   # メタデータの検証
   epubcheck book.epub
   ```

3. **カバー画像の問題**
   ```bash
   # 画像サイズの確認
   identify cover.jpg
   ```

### 解決策

1. **ファイルの最適化**
   ```bash
   # EPUB の最適化
   pandoc --standalone --toc input.md -o output.epub
   ```

2. **メタデータの修正**
   ```bash
   # メタデータの更新
   pandoc --metadata-file=metadata.yaml input.md -o output.epub
   ```

## 7.5 パフォーマンスの問題

### ビルド時間の最適化

1. **キャッシュの活用**
   ```bash
   # キャッシュディレクトリの設定
   export PANDOC_CACHE_DIR=~/.pandoc/cache
   ```

2. **並列処理の活用**
   ```makefile
   # Makefile での並列処理
   .NOTPARALLEL:
   ```

3. **不要な処理の削除**
   ```bash
   # 最小限のオプションでビルド
   pandoc --standalone input.md -o output.epub
   ```

## 7.6 演習問題

1. 以下のエラーを解決してください：
   - `pandoc: command not found`
   - EPUBcheck での RSC-004 エラー
   - Kindle Previewer のクラッシュ

2. ビルド時の問題を特定し、解決する方法を説明してください。

3. KDP アップロード時の問題を解決する手順を説明してください。

## 7.7 次のステップ

次の章では、以下のトピックについて学びます：

- 付録：参考資料
- 用語集
- 索引

