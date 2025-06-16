DIST_DIR   := dist
BOOK       := pandoc-ebook
SRC        := $(wildcard src/*.md)
COMBINED   := $(DIST_DIR)/combined.md

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
  --epub-title-page=false \
  --epub-metadata=metadata.yaml \
  --variable=lang:ja \
  --resource-path=.:images

# PANDOC_OPTS := \
#   -f markdown \
#   -t epub3 \
#   --standalone \
#   --metadata-file=metadata.yaml \
#   --css=css/ebook.css \
#   --epub-cover-image=images/cover.png \
#   --toc \
#   --toc-depth=2 \
#   --epub-title-page=false \
#   --epub-chapter-level=1 \
#   --epub-subdirectory=OEBPS \
#   --epub-metadata=metadata.yaml \
#   --variable=lang:ja \
#   --resource-path=.:images

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

$(COMBINED): $(SRC) | $(DIST_DIR)
	cat src/00_preface.md \
	    src/01_intro.md \
	    src/02_markdown_basics.md \
	    src/03_pandoc_install.md \
	    src/04_workflow_setup.md \
	    src/05_advanced_features.md \
	    src/06_ci_cd.md \
	    src/07_troubleshooting.md \
	    src/99_appendix.md > $@
	@echo "✅  Combined markdown files into $@"

$(DIST): $(COMBINED) metadata.yaml css/ebook.css images/cover.png | $(DIST_DIR)
	pandoc $(PANDOC_OPTS) $< -o $@
	@echo "✅  Rebuilt $@"

$(PDF): $(COMBINED) metadata.yaml css/ebook.css images/cover.png | $(DIST_DIR)
	pandoc $(PDF_OPTS) $< -o $@
	@echo "✅  Rebuilt $@"

$(DIST_DIR):
	mkdir -p $@

watch:
	fswatch -o src css metadata.yaml | xargs -n1 -I{} make

clean:
	rm -rf $(DIST_DIR)

pdf: $(PDF)
epub: $(DIST)

.PHONY: watch clean pdf epub

