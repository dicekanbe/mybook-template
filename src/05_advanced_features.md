---
title: "第5章: 高度なカスタマイズ"
subtitle: "Lua フィルタとクロスリファレンス"
summary: |
  pandoc-crossref と Lua フィルタで図表番号、相互参照、目次カスタマイズを行います。
keywords: ["Lua filter", "crossref"]
chapter-start: 5
---

# 高度なカスタマイズ

## pandoc-crossref の導入

### インストール

```bash
brew install pandoc-crossref
```

### 基本的な使用方法

```markdown
# 図表の参照
![図: ワークフロー](images/workflow.svg){#fig:workflow}
図 @fig:workflow は、全体のワークフローを示しています。

# 数式の参照
$$
E = mc^2
$$ {#eq:energy}
式 @eq:energy は、アインシュタインの有名な方程式です。
```

## Lua フィルタの作成

### 基本的な Lua フィルタ

`filters/custom.lua`:

```lua
-- カスタム Lua フィルタ
function Header(elem)
    -- 見出しの前後に区切り線を追加
    if elem.level == 1 then
        return {
            pandoc.RawBlock('html', '<hr>'),
            elem,
            pandoc.RawBlock('html', '<hr>')
        }
    end
    return elem
end

function Image(elem)
    -- 画像にキャプションを追加
    if not elem.caption then
        elem.caption = {pandoc.Str("図: " .. elem.src)}
    end
    return elem
end
```

### フィルタの適用

```makefile
# Makefile に追加
LUA_FILTERS = filters/custom.lua

$(DIST_DIR)/mybook.epub: $(SRC_FILES_SORTED) $(METADATA)
	pandoc \
		--lua-filter=$(LUA_FILTERS) \
		--output=$@ \
		$(SRC_FILES_SORTED)
```

## 目次のカスタマイズ

### 目次レベルの設定

```yaml
---
toc: true
toc-depth: 3
number-sections: true
---
```

### 目次のスタイリング

```css
/* templates/custom.css に追加 */
nav#toc {
    background-color: #f8f9fa;
    padding: 1em;
    border-radius: 5px;
}

nav#toc ol {
    list-style-type: none;
    padding-left: 1em;
}

nav#toc li {
    margin: 0.5em 0;
}
```

## 高度な相互参照

### 図表番号の自動付与

```yaml
---
figPrefix: "図"
eqnPrefix: "式"
tblPrefix: "表"
---
```

### セクション参照

```markdown
# 導入 {#sec:intro}

セクション @sec:intro では、基本的な概念を説明します。
```

## カスタムテンプレート

### EPUB テンプレートの拡張

```html
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>$title$</title>
    <link rel="stylesheet" href="custom.css">
    $for(header-includes)$
    $header-includes$
    $endfor$
</head>
<body>
    <header>
        <h1>$title$</h1>
        $if(author)$
        <p class="author">$author$</p>
        $endif$
    </header>
    
    $if(toc)$
    <nav id="toc">
        $toc$
    </nav>
    $endif$
    
    <main>
        $body$
    </main>
    
    <footer>
        <p>© $date$ $author$</p>
    </footer>
</body>
</html>
```

## 演習問題

1. 以下の機能を持つ Lua フィルタを作成してください：
   - コードブロックに言語名を表示
   - 脚注のスタイルをカスタマイズ
   - 表に自動的に番号を付与

2. pandoc-crossref を使用して、以下の要素を含む文書を作成してください：
   - 図表の相互参照
   - 数式の参照
   - セクションの参照

3. カスタムテンプレートを作成し、以下の要素を追加してください：
   - ヘッダーとフッター
   - 目次のスタイリング
   - メタデータの表示

## トラブルシューティング

### よくある問題

1. **Lua フィルタのエラー**
   ```bash
   pandoc --lua-filter=filter.lua --verbose
   ```

2. **相互参照の失敗**
   ```bash
   pandoc --filter pandoc-crossref --verbose
   ```

3. **テンプレートのパス問題**
   ```bash
   pandoc --print-default-template epub3 > template.epub
   ```

## 次のステップ

次の章では、以下のトピックについて学びます：

- GitHub Actions による自動ビルド
- リリースの自動化
- 品質チェックの自動化

