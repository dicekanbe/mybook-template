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
local section_counter = {}
local in_unnumbered_chapter = false  -- 番号なし章内かどうかのフラグ
local opts = {
  prefix   = "第",
  suffix   = "章 ",
  start    = 1,
  skip_cls = "unnumbered",
}

-- ファイル毎のメタデータを格納
local current_file_opts = {}

-- メタデータからオプションを取得（グローバル設定のみ）
function Meta(meta)
  -- メタデータの値を取得（文字列に変換）
  local function get_meta_value(key)
    if meta[key] then
      if meta[key].t == "MetaString" then
        return meta[key].text
      elseif meta[key].t == "MetaInlines" then
        return pandoc.utils.stringify(meta[key])
      elseif meta[key].t == "MetaBlocks" then
        return pandoc.utils.stringify(meta[key])
      end
    end
    return nil
  end

  -- 各オプションを取得（最初に読み込まれたもののみを使用）
  local prefix = get_meta_value("chapter-prefix")
  if prefix then opts.prefix = prefix end

  local suffix = get_meta_value("chapter-suffix")
  if suffix then opts.suffix = suffix end

  local start = get_meta_value("chapter-start")
  if start then opts.start = tonumber(start) or opts.start end

  local skip_cls = get_meta_value("unnumbered-class")
  if skip_cls then opts.skip_cls = skip_cls end
  
  -- デバッグ用（必要に応じてコメントアウト）
  -- print("Meta processed: prefix=" .. opts.prefix .. ", start=" .. opts.start)
end

-- Header ブロックを変換
function Header(el)
  -- レベル 1〜3 を対象にしたい場合
  if el.level > 3 then return nil end

  -- レベル1の場合、unnumberedフラグを更新
  if el.level == 1 then
    if el.classes:includes(opts.skip_cls) then
      in_unnumbered_chapter = true
      return nil  -- 番号なし章なので早期リターン
    else
      in_unnumbered_chapter = false
      chapter_counter = chapter_counter + 1
      -- 章が変わったら節カウンターをリセット
      section_counter = {}
    end
  end

  -- 番号なし章内の場合、すべての見出しをスキップ
  if in_unnumbered_chapter then
    return nil
  end

  -- 個別の見出しに「unnumbered」クラスがあればスキップ
  if el.classes:includes(opts.skip_cls) then return nil end

  -- 節番号の更新
  section_counter[el.level] = (section_counter[el.level] or 0) + 1
  -- 下位レベルはリセット
  for i = el.level + 1, 6 do section_counter[i] = 0 end

  local label
  if el.level == 1 then
    local chapter_num = chapter_counter + opts.start - 1
    label = string.format("%s%d%s", opts.prefix, chapter_num, opts.suffix)
  elseif el.level == 2 then
    -- 「第1.2節」のように章番号.節番号形式
    local chapter_num = chapter_counter + opts.start - 1
    label = string.format("%d.%d ", chapter_num, section_counter[2])
  elseif el.level == 3 then
    -- 「第1.2.3項」のように章番号.節番号.項番号形式
    local chapter_num = chapter_counter + opts.start - 1
    label = string.format("%d.%d.%d ", chapter_num, section_counter[2], section_counter[3])
  end

  table.insert(el.content, 1, pandoc.Str(label))
  return el
end
