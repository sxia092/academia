# CS3500 Programming Languages and Translators - Build System
# This course covers automata, lexical analysis, and functional programming.
#
# Available targets:
#   make build              - Build all targets
#   make build TARGET=X     - Build specific target
#   make run TARGET=X       - Run specific target
#   make autorun TARGET=X   - Run specific target with input
#   make list               - List available targets
#   make clean              - Remove all build artifacts
#   make help               - Display this help message

# ==============================================================================
# Configuration
# ==============================================================================

# Compiler and tools
CXX = g++
CXXFLAGS = -std=c++14
FLEX = flex

# Directories
BUILD_DIR = .build
INPUT_DIR = ../../input

# Color output for better readability
RED = \033[0;31m
GREEN = \033[0;32m
YELLOW = \033[1;33m
CYAN = \033[1;36m
NC = \033[0m

# Available targets
TARGETS = homework1 homework2 homework4

# ==============================================================================
# Main Targets
# ==============================================================================

.PHONY: all help build run autorun list clean

# Default target
all: help

# Help target - displays available commands
help:
	@echo "$(CYAN)CS3500 Programming Languages and Translators - Build System$(NC)"
	@echo ""
	@echo "$(YELLOW)Usage:$(NC)"
	@echo "  make build              - Build all targets"
	@echo "  make build TARGET=X     - Build specific target"
	@echo "  make run TARGET=X       - Run specific target"
	@echo "  make autorun TARGET=X   - Run with input file"
	@echo "  make list               - List available targets"
	@echo "  make clean              - Remove all build artifacts"
	@echo ""
	@echo "$(YELLOW)Available Targets:$(NC)"
	@echo "  homework1  - Automata simulation (Python)"
	@echo "  homework2  - Lexical analyzer (Flex/C++)"
	@echo "  homework4  - Lisp programming (requires Lisp interpreter)"

# List available targets
list:
	@echo "$(CYAN)Available targets:$(NC)"
	@echo "  homework1  - Automata simulation (Python)"
	@echo "  homework2  - Lexical analyzer (Flex/C++)"
	@echo "  homework4  - Lisp programming"

# ==============================================================================
# Build Targets
# ==============================================================================

.PHONY: build build_homework1 build_homework2 build_homework4

build: $(BUILD_DIR)
ifdef TARGET
	@$(MAKE) --no-print-directory build_$(TARGET)
else
	@echo "$(CYAN)Building all targets...$(NC)"
	@$(MAKE) --no-print-directory build_homework1
	@$(MAKE) --no-print-directory build_homework2
	@$(MAKE) --no-print-directory build_homework4
	@echo "$(GREEN)All targets built successfully!$(NC)"
endif

$(BUILD_DIR):
	@mkdir -p $(BUILD_DIR)

# Homework 1 - Python automata (no compilation needed)
build_homework1: $(BUILD_DIR)
	@echo "$(CYAN)Building homework1 (Python - no compilation needed)...$(NC)"
	@if [ -f "homework-1/main.py" ]; then \
		cp homework-1/main.py $(BUILD_DIR)/homework1.py; \
		echo "$(GREEN)✓ homework1: Python automata simulation$(NC)"; \
	else \
		echo "$(RED)Error: homework-1/main.py not found$(NC)"; \
		exit 1; \
	fi

# Homework 2 - Flex lexical analyzer
build_homework2: $(BUILD_DIR)
	@echo "$(CYAN)Building homework2 (Flex lexical analyzer)...$(NC)"
	@cd homework-2 && $(FLEX) main.l
	@$(CXX) $(CXXFLAGS) homework-2/lex.yy.c -o $(BUILD_DIR)/homework2
	@echo "$(GREEN)✓ homework2: Lexical analyzer built$(NC)"

# Homework 4 - Lisp (no compilation, interpreted)
build_homework4: $(BUILD_DIR)
	@echo "$(CYAN)Building homework4 (Lisp - no compilation needed)...$(NC)"
	@if [ -f "homework-4/homework-5.lisp" ]; then \
		cp homework-4/homework-5.lisp $(BUILD_DIR)/homework4.lisp; \
		echo "$(GREEN)✓ homework4: Lisp file copied$(NC)"; \
	else \
		echo "$(RED)Error: homework-4/homework-5.lisp not found$(NC)"; \
		exit 1; \
	fi

# ==============================================================================
# Run Targets
# ==============================================================================

.PHONY: run autorun

run:
ifdef TARGET
	@if [ "$(TARGET)" = "homework1" ]; then \
		echo "$(CYAN)Running homework1 (Python automata)...$(NC)"; \
		cd homework-1 && python3 main.py; \
	elif [ "$(TARGET)" = "homework2" ]; then \
		if [ -f "$(BUILD_DIR)/homework2" ]; then \
			echo "$(CYAN)Running homework2 (lexical analyzer)...$(NC)"; \
			echo "$(YELLOW)Enter input (Ctrl+D to end):$(NC)"; \
			./$(BUILD_DIR)/homework2; \
		else \
			echo "$(RED)Error: homework2 not built. Run 'make build TARGET=homework2' first.$(NC)"; \
			exit 1; \
		fi \
	elif [ "$(TARGET)" = "homework4" ]; then \
		echo "$(CYAN)Running homework4 (Lisp)...$(NC)"; \
		if command -v sbcl > /dev/null 2>&1; then \
			sbcl --script $(BUILD_DIR)/homework4.lisp; \
		elif command -v clisp > /dev/null 2>&1; then \
			clisp $(BUILD_DIR)/homework4.lisp; \
		else \
			echo "$(RED)Error: No Lisp interpreter found (sbcl or clisp).$(NC)"; \
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

autorun:
ifdef TARGET
	@if [ "$(TARGET)" = "homework1" ]; then \
		echo "$(CYAN)Running homework1 (Python automata)...$(NC)"; \
		cd homework-1 && python3 main.py; \
	elif [ "$(TARGET)" = "homework2" ]; then \
		if [ -f "$(BUILD_DIR)/homework2" ]; then \
			if [ -f "$(INPUT_DIR)/cs3500-homework2.txt" ]; then \
				echo "$(CYAN)Running homework2 with input...$(NC)"; \
				./$(BUILD_DIR)/homework2 < $(INPUT_DIR)/cs3500-homework2.txt; \
			elif [ -f "homework-2/input/input.txt" ]; then \
				echo "$(CYAN)Running homework2 with bundled input...$(NC)"; \
				./$(BUILD_DIR)/homework2 < homework-2/input/input.txt; \
			else \
				echo "$(RED)Error: No input file found.$(NC)"; \
				exit 1; \
			fi \
		else \
			echo "$(RED)Error: homework2 not built.$(NC)"; \
			exit 1; \
		fi \
	elif [ "$(TARGET)" = "homework4" ]; then \
		$(MAKE) --no-print-directory run TARGET=homework4; \
	else \
		echo "$(RED)Error: Unknown target '$(TARGET)'$(NC)"; \
		exit 1; \
	fi
else
	@echo "$(YELLOW)Running all targets with autorun...$(NC)"
	@$(MAKE) --no-print-directory autorun TARGET=homework1 || true
	@$(MAKE) --no-print-directory autorun TARGET=homework2 || true
endif

# ==============================================================================
# Clean Target
# ==============================================================================

clean:
	@echo "$(YELLOW)Cleaning build artifacts...$(NC)"
	@rm -rf $(BUILD_DIR)
	@rm -f homework-2/lex.yy.c homework-2/driver homework-2/output.txt
	@echo "$(GREEN)Clean complete.$(NC)"
