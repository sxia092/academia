# CS5200 Analysis of Algorithms - Build System
# This graduate-level course covers algorithm analysis with Python implementations.
# Contains 8 homework assignments and a final exam with formal proofs.
#
# Available targets:
#   make build              - Verify all Python source files exist
#   make build TARGET=X     - Verify specific homework
#   make run TARGET=X       - Run a specific homework's problems
#   make autorun TARGET=X   - Run with default inputs
#   make list               - List available targets
#   make clean              - Remove Python cache files
#   make help               - Display this help message

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
TARGETS = homework1 homework2 homework3 homework4 homework7 homework8 final

# ==============================================================================
# Main Targets
# ==============================================================================

.PHONY: all help build run autorun list clean

# Default target
all: help

# Help target - displays available commands
help:
	@echo "$(CYAN)CS5200 Analysis of Algorithms - Build System$(NC)"
	@echo "$(YELLOW)Graduate-level algorithm analysis course$(NC)"
	@echo ""
	@echo "$(YELLOW)Usage:$(NC)"
	@echo "  make build              - Verify all Python source files"
	@echo "  make build TARGET=X     - Verify specific homework"
	@echo "  make run TARGET=X       - Run specific homework problems"
	@echo "  make autorun TARGET=X   - Run with default inputs"
	@echo "  make list               - List available targets"
	@echo "  make clean              - Remove Python cache files"
	@echo ""
	@echo "$(YELLOW)Available Targets:$(NC)"
	@echo "  homework1  - Sorting and searching algorithms"
	@echo "  homework2  - Recurrence relations"
	@echo "  homework3  - Divide and conquer"
	@echo "  homework4  - Dynamic programming"
	@echo "  homework7  - Graph algorithms"
	@echo "  homework8  - Advanced algorithms"
	@echo "  final      - Final exam problems"
	@echo ""
	@echo "$(YELLOW)Note:$(NC) Homework 5 & 6 contain only LaTeX proofs"

# List available targets
list:
	@echo "$(CYAN)Available targets:$(NC)"
	@for target in $(TARGETS); do \
		echo "  $$target"; \
	done

# ==============================================================================
# Build Targets (Python - verification only)
# ==============================================================================

.PHONY: build

build:
ifdef TARGET
	@$(MAKE) --no-print-directory build_$(TARGET)
else
	@echo "$(CYAN)Verifying all Python source files...$(NC)"
	@$(MAKE) --no-print-directory build_homework1
	@$(MAKE) --no-print-directory build_homework2
	@$(MAKE) --no-print-directory build_homework3
	@$(MAKE) --no-print-directory build_homework4
	@$(MAKE) --no-print-directory build_homework7
	@$(MAKE) --no-print-directory build_homework8
	@$(MAKE) --no-print-directory build_final
	@echo "$(GREEN)All Python files verified!$(NC)"
endif

