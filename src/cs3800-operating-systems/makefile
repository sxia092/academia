# CS3800 Operating Systems - Build System
# This course covers shell scripting, page replacement, and network programming.
# All assignments are scripted (Bash/Python) - no compilation needed.
#
# Available targets:
#   make build              - Verify all script files exist
#   make build TARGET=X     - Verify specific target
#   make run TARGET=X       - Run specific target
#   make autorun TARGET=X   - Run with default/bundled inputs
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
TARGETS = homework1 homework2 homework3

# ==============================================================================
# Main Targets
# ==============================================================================

.PHONY: all help build run autorun list clean

# Default target
all: help

# Help target - displays available commands
help:
	@echo "$(CYAN)CS3800 Operating Systems - Build System$(NC)"
	@echo ""
	@echo "$(YELLOW)Usage:$(NC)"
	@echo "  make build              - Verify all script files exist"
	@echo "  make build TARGET=X     - Verify specific target"
	@echo "  make run TARGET=X       - Run specific target"
	@echo "  make autorun TARGET=X   - Run with bundled inputs"
	@echo "  make list               - List available targets"
	@echo "  make clean              - Remove Python cache files"
	@echo ""
	@echo "$(YELLOW)Available Targets:$(NC)"
	@echo "  homework1  - Shell scripting exercises (Bash)"
	@echo "  homework2  - Page replacement simulation (Python)"
	@echo "  homework3  - Network server/client (Python)"

# List available targets
list:
	@echo "$(CYAN)Available targets:$(NC)"
	@echo "  homework1  - Shell scripting (Bash)"
	@echo "  homework2  - Page replacement simulation (Python)"
	@echo "  homework3  - Network server/client (Python)"

# ==============================================================================
# Build Targets (Script verification - no compilation)
# ==============================================================================

.PHONY: build build_homework1 build_homework2 build_homework3

build:
ifdef TARGET
	@$(MAKE) --no-print-directory build_$(TARGET)
else
	@echo "$(CYAN)Verifying all script files...$(NC)"
	@$(MAKE) --no-print-directory build_homework1
	@$(MAKE) --no-print-directory build_homework2
	@$(MAKE) --no-print-directory build_homework3
	@echo "$(GREEN)All scripts verified!$(NC)"
endif

# Homework 1 - Shell script
build_homework1:
	@echo "$(CYAN)Verifying homework1 (Bash script)...$(NC)"
	@if [ -f "homework-1/homework-1.sh" ]; then \
		echo "$(GREEN)✓ homework1: homework-1.sh$(NC)"; \
	else \
		echo "$(RED)Error: homework-1/homework-1.sh not found$(NC)"; \
		exit 1; \
	fi

# Homework 2 - Python page replacement
build_homework2:
	@echo "$(CYAN)Verifying homework2 (Python)...$(NC)"
	@if [ -f "homework-2/source-code/main.py" ]; then \
		echo "$(GREEN)✓ homework2: Page replacement simulation$(NC)"; \
	else \
		echo "$(RED)Error: homework-2/source-code/main.py not found$(NC)"; \
		exit 1; \
	fi

# Homework 3 - Python server/client
build_homework3:
	@echo "$(CYAN)Verifying homework3 (Python)...$(NC)"
	@if [ -f "homework-3/Server/server.py" ] && [ -f "homework-3/Server/client.py" ]; then \
		echo "$(GREEN)✓ homework3: Network server/client$(NC)"; \
	else \
		echo "$(RED)Error: homework-3 server/client files not found$(NC)"; \
		exit 1; \
	fi

# ==============================================================================
# Run Targets
# ==============================================================================

.PHONY: run autorun

run:
ifdef TARGET
	@if [ "$(TARGET)" = "homework1" ]; then \
		echo "$(CYAN)Running homework1 (Shell script)...$(NC)"; \
		echo "$(YELLOW)Note: Some commands may require specific Linux tools$(NC)"; \
		cd homework-1 && bash homework-1.sh; \
	elif [ "$(TARGET)" = "homework2" ]; then \
		echo "$(CYAN)Homework2: Page replacement simulation$(NC)"; \
		echo "$(YELLOW)Usage: python3 main.py programlist commandlist pagesize algorithm --(prepaging|ondemand)$(NC)"; \
		echo "$(YELLOW)Algorithms: FIFO, LRU, LFU, MFU, Random$(NC)"; \
		echo ""; \
		echo "Run autorun for example: make autorun TARGET=homework2"; \
	elif [ "$(TARGET)" = "homework3" ]; then \
		echo "$(CYAN)Homework3: Network server/client$(NC)"; \
		echo "$(YELLOW)To run server:$(NC) cd homework-3/Server && python3 server.py"; \
		echo "$(YELLOW)To run client:$(NC) cd homework-3/Server && python3 client.py"; \
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
		echo "$(CYAN)Running homework1 (Shell script)...$(NC)"; \
		echo "$(YELLOW)Note: Some commands require Linux-specific tools$(NC)"; \
		cd homework-1 && bash homework-1.sh 2>&1 || true; \
	elif [ "$(TARGET)" = "homework2" ]; then \
		echo "$(CYAN)Running homework2 with bundled test data...$(NC)"; \
		cd homework-2/source-code && python3 main.py programlist.txt commandlist.txt 8 fifo ondemand; \
	elif [ "$(TARGET)" = "homework3" ]; then \
		echo "$(YELLOW)homework3 is a network server/client - cannot autorun$(NC)"; \
		echo "Use 'make run TARGET=homework3' for instructions."; \
	else \
		echo "$(RED)Error: Unknown target '$(TARGET)'$(NC)"; \
		exit 1; \
	fi
else
	@echo "$(YELLOW)Running homework2 with bundled test data...$(NC)"
	@$(MAKE) --no-print-directory autorun TARGET=homework2
endif

# ==============================================================================
# Clean Target
# ==============================================================================

clean:
	@echo "$(YELLOW)Cleaning Python cache files...$(NC)"
	@find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	@find . -type f -name "*.pyc" -delete 2>/dev/null || true
	@echo "$(GREEN)Clean complete.$(NC)"
