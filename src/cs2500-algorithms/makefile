# CS2500 Algorithms - Build System
# This makefile builds and runs the algorithm projects
#
# Available targets:
#   make build              - Build all targets
#   make build TARGET=X     - Build specific target
#   make run TARGET=X       - Run specific target
#   make autorun TARGET=X   - Run specific target (same as run, no stdin input)
#   make list               - List all available targets
#   make clean              - Remove all build artifacts
#   make help               - Display this help message
#
# Note: Homework directories contain only written assignments (LaTeX/PDF).
#       Project1 is Python, Project2 is C++.

# ==============================================================================
# Configuration
# ==============================================================================

# Directories
BUILD_DIR = .build
PROJECT1_DIR = CS2500-Project1/Source Code
PROJECT2_DIR = CS2500-Project2/Source Code/Source Code

# Color output for better readability
RED = \033[0;31m
GREEN = \033[0;32m
YELLOW = \033[1;33m
CYAN = \033[1;36m
NC = \033[0m

# Available build targets
TARGETS = project1 project2

# ==============================================================================
# Main Targets
# ==============================================================================

.PHONY: all help build run autorun list clean

# Default target
all: help

# Help target - displays available commands
help:
	@echo "$(CYAN)CS2500 Algorithms - Build System$(NC)"
	@echo ""
	@echo "$(YELLOW)Usage:$(NC)"
	@echo "  make build              - Build all targets"
	@echo "  make build TARGET=X     - Build specific target"
	@echo "  make run TARGET=X       - Run specific target"
	@echo "  make autorun TARGET=X   - Run specific target (no stdin needed)"
	@echo "  make list               - List all available targets"
	@echo "  make clean              - Remove all build artifacts"
	@echo ""
	@echo "$(YELLOW)Available Targets:$(NC)"
	@echo "  project1  - Knapsack algorithm comparison (Python)"
	@echo "  project2  - Graph analysis algorithms (C++)"
	@echo ""
	@echo "$(YELLOW)Note:$(NC) Homework directories contain written assignments only."

# List available targets
list:
	@echo "$(CYAN)Available targets:$(NC)"
	@echo "  project1  - Knapsack algorithm comparison (Python)"
	@echo "  project2  - Graph analysis algorithms (C++)"

# ==============================================================================
# Build Targets
# ==============================================================================

.PHONY: build build_project1 build_project2

build: $(BUILD_DIR)
ifdef TARGET
	@$(MAKE) --no-print-directory build_$(TARGET)
else
	@echo "$(CYAN)Building all targets...$(NC)"
	@$(MAKE) --no-print-directory build_project1
	@$(MAKE) --no-print-directory build_project2
	@echo "$(GREEN)All targets built successfully!$(NC)"
endif

$(BUILD_DIR):
	@mkdir -p $(BUILD_DIR)

# Project1 - Python (no compilation needed, just copy script)
build_project1: $(BUILD_DIR)
	@echo "$(CYAN)Building project1 (Python - no compilation needed)...$(NC)"
	@cp "$(PROJECT1_DIR)/Project Code.py" $(BUILD_DIR)/project1.py
	@echo "$(GREEN)Built: $(BUILD_DIR)/project1.py$(NC)"

# Project2 - C++ Graph Analysis
build_project2: $(BUILD_DIR)
	@echo "$(CYAN)Building project2 (C++ Graph Analysis)...$(NC)"
	@$(MAKE) -C "$(PROJECT2_DIR)" clean > /dev/null 2>&1 || true
	@$(MAKE) -C "$(PROJECT2_DIR)" production
	@cp "$(PROJECT2_DIR)/build" $(BUILD_DIR)/project2
	@echo "$(GREEN)Built: $(BUILD_DIR)/project2$(NC)"

# ==============================================================================
# Run Targets
# ==============================================================================

.PHONY: run autorun

run:
ifdef TARGET
	@if [ "$(TARGET)" = "project1" ]; then \
		if [ -f "$(BUILD_DIR)/project1.py" ]; then \
			echo "$(CYAN)Running project1 (Python)...$(NC)"; \
			echo "$(YELLOW)Note: This runs indefinitely. Press Ctrl+C to stop.$(NC)"; \
			cd "$(PROJECT1_DIR)" && python3 "Project Code.py"; \
		else \
			echo "$(RED)Error: project1 not built. Run 'make build TARGET=project1' first.$(NC)"; \
			exit 1; \
		fi \
	elif [ "$(TARGET)" = "project2" ]; then \
		if [ -f "$(BUILD_DIR)/project2" ]; then \
			echo "$(CYAN)Running project2 (C++ Graph Analysis)...$(NC)"; \
			cd "$(PROJECT2_DIR)" && ../../../$(BUILD_DIR)/project2; \
		else \
			echo "$(RED)Error: project2 not built. Run 'make build TARGET=project2' first.$(NC)"; \
			exit 1; \
		fi \
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

# Autorun - same as run for this project (no stdin input needed)
autorun:
ifdef TARGET
	@$(MAKE) --no-print-directory run TARGET=$(TARGET)
else
	@echo "$(YELLOW)Running all targets...$(NC)"
	@echo "$(YELLOW)Note: project1 runs indefinitely, skipping in autorun.$(NC)"
	@if [ -f "$(BUILD_DIR)/project2" ]; then \
		echo "$(CYAN)Running project2...$(NC)"; \
		cd "$(PROJECT2_DIR)" && ../../../$(BUILD_DIR)/project2; \
	fi
endif

# ==============================================================================
# Clean Target
# ==============================================================================

clean:
	@echo "$(YELLOW)Cleaning build artifacts...$(NC)"
	@rm -rf $(BUILD_DIR)
	@$(MAKE) -C "$(PROJECT2_DIR)" clean > /dev/null 2>&1 || true
	@rm -f "$(PROJECT1_DIR)/output.txt" "$(PROJECT1_DIR)/SolutionSets.txt" 2>/dev/null || true
	@echo "$(GREEN)Clean complete.$(NC)"
