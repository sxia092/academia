# CS2200 Theory of Computer Science - Build System
# This makefile builds the flex/bison parser project for Quiz 12
#
# Available targets:
#   make build              - Build all targets
#   make build TARGET=X     - Build specific target
#   make run TARGET=X       - Run specific target interactively
#   make autorun TARGET=X   - Run specific target with input from file
#   make list               - List all available targets
#   make clean              - Remove all build artifacts
#   make help               - Display this help message

# ==============================================================================
# Configuration
# ==============================================================================

# Compiler and tools
CXX = g++
CXXFLAGS = -std=c++11
FLEX = flex
BISON = bison

# Directories
BUILD_DIR = .build
INPUT_DIR = ../../input

# Color output for better readability
RED = \033[0;31m
GREEN = \033[0;32m
YELLOW = \033[1;33m
CYAN = \033[1;36m
NC = \033[0m

# Available build targets
TARGETS = quiz12

# ==============================================================================
# Main Targets
# ==============================================================================

.PHONY: all help build run autorun list clean

# Default target
all: help

# Help target - displays available commands
help:
	@echo "$(CYAN)CS2200 Theory of Computer Science - Build System$(NC)"
	@echo ""
	@echo "$(YELLOW)Usage:$(NC)"
	@echo "  make build              - Build all targets"
	@echo "  make build TARGET=X     - Build specific target"
	@echo "  make run TARGET=X       - Run specific target interactively"
	@echo "  make autorun TARGET=X   - Run specific target with input from file"
	@echo "  make list               - List all available targets"
	@echo "  make clean              - Remove all build artifacts"
	@echo ""
	@echo "$(YELLOW)Available Targets:$(NC)"
	@for target in $(TARGETS); do \
		echo "  $$target"; \
	done

# List available targets
list:
	@echo "$(CYAN)Available targets:$(NC)"
	@for target in $(TARGETS); do \
		echo "  $$target"; \
	done

# ==============================================================================
# Build Targets
# ==============================================================================

.PHONY: build build_quiz12

build: $(BUILD_DIR)
ifdef TARGET
	@$(MAKE) --no-print-directory build_$(TARGET)
else
	@echo "$(CYAN)Building all targets...$(NC)"
	@$(MAKE) --no-print-directory build_quiz12
	@echo "$(GREEN)All targets built successfully!$(NC)"
endif

$(BUILD_DIR):
	@mkdir -p $(BUILD_DIR)

# Quiz 12 - Flex/Bison Parser
# Build process: flex -> bison -> g++
build_quiz12: $(BUILD_DIR)
	@echo "$(CYAN)Building quiz12 (flex/bison parser)...$(NC)"
	@cd quiz-12 && $(FLEX) Quiz12.l
	@cd quiz-12 && $(BISON) Quiz12.y
	@$(CXX) $(CXXFLAGS) quiz-12/Quiz12.tab.c -o $(BUILD_DIR)/quiz12
	@echo "$(GREEN)Built: $(BUILD_DIR)/quiz12$(NC)"

# ==============================================================================
# Run Targets
# ==============================================================================

.PHONY: run autorun

run:
ifdef TARGET
	@if [ -f "$(BUILD_DIR)/$(TARGET)" ]; then \
		echo "$(CYAN)Running $(TARGET)...$(NC)"; \
		./$(BUILD_DIR)/$(TARGET); \
	else \
		echo "$(RED)Error: Target '$(TARGET)' not found. Run 'make build TARGET=$(TARGET)' first.$(NC)"; \
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
	@if [ -f "$(BUILD_DIR)/$(TARGET)" ]; then \
		if [ -f "$(INPUT_DIR)/cs2200-$(TARGET).txt" ]; then \
			echo "$(CYAN)Running $(TARGET) with input from $(INPUT_DIR)/cs2200-$(TARGET).txt...$(NC)"; \
			./$(BUILD_DIR)/$(TARGET) < $(INPUT_DIR)/cs2200-$(TARGET).txt; \
		else \
			echo "$(RED)Error: Input file '$(INPUT_DIR)/cs2200-$(TARGET).txt' not found.$(NC)"; \
			exit 1; \
		fi \
	else \
		echo "$(RED)Error: Target '$(TARGET)' not found. Run 'make build TARGET=$(TARGET)' first.$(NC)"; \
		exit 1; \
	fi
else
	@echo "$(YELLOW)Running all targets with autorun...$(NC)"
	@for target in $(TARGETS); do \
		if [ -f "$(BUILD_DIR)/$$target" ] && [ -f "$(INPUT_DIR)/cs2200-$$target.txt" ]; then \
			echo "$(CYAN)Running $$target...$(NC)"; \
			./$(BUILD_DIR)/$$target < $(INPUT_DIR)/cs2200-$$target.txt; \
			echo ""; \
		fi \
	done
endif

# ==============================================================================
# Clean Target
# ==============================================================================

clean:
	@echo "$(YELLOW)Cleaning build artifacts...$(NC)"
	@rm -rf $(BUILD_DIR)
	@rm -f quiz-12/lex.yy.c quiz-12/Quiz12.tab.c quiz-12/Quiz12.tab.h
	@echo "$(GREEN)Clean complete.$(NC)"
