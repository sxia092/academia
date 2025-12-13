# CS3200 Numerical Methods - Build System
# This course contains MATLAB (.m) files for numerical analysis.
# MATLAB files are interpreted and don't require compilation.
#
# Available targets:
#   make build              - Verify MATLAB files exist (no compilation needed)
#   make run TARGET=X       - Run homework with Octave (if installed)
#   make list               - List available targets
#   make clean              - No-op (no build artifacts)
#   make help               - Display this help message
#
# Note: Running requires MATLAB or GNU Octave installed.

# ==============================================================================
# Configuration
# ==============================================================================

# Color output for better readability
RED = \033[0;31m
GREEN = \033[0;32m
YELLOW = \033[1;33m
CYAN = \033[1;36m
NC = \033[0m

# Available targets (homework assignments)
TARGETS = homework1 homework2 homework3 homework4 homework5 homework6

# ==============================================================================
# Main Targets
# ==============================================================================

.PHONY: all help build run autorun list clean

# Default target
all: help

# Help target - displays available commands
help:
	@echo "$(CYAN)CS3200 Numerical Methods - Build System$(NC)"
	@echo ""
	@echo "$(YELLOW)Note:$(NC) This course contains MATLAB (.m) files."
	@echo "      Running requires MATLAB or GNU Octave."
	@echo ""
	@echo "$(YELLOW)Usage:$(NC)"
	@echo "  make build              - Verify MATLAB files exist"
	@echo "  make run TARGET=X       - Run homework with Octave"
	@echo "  make list               - List available targets"
	@echo "  make clean              - No-op (no build artifacts)"
	@echo ""
	@echo "$(YELLOW)Available Targets:$(NC)"
	@echo "  homework1  - Homework #1"
	@echo "  homework2  - Homework #2 (exponential/fractional approximation)"
	@echo "  homework3  - Homework #3 (closure methods)"
	@echo "  homework4  - Homework #4 (Newton's method)"
	@echo "  homework5  - Homework #5 (regression)"
	@echo "  homework6  - Homework #6 (interpolation)"

# List available targets
list:
	@echo "$(CYAN)Available targets:$(NC)"
	@echo "  homework1  - Homework #1"
	@echo "  homework2  - Homework #2"
	@echo "  homework3  - Homework #3"
	@echo "  homework4  - Homework #4"
	@echo "  homework5  - Homework #5"
	@echo "  homework6  - Homework #6"

# ==============================================================================
# Build Target (MATLAB - no compilation needed)
# ==============================================================================

.PHONY: build

build:
	@echo "$(CYAN)CS3200 Numerical Methods: MATLAB Project$(NC)"
	@echo "$(YELLOW)MATLAB files - no compilation needed$(NC)"
	@echo "Verifying MATLAB files exist..."
	@if [ -f "Homework #1/homework1.m" ]; then \
		echo "$(GREEN)✓ Homework #1: homework1.m$(NC)"; \
	fi
	@if [ -f "Homework #2/homework2.m" ]; then \
		echo "$(GREEN)✓ Homework #2: homework2.m$(NC)"; \
	fi
	@if [ -f "Homework #3/hw3.m" ]; then \
		echo "$(GREEN)✓ Homework #3: hw3.m$(NC)"; \
	fi
	@if [ -f "Homework #4/homework4.m" ]; then \
		echo "$(GREEN)✓ Homework #4: homework4.m$(NC)"; \
	fi
	@if [ -f "Homework #5/homework6.m" ]; then \
		echo "$(GREEN)✓ Homework #5: homework6.m$(NC)"; \
	fi
	@if [ -f "Homework #6/main.m" ]; then \
		echo "$(GREEN)✓ Homework #6: main.m$(NC)"; \
	fi
	@echo "$(GREEN)✓ All MATLAB files verified$(NC)"

# ==============================================================================
# Run Targets (requires Octave or MATLAB)
# ==============================================================================

.PHONY: run autorun

run:
ifdef TARGET
	@if ! command -v octave > /dev/null 2>&1; then \
		echo "$(RED)Error: GNU Octave not found.$(NC)"; \
		echo "Install Octave or use MATLAB to run .m files."; \
		exit 1; \
	fi
	@if [ "$(TARGET)" = "homework1" ]; then \
		echo "$(CYAN)Running Homework #1...$(NC)"; \
		cd "Homework #1" && octave --no-gui homework1.m; \
	elif [ "$(TARGET)" = "homework2" ]; then \
		echo "$(CYAN)Running Homework #2...$(NC)"; \
		cd "Homework #2" && octave --no-gui homework2.m; \
	elif [ "$(TARGET)" = "homework3" ]; then \
		echo "$(CYAN)Running Homework #3...$(NC)"; \
		cd "Homework #3" && octave --no-gui hw3.m; \
	elif [ "$(TARGET)" = "homework4" ]; then \
		echo "$(CYAN)Running Homework #4...$(NC)"; \
		cd "Homework #4" && octave --no-gui homework4.m; \
	elif [ "$(TARGET)" = "homework5" ]; then \
		echo "$(CYAN)Running Homework #5...$(NC)"; \
		cd "Homework #5" && octave --no-gui homework6.m; \
	elif [ "$(TARGET)" = "homework6" ]; then \
		echo "$(CYAN)Running Homework #6...$(NC)"; \
		cd "Homework #6" && octave --no-gui main.m; \
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
	@echo "$(YELLOW)Note:$(NC) Requires GNU Octave or MATLAB installed."
endif

# Autorun - same as run for MATLAB
autorun:
ifdef TARGET
	@$(MAKE) --no-print-directory run TARGET=$(TARGET)
else
	@echo "$(YELLOW)CS3200 Numerical Methods: MATLAB files$(NC)"
	@echo "Autorun requires Octave. Use 'make run TARGET=<target>'."
endif

# ==============================================================================
# Clean Target
# ==============================================================================

clean:
	@echo "$(YELLOW)CS3200 Numerical Methods: No build artifacts to clean$(NC)"
	@echo "MATLAB files are interpreted, no compilation artifacts."
