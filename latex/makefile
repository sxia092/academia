# Missouri S&T Academic Portfolio Makefile
# Generates PDF portfolios from LaTeX sources

# LaTeX compiler
LATEX = pdflatex
LATEXFLAGS = -interaction=nonstopmode -file-line-error

# Main portfolio files
PORTFOLIOS = notes assignments curated complete

# Build all portfolios
all: $(PORTFOLIOS)

# Individual portfolio targets
notes: notes.pdf
assignments: assignments.pdf
curated: curated.pdf
complete: complete.pdf

# Generic rule for building PDFs
%.pdf: %.tex config.tex mst.cls
	@echo "Building $@..."
	@$(LATEX) $(LATEXFLAGS) $< > /dev/null 2>&1 || true
	@$(LATEX) $(LATEXFLAGS) $< > /dev/null 2>&1 || true
	@if [ -f $@ ]; then echo "✓ $@ built successfully"; else echo "Error: $@ not created"; exit 1; fi

# Clean temporary files but keep PDFs
clean:
	@echo "Cleaning temporary files..."
	@rm -f *.aux *.log *.out *.toc *.lof *.lot *.lol *.idx *.ilg *.ind *.bbl *.blg *.dvi *.ps
	@echo "✓ Clean complete"

# Remove all generated files including PDFs
distclean: clean
	@echo "Removing all generated PDFs..."
	@rm -f $(addsuffix .pdf,$(PORTFOLIOS))
	@echo "✓ All PDFs removed"

# Help target
help:
	@echo "Missouri S&T Academic Portfolio Build System"
	@echo ""
	@echo "Available targets:"
	@echo "  make              - Build all portfolios"
	@echo "  make notes        - Build notes portfolio"
	@echo "  make assignments  - Build assignments portfolio"
	@echo "  make curated      - Build curated portfolio"
	@echo "  make complete     - Build complete portfolio"
	@echo "  make clean        - Remove temporary build files"
	@echo "  make distclean    - Remove all generated files"
	@echo "  make help         - Show this help message"

.PHONY: all clean distclean help $(PORTFOLIOS)