build_homework1:
	@echo "$(CYAN)Verifying homework1...$(NC)"
	@count=0; \
	for f in homework-1/source/*.py; do \
		if [ -f "$$f" ]; then \
			count=$$((count + 1)); \
		fi; \
	done; \
	echo "$(GREEN)✓ homework1: $$count Python files$(NC)"

build_homework2:
	@echo "$(CYAN)Verifying homework2...$(NC)"
	@count=0; \
	for f in homework-2/source/*.py; do \
		if [ -f "$$f" ]; then \
			count=$$((count + 1)); \
		fi; \
	done; \
	echo "$(GREEN)✓ homework2: $$count Python files$(NC)"

build_homework3:
	@echo "$(CYAN)Verifying homework3...$(NC)"
	@count=0; \
	for f in homework-3/source/*.py; do \
		if [ -f "$$f" ]; then \
			count=$$((count + 1)); \
		fi; \
	done; \
	echo "$(GREEN)✓ homework3: $$count Python files$(NC)"

build_homework4:
	@echo "$(CYAN)Verifying homework4...$(NC)"
	@count=0; \
	for f in homework-4/source/*.py; do \
		if [ -f "$$f" ]; then \
			count=$$((count + 1)); \
		fi; \
	done; \
	echo "$(GREEN)✓ homework4: $$count Python files$(NC)"

build_homework7:
	@echo "$(CYAN)Verifying homework7...$(NC)"
	@count=0; \
	for f in homework-7/source/*.py; do \
		if [ -f "$$f" ]; then \
			count=$$((count + 1)); \
		fi; \
	done; \
	echo "$(GREEN)✓ homework7: $$count Python files$(NC)"

build_homework8:
	@echo "$(CYAN)Verifying homework8...$(NC)"
	@count=0; \
	for f in homework-8/source/*.py; do \
		if [ -f "$$f" ]; then \
			count=$$((count + 1)); \
		fi; \
	done; \
	echo "$(GREEN)✓ homework8: $$count Python files$(NC)"

build_final:
	@echo "$(CYAN)Verifying final exam...$(NC)"
	@count=0; \
	for f in final-exam/source/*.py; do \
		if [ -f "$$f" ]; then \
			count=$$((count + 1)); \
		fi; \
	done; \
	echo "$(GREEN)✓ final: $$count Python files$(NC)"

# ==============================================================================
# Run Targets
# ==============================================================================

.PHONY: run autorun

run:
ifdef TARGET
	@if [ "$(TARGET)" = "homework1" ]; then \
		echo "$(CYAN)Homework 1 - Sorting and Searching$(NC)"; \
		echo "$(YELLOW)Available problems:$(NC)"; \
		ls -1 homework-1/source/*.py 2>/dev/null | xargs -I {} basename {} .py || echo "  (none)"; \
		echo ""; \
		echo "$(YELLOW)Run with: python3 homework-1/source/<problem>.py$(NC)"; \
	elif [ "$(TARGET)" = "homework2" ]; then \
		echo "$(CYAN)Homework 2 - Recurrence Relations$(NC)"; \
		echo "$(YELLOW)Available problems:$(NC)"; \
		ls -1 homework-2/source/*.py 2>/dev/null | xargs -I {} basename {} .py || echo "  (none)"; \
		echo ""; \
		echo "$(YELLOW)Run with: python3 homework-2/source/<problem>.py$(NC)"; \
	elif [ "$(TARGET)" = "homework3" ]; then \
		echo "$(CYAN)Homework 3 - Divide and Conquer$(NC)"; \
		echo "$(YELLOW)Available problems:$(NC)"; \
		ls -1 homework-3/source/*.py 2>/dev/null | xargs -I {} basename {} .py || echo "  (none)"; \
		echo ""; \
		echo "$(YELLOW)Run with: python3 homework-3/source/<problem>.py$(NC)"; \
	elif [ "$(TARGET)" = "homework4" ]; then \
		echo "$(CYAN)Homework 4 - Dynamic Programming$(NC)"; \
		echo "$(YELLOW)Available problems:$(NC)"; \
		ls -1 homework-4/source/*.py 2>/dev/null | xargs -I {} basename {} .py || echo "  (none)"; \
		echo ""; \
		echo "$(YELLOW)Run with: python3 homework-4/source/<problem>.py$(NC)"; \
	elif [ "$(TARGET)" = "homework7" ]; then \
		echo "$(CYAN)Homework 7 - Graph Algorithms$(NC)"; \
		echo "$(YELLOW)Available problems:$(NC)"; \
		ls -1 homework-7/source/*.py 2>/dev/null | xargs -I {} basename {} .py || echo "  (none)"; \
		echo ""; \
		echo "$(YELLOW)Run with: python3 homework-7/source/<problem>.py$(NC)"; \
	elif [ "$(TARGET)" = "homework8" ]; then \
		echo "$(CYAN)Homework 8 - Advanced Algorithms$(NC)"; \
		echo "$(YELLOW)Available problems:$(NC)"; \
		ls -1 homework-8/source/*.py 2>/dev/null | xargs -I {} basename {} .py || echo "  (none)"; \
		echo ""; \
		echo "$(YELLOW)Run with: python3 homework-8/source/<problem>.py$(NC)"; \
	elif [ "$(TARGET)" = "final" ]; then \
		echo "$(CYAN)Final Exam$(NC)"; \
		echo "$(YELLOW)Available problems:$(NC)"; \
		ls -1 final-exam/source/*.py 2>/dev/null | xargs -I {} basename {} .py || echo "  (none)"; \
		echo ""; \
		echo "$(YELLOW)Run with: python3 final-exam/source/<problem>.py$(NC)"; \
	else \
		echo "$(RED)Error: Unknown target '$(TARGET)'$(NC)"; \
		exit 1; \
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
	@if [ "$(TARGET)" = "homework1" ]; then \
		echo "$(CYAN)Running homework1 sample (question-3.py)...$(NC)"; \
		python3 homework-1/source/question-3.py; \
	elif [ "$(TARGET)" = "homework7" ]; then \
		echo "$(CYAN)Running homework7 sample (problem-1.py)...$(NC)"; \
		python3 homework-7/source/problem-1.py; \
	elif [ "$(TARGET)" = "final" ]; then \
		echo "$(CYAN)Running final exam sample (problem-2.py)...$(NC)"; \
		python3 final-exam/source/problem-2.py; \
	else \
		$(MAKE) --no-print-directory run TARGET=$(TARGET); \
	fi
else
	@echo "$(YELLOW)Running homework1 sample...$(NC)"
	@$(MAKE) --no-print-directory autorun TARGET=homework1
endif

# ==============================================================================
# Clean Target
# ==============================================================================

clean:
	@echo "$(YELLOW)Cleaning Python cache files...$(NC)"
	@find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	@find . -type f -name "*.pyc" -delete 2>/dev/null || true
	@echo "$(GREEN)Clean complete.$(NC)"
