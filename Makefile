BOOK       := pandoc-ebook
SRC        := $(wildcard src/*.md)

DIST_DIR   := dist
DIST       := $(DIST_DIR)/$(BOOK).epub
PDF        := $(DIST_DIR)/$(BOOK).pdf
DOCX       := $(DIST_DIR)/$(BOOK).docx


# PANDOC_OPTS := \
#   -f markdown \
#   -t epub3 \
#   --standalone \
#   --metadata-file=metadata.yaml \
#   --css=css/ebook.css \
#   --epub-cover-image=images/cover.png \
#   --lua-filter=filters/number-chapter.lua \
#   --toc \
#   --toc-depth=2 \
#   --variable=lang:ja \
#   --resource-path=.:images


# PANDOC_OPTS := \
#   -f markdown \
#   -t epub3 \
#   --standalone \
#   --metadata-file=metadata.yaml \
#   --css=css/ebook.css \
#   --lua-filter=filters/number-chapter.lua \
#   --toc \
#   --toc-depth=2 \
#   --epub-cover-image=images/cover.png \
#   --top-level-division=chapter \
#   --variable=lang:ja \
#   --resource-path=.:images

# markdown+grid_tables+multiline_tables \

PANDOC_OPTS := \
  -f markdown+grid_tables+multiline_tables  \
  -t epub3 \
  --standalone \
  --lua-filter=filters/number-chapter.lua \
  --template=templates/default.epub \
  --metadata-file=metadata.yaml \
  --no-highlight \
  --toc \
  --toc-depth=2 \
  --top-level-division=chapter \
  --variable=lang:ja \
  --resource-path=.:images \
  --css=css/base.css \
  --css=css/ibooks.css \
  --css=css/kindle.css 

DOCX_OPTS := \
  -f markdown+grid_tables+multiline_tables  \
  -t docx \
  --standalone \
  --lua-filter=filters/number-chapter.lua \
  --metadata-file=metadata.yaml \
  --no-highlight \
  --toc \
  --toc-depth=2 \
  --top-level-division=chapter \
  --variable=lang:ja \
  --resource-path=.:images 

PDF_OPTS := \
  -f markdown+abbreviations+smart \
  -t pdf \
  --standalone \
  --metadata-file=metadata.yaml \
  --resource-path=.:images \
  --toc --toc-depth=2 \
  --pdf-engine=xelatex \
  -V documentclass=bxjsarticle \
  -V papersize=a4 \
  -V mainfont="Hiragino Sans" \
  -V monofont="Hiragino Sans" \
  -V CJKmainfont="Hiragino Sans" \
  -V CJKmonofont="Hiragino Sans"

$(DIST): $(SRC) metadata.yaml images/cover.png css/base.css css/kindle.css css/ibooks.css templates/default.epub | $(DIST_DIR)
	pandoc $(PANDOC_OPTS) $(SRC) title.txt -o $@
	@echo "✅  Rebuilt $@"

$(PDF): $(SRC) metadata.yaml images/cover.png | $(DIST_DIR)
	pandoc $(PDF_OPTS) $(SRC) -o $@
	@echo "✅  Rebuilt $@"

$(DOCX): $(SRC) metadata.yaml images/cover.png | $(DIST_DIR)
	pandoc $(DOCX_OPTS) $(SRC) -o $@
	@echo "✅  Rebuilt $@"

$(DIST_DIR):
	mkdir -p $@

watch:
	fswatch -o src css metadata.yaml | xargs -n1 -I{} make

clean:
	rm -rf $(DIST_DIR)

pdf: $(PDF)
docx: $(DOCX)

.PHONY: watch clean pdf docx

