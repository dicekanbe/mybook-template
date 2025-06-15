--- number-chapter.lua
-- 章番号を自動付与する Pandoc Lua フィルタ
-- 使い方:
--   pandoc --lua-filter=number-chapter.lua src/*.md -o book.epub
-- オプション（メタデータ）:
--   chapter-prefix   : "第"   （既定値）
--   chapter-suffix   : "章 "  （既定値）
--   chapter-start    : 1      （既定値; 0 から始めたい場合などに）
--   unnumbered-class : "unnumbered"  （見出しに付いていればスキップ）

local chapter_counter = 0
local opts = {
  prefix   = "第",
  suffix   = "章 ",
  start    = 1,
  skip_cls = "unnumbered",
}

-- メタデータからオプションを取得
function Meta(meta)
  if meta["chapter-prefix"] then
    opts.prefix = pandoc.utils.stringify(meta["chapter-prefix"])
  end
  if meta["chapter-suffix"] then
    opts.suffix = pandoc.utils.stringify(meta["chapter-suffix"])
  end
  if meta["chapter-start"] then
    opts.start = tonumber(meta["chapter-start"]) or opts.start
  end
  if meta["unnumbered-class"] then
    opts.skip_cls = pandoc.utils.stringify(meta["unnumbered-class"])
  end
end

-- Header ブロックを変換
function Header(el)
  -- レベル 1 見出しのみ対象
  if el.level ~= 1 then
    return nil
  end

  -- クラスに skip_cls が含まれていればスキップ
  if el.classes:includes(opts.skip_cls) then
    return nil
  end

  -- カウンタを進める
  chapter_counter = chapter_counter + 1
  local number = chapter_counter + opts.start - 1
  local label  = string.format("%s%d%s", opts.prefix, number, opts.suffix)

  -- 既存のインラインの先頭に番号を挿入
  table.insert(el.content, 1, pandoc.Str(label))

  -- 見出しを返す（更新済み）
  return el
end


