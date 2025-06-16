BOOK       := pandoc-ebook
SRC        := $(wildcard src/*.md)

DIST_DIR   := dist
DIST       := $(DIST_DIR)/$(BOOK).epub
PDF        := $(DIST_DIR)/$(BOOK).pdf

PANDOC_OPTS := \
  -f markdown \
  -t epub3 \
  --standalone \
  --metadata-file=metadata.yaml \
  --css=css/ebook.css \
  --epub-cover-image=images/cover.png \
  --toc \
  --toc-depth=2 \
  --top-level-division=chapter \
  --epub-title-page=false \
  --epub-chapter-level=1 \
  --epub-subdirectory=OEBPS \
  --epub-metadata=metadata.yaml \
  --variable=lang:ja \
  --resource-path=.:images

PDF_OPTS := \
  -f markdown+abbreviations+smart \
  -t pdf \
  --standalone \
  --metadata-file=metadata.yaml \
  --css=css/ebook.css \
  --resource-path=.:images \
  --toc --toc-depth=2 \
  --pdf-engine=xelatex \
  -V documentclass=bxjsarticle \
  -V papersize=a4 \
  -V mainfont="Hiragino Sans" \
  -V monofont="Hiragino Sans" \
  -V CJKmainfont="Hiragino Sans" \
  -V CJKmonofont="Hiragino Sans"

$(DIST): $(SRC) metadata.yaml css/ebook.css images/cover.png | $(DIST_DIR)
	pandoc $(PANDOC_OPTS) $(SRC) -o $@
	@echo "✅  Rebuilt $@"

$(PDF): $(SRC) metadata.yaml css/ebook.css images/cover.png | $(DIST_DIR)
	pandoc $(PDF_OPTS) $(SRC) -o $@
	@echo "✅  Rebuilt $@"

$(DIST_DIR):
	mkdir -p $@

watch:
	fswatch -o src css metadata.yaml | xargs -n1 -I{} make

clean:
	rm -rf $(DIST_DIR)

pdf: $(PDF)

.PHONY: watch clean pdf

