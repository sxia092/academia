# MATH3304 Differential Equations - Build System
# This course contains a Python-based differential equation plotter.
# The plotter generates graphs and exports them to LaTeX documents.
#
# Available targets:
#   make build              - Verify Python source files exist
#   make run TARGET=X       - Run specific target
#   make autorun TARGET=X   - Run with default parameters
#   make list               - List available targets
#   make clean              - Remove generated files
#   make help               - Display this help message
#
# Note: Requires numpy and matplotlib for plotting.

# ==============================================================================
# Configuration
# ==============================================================================

# Directories
PLOTTER_DIR = plotter

# Color output for better readability
RED = \033[0;31m
GREEN = \033[0;32m
YELLOW = \033[1;33m
CYAN = \033[1;36m
NC = \033[0m

# Available targets
TARGETS = plotter

# ==============================================================================
# Main Targets
# ==============================================================================

.PHONY: all help build run autorun list clean

# Default target
all: help

# Help target - displays available commands
help:
	@echo "$(CYAN)MATH3304 Differential Equations - Build System$(NC)"
	@echo "$(YELLOW)Differential equation plotting tool$(NC)"
	@echo ""
	@echo "$(YELLOW)Usage:$(NC)"
	@echo "  make build              - Verify Python source files"
	@echo "  make run TARGET=X       - Run specific target"
	@echo "  make autorun TARGET=X   - Run with default parameters"
	@echo "  make list               - List available targets"
	@echo "  make clean              - Remove generated files"
	@echo ""
	@echo "$(YELLOW)Available Targets:$(NC)"
	@echo "  plotter  - Differential equation plotter (Python)"
	@echo ""
	@echo "$(YELLOW)Note:$(NC) Requires numpy and matplotlib"

# List available targets
list:
	@echo "$(CYAN)Available targets:$(NC)"
	@echo "  plotter"

# ==============================================================================
# Build Targets (Verification)
# ==============================================================================

.PHONY: build

build:
ifdef TARGET
	@$(MAKE) --no-print-directory build_$(TARGET)
else
	@echo "$(CYAN)Verifying all source files...$(NC)"
	@$(MAKE) --no-print-directory build_plotter
	@echo "$(GREEN)All source files verified!$(NC)"
endif

build_plotter:
	@echo "$(CYAN)Verifying plotter...$(NC)"
	@if [ -f "$(PLOTTER_DIR)/main.py" ] && [ -f "$(PLOTTER_DIR)/plot.py" ] && [ -f "$(PLOTTER_DIR)/export.py" ]; then \
		py_count=$$(find $(PLOTTER_DIR) -maxdepth 1 -name "*.py" | wc -l | tr -d ' '); \
		echo "$(GREEN)✓ plotter: $$py_count Python files$(NC)"; \
	else \
		echo "$(RED)Error: plotter source not found$(NC)"; \
		exit 1; \
	fi

# ==============================================================================
# Run Targets
# ==============================================================================

.PHONY: run autorun

run:
ifdef TARGET
	@if [ "$(TARGET)" = "plotter" ]; then \
		echo "$(CYAN)Differential Equation Plotter$(NC)"; \
		echo "$(YELLOW)Generates graphs and exports to LaTeX$(NC)"; \
		echo ""; \
		echo "$(YELLOW)Run with: python3 $(PLOTTER_DIR)/main.py$(NC)"; \
		echo ""; \
		echo "$(YELLOW)Dependencies: numpy, matplotlib$(NC)"; \
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
	@if [ "$(TARGET)" = "plotter" ]; then \
		echo "$(CYAN)Running differential equation plotter...$(NC)"; \
		cd $(PLOTTER_DIR) && python3 main.py 2>/dev/null || \
			echo "$(YELLOW)Note: Requires numpy and matplotlib$(NC)"; \
	else \
		$(MAKE) --no-print-directory run TARGET=$(TARGET); \
	fi
else
	@echo "$(YELLOW)Running plotter...$(NC)"
	@$(MAKE) --no-print-directory autorun TARGET=plotter
endif

# ==============================================================================
# Clean Target
# ==============================================================================

clean:
	@echo "$(YELLOW)Cleaning generated files...$(NC)"
	@rm -f $(PLOTTER_DIR)/assignment.tex 2>/dev/null || true
	@rm -f $(PLOTTER_DIR)/images/*.png 2>/dev/null || true
	@find . -name "*.pyc" -delete 2>/dev/null || true
	@find . -name "__pycache__" -type d -exec rm -rf {} + 2>/dev/null || true
	@echo "$(GREEN)Clean complete.$(NC)"
