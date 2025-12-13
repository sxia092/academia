# CS5402 Data Mining - Build System
# Graduate-level data mining course with theoretical assignments and R/Julia scripts.
# Contains 6 homework assignments and 2 tests with statistical analysis components.
#
# Available targets:
#   make build              - Verify all source files exist
#   make build TARGET=X     - Verify specific homework
#   make run TARGET=X       - Run specific R/Julia script
#   make autorun TARGET=X   - Run with default parameters
#   make list               - List available targets
#   make clean              - Remove temporary files
#   make help               - Display this help message
#
# Note: homework-5 and homework-6 contain R and Julia scripts.
#       Other assignments are LaTeX theoretical work only.

# ==============================================================================
# Configuration
# ==============================================================================

# Color output for better readability
RED = \033[0;31m
GREEN = \033[0;32m
YELLOW = \033[1;33m
CYAN = \033[1;36m
NC = \033[0m

# Available targets
TARGETS = homework1 homework2 homework3 homework4 homework5 homework6 test1 test2

# ==============================================================================
# Main Targets
# ==============================================================================

.PHONY: all help build run autorun list clean

# Default target
all: help

# Help target - displays available commands
help:
	@echo "$(CYAN)CS5402 Data Mining - Build System$(NC)"
	@echo "$(YELLOW)Graduate-level data mining course$(NC)"
	@echo ""
	@echo "$(YELLOW)Usage:$(NC)"
	@echo "  make build              - Verify all source files"
	@echo "  make build TARGET=X     - Verify specific homework"
	@echo "  make run TARGET=X       - Run specific R/Julia script"
	@echo "  make autorun TARGET=X   - Run with default parameters"
	@echo "  make list               - List available targets"
	@echo "  make clean              - Remove temporary files"
	@echo ""
	@echo "$(YELLOW)Available Targets:$(NC)"
	@echo "  homework1  - Data mining fundamentals (LaTeX)"
	@echo "  homework2  - Pattern discovery (LaTeX)"
	@echo "  homework3  - Classification (LaTeX)"
	@echo "  homework4  - Clustering (LaTeX)"
	@echo "  homework5  - Statistical analysis (R scripts)"
	@echo "  homework6  - Advanced analysis (R/Julia scripts)"
	@echo "  test1      - Midterm exam (LaTeX)"
	@echo "  test2      - Final exam (LaTeX)"
	@echo ""
	@echo "$(YELLOW)Note:$(NC) R and Julia are required for homework5/6"

# List available targets
list:
	@echo "$(CYAN)Available targets:$(NC)"
	@for target in $(TARGETS); do \
		echo "  $$target"; \
	done

# ==============================================================================
# Build Targets (Verification)
# ==============================================================================

.PHONY: build

build:
ifdef TARGET
	@$(MAKE) --no-print-directory build_$(TARGET)
else
	@echo "$(CYAN)Verifying all source files...$(NC)"
	@$(MAKE) --no-print-directory build_homework1
	@$(MAKE) --no-print-directory build_homework2
	@$(MAKE) --no-print-directory build_homework3
	@$(MAKE) --no-print-directory build_homework4
	@$(MAKE) --no-print-directory build_homework5
	@$(MAKE) --no-print-directory build_homework6
	@$(MAKE) --no-print-directory build_test1
	@$(MAKE) --no-print-directory build_test2
	@echo "$(GREEN)All source files verified!$(NC)"
endif

build_homework1:
	@echo "$(CYAN)Verifying homework1...$(NC)"
	@if [ -f "homework-1/homework-1.tex" ]; then \
		echo "$(GREEN)✓ homework1: LaTeX document$(NC)"; \
	else \
		echo "$(RED)Error: homework1 not found$(NC)"; \
		exit 1; \
	fi

build_homework2:
	@echo "$(CYAN)Verifying homework2...$(NC)"
	@if [ -f "homework-2/homework-2.tex" ]; then \
		echo "$(GREEN)✓ homework2: LaTeX document$(NC)"; \
	else \
		echo "$(RED)Error: homework2 not found$(NC)"; \
		exit 1; \
	fi

build_homework3:
	@echo "$(CYAN)Verifying homework3...$(NC)"
	@if [ -f "homework-3/homework-3.tex" ]; then \
		echo "$(GREEN)✓ homework3: LaTeX document$(NC)"; \
	else \
		echo "$(RED)Error: homework3 not found$(NC)"; \
		exit 1; \
	fi

build_homework4:
	@echo "$(CYAN)Verifying homework4...$(NC)"
	@if [ -f "homework-4/homework-4.tex" ]; then \
		echo "$(GREEN)✓ homework4: LaTeX document$(NC)"; \
	else \
		echo "$(RED)Error: homework4 not found$(NC)"; \
		exit 1; \
	fi

build_homework5:
	@echo "$(CYAN)Verifying homework5...$(NC)"
	@if [ -f "homework-5/homework-5.tex" ]; then \
		r_count=$$(find homework-5/src -name "*.r" 2>/dev/null | wc -l | tr -d ' '); \
		echo "$(GREEN)✓ homework5: LaTeX + $$r_count R scripts$(NC)"; \
	else \
		echo "$(RED)Error: homework5 not found$(NC)"; \
		exit 1; \
	fi

build_homework6:
	@echo "$(CYAN)Verifying homework6...$(NC)"
	@if [ -f "homework-6/homework-6.tex" ]; then \
		r_count=$$(find homework-6/src -name "*.r" 2>/dev/null | wc -l | tr -d ' '); \
		jl_count=$$(find homework-6/src -name "*.jl" 2>/dev/null | wc -l | tr -d ' '); \
		echo "$(GREEN)✓ homework6: LaTeX + $$r_count R + $$jl_count Julia scripts$(NC)"; \
	else \
		echo "$(RED)Error: homework6 not found$(NC)"; \
		exit 1; \
	fi

build_test1:
	@echo "$(CYAN)Verifying test1...$(NC)"
	@if [ -f "test-1/test-1.tex" ]; then \
		echo "$(GREEN)✓ test1: LaTeX document$(NC)"; \
	else \
		echo "$(RED)Error: test1 not found$(NC)"; \
		exit 1; \
	fi

build_test2:
	@echo "$(CYAN)Verifying test2...$(NC)"
	@if [ -f "test-2/test-2.tex" ]; then \
		echo "$(GREEN)✓ test2: LaTeX document$(NC)"; \
	else \
		echo "$(RED)Error: test2 not found$(NC)"; \
		exit 1; \
	fi

# ==============================================================================
# Run Targets
# ==============================================================================

.PHONY: run autorun

run:
ifdef TARGET
	@if [ "$(TARGET)" = "homework5" ]; then \
		echo "$(CYAN)Homework 5 - R Scripts$(NC)"; \
		echo "$(YELLOW)Available scripts:$(NC)"; \
		ls -1 homework-5/src/*.r 2>/dev/null | xargs -I {} basename {} || echo "  (none)"; \
		echo ""; \
		echo "$(YELLOW)Run with: Rscript homework-5/src/<script>.r$(NC)"; \
	elif [ "$(TARGET)" = "homework6" ]; then \
		echo "$(CYAN)Homework 6 - R/Julia Scripts$(NC)"; \
		echo "$(YELLOW)R scripts:$(NC)"; \
		ls -1 homework-6/src/*.r 2>/dev/null | xargs -I {} basename {} || echo "  (none)"; \
		echo "$(YELLOW)Julia scripts:$(NC)"; \
		ls -1 homework-6/src/*.jl 2>/dev/null | xargs -I {} basename {} || echo "  (none)"; \
		echo ""; \
		echo "$(YELLOW)Run R with: Rscript homework-6/src/<script>.r$(NC)"; \
		echo "$(YELLOW)Run Julia with: julia homework-6/src/<script>.jl$(NC)"; \
	else \
		echo "$(YELLOW)$(TARGET) contains LaTeX documents only$(NC)"; \
		echo "$(YELLOW)Compile with: pdflatex <file>.tex$(NC)"; \
	fi
else
	@echo "$(YELLOW)Available targets:$(NC)"
	@for target in $(TARGETS); do \
		echo "  $$target"; \
	done
	@echo ""
	@echo "$(YELLOW)Usage: make run TARGET=<target>$(NC)"
endif

autorun:
ifdef TARGET
	@if [ "$(TARGET)" = "homework5" ]; then \
		echo "$(CYAN)Running homework5 R scripts...$(NC)"; \
		if command -v Rscript >/dev/null 2>&1; then \
			for script in homework-5/src/*.r; do \
				echo "$(YELLOW)Running $$(basename $$script)...$(NC)"; \
				Rscript "$$script" 2>/dev/null || echo "$(RED)R not configured$(NC)"; \
			done; \
		else \
			echo "$(RED)Rscript not found. Install R to run scripts.$(NC)"; \
		fi \
	elif [ "$(TARGET)" = "homework6" ]; then \
		echo "$(CYAN)Running homework6 scripts...$(NC)"; \
		echo "$(YELLOW)R scripts:$(NC)"; \
		if command -v Rscript >/dev/null 2>&1; then \
			for script in homework-6/src/*.r; do \
				echo "  Running $$(basename $$script)..."; \
				Rscript "$$script" 2>/dev/null || echo "$(RED)Script failed$(NC)"; \
			done; \
		else \
			echo "$(RED)  Rscript not found$(NC)"; \
		fi; \
		echo "$(YELLOW)Julia scripts:$(NC)"; \
		if command -v julia >/dev/null 2>&1; then \
			for script in homework-6/src/*.jl; do \
				echo "  Running $$(basename $$script)..."; \
				julia "$$script" 2>/dev/null || echo "$(RED)Script failed$(NC)"; \
			done; \
		else \
			echo "$(RED)  Julia not found$(NC)"; \
		fi \
	else \
		$(MAKE) --no-print-directory run TARGET=$(TARGET); \
	fi
else
	@echo "$(YELLOW)Running homework5 as default...$(NC)"
	@$(MAKE) --no-print-directory autorun TARGET=homework5
endif

# ==============================================================================
# Clean Target
# ==============================================================================

clean:
	@echo "$(YELLOW)Cleaning temporary files...$(NC)"
	@find . -name "*.aux" -delete 2>/dev/null || true
	@find . -name "*.log" -delete 2>/dev/null || true
	@find . -name "*.out" -delete 2>/dev/null || true
	@find . -name "*.synctex*" -delete 2>/dev/null || true
	@find . -name "*.fls" -delete 2>/dev/null || true
	@find . -name "*.fdb_latexmk" -delete 2>/dev/null || true
	@echo "$(GREEN)Clean complete.$(NC)"
