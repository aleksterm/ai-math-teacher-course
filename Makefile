# Build targets for the AI-in-education course handbook
# Canonical sources live in ./docs (Markdown). Output artifacts go to ./build.

OUTDIR := build

# Build syllabus and each module as separate documents.
SOURCES := \
	docs/01_syllabus.md \
	$(wildcard docs/modules/*.md)

PANDOC := pandoc


# Optional: provide a reference DOCX to control styles
DOCX_REFERENCE := templates/reference.docx

# If the reference file exists, Pandoc will use it; otherwise it will fall back to defaults.
DOCX_REF_FLAG := $(if $(wildcard $(DOCX_REFERENCE)),--reference-doc=$(DOCX_REFERENCE),)

# Optional: provide a PDF engine (xelatex is common if you have TeX installed)

PDF_ENGINE := xelatex

.ONESHELL:

.PHONY: all docx pdf clean check sanitize

all: docx pdf

check:
	@$(PANDOC) --version >/dev/null 2>&1 || (echo "Pandoc is not installed or not on PATH." && exit 1)

sanitize:
	python3 scripts/sanitize.py

$(OUTDIR):
	@mkdir -p $(OUTDIR)

# Build each source into its own DOCX
$(OUTDIR)/%.docx: %.md check | $(OUTDIR)
	@mkdir -p $(dir $@)
	$(PANDOC) $< \
		-o $@ \
		--resource-path=.:docs:assets \
		--number-sections \
		--toc \
		$(DOCX_REF_FLAG)

# Build each source into its own PDF
$(OUTDIR)/%.pdf: %.md check | $(OUTDIR)
	@mkdir -p $(dir $@)
	$(PANDOC) $< \
		-o $@ \
		--resource-path=.:docs:assets \
		--pdf-engine=$(PDF_ENGINE) \
		--template=templates/academic.tex \
		--number-sections \
		--toc \
		--metadata=lang:uk-UA \
		--metadata=figurePlacement:H

# Build all documents separately

docx: $(SOURCES:%.md=$(OUTDIR)/%.docx)

pdf: $(SOURCES:%.md=$(OUTDIR)/%.pdf)

clean:
	rm -rf $(OUTDIR)
