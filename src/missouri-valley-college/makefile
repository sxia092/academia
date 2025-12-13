# Missouri Valley College - Build System
# Early coursework from Missouri Valley College (pre-transfer).
# Contains simple C/C++ programs for introductory programming.
#
# Available targets:
#   make build              - Build all programs
#   make build TARGET=X     - Build specific program
#   make run TARGET=X       - Run specific program
#   make autorun TARGET=X   - Run with default inputs
#   make list               - List available targets
#   make clean              - Remove build artifacts
#   make help               - Display this help message

# ==============================================================================
# Configuration
# ==============================================================================

# Compiler
CC = gcc
CXX = g++
CFLAGS = -std=c99 -Wall
CXXFLAGS = -std=c++11 -Wall

# Build directory
BUILD_DIR = .build

# Color output for better readability
RED = \033[0;31m
GREEN = \033[0;32m
YELLOW = \033[1;33m
CYAN = \033[1;36m
NC = \033[0m

# Available targets
TARGETS = distance_calc employee_tax grade_calc poker_hand program_i program_v project_ii project_iv

# ==============================================================================
# Main Targets
# ==============================================================================

.PHONY: all help build run autorun list clean

# Default target
all: help

# Help target - displays available commands
help:
	@echo "$(CYAN)Missouri Valley College - Build System$(NC)"
	@echo "$(YELLOW)Early programming coursework (pre-transfer)$(NC)"
	@echo ""
	@echo "$(YELLOW)Usage:$(NC)"
	@echo "  make build              - Build all programs"
	@echo "  make build TARGET=X     - Build specific program"
	@echo "  make run TARGET=X       - Run specific program"
	@echo "  make autorun TARGET=X   - Run with default inputs"
	@echo "  make list               - List available targets"
	@echo "  make clean              - Remove build artifacts"
	@echo ""
	@echo "$(YELLOW)Available Targets:$(NC)"
	@echo "  distance_calc  - Distance Calculator"
	@echo "  employee_tax   - Employee Tax Calculator"
	@echo "  grade_calc     - Grade Calculator"
	@echo "  poker_hand     - Poker Hand Generator"
	@echo "  program_i      - Program I"
	@echo "  program_v      - Program V"
	@echo "  project_ii     - Project II (C++)"
	@echo "  project_iv     - Project IV"

# List available targets
list:
	@echo "$(CYAN)Available targets:$(NC)"
	@for target in $(TARGETS); do \
		echo "  $$target"; \
	done

# ==============================================================================
# Build Targets
# ==============================================================================

$(BUILD_DIR):
	@mkdir -p $(BUILD_DIR)

.PHONY: build

build: $(BUILD_DIR)
ifdef TARGET
	@$(MAKE) --no-print-directory build_$(TARGET)
else
	@echo "$(CYAN)Building all programs...$(NC)"
	@$(MAKE) --no-print-directory build_distance_calc
	@$(MAKE) --no-print-directory build_employee_tax
	@$(MAKE) --no-print-directory build_grade_calc
	@$(MAKE) --no-print-directory build_poker_hand
	@$(MAKE) --no-print-directory build_program_i
	@$(MAKE) --no-print-directory build_program_v
	@$(MAKE) --no-print-directory build_project_ii
	@$(MAKE) --no-print-directory build_project_iv
	@echo "$(GREEN)All programs built successfully!$(NC)"
endif

build_distance_calc: $(BUILD_DIR)
	@echo "$(CYAN)Building distance_calc...$(NC)"
	@$(CC) $(CFLAGS) "Distance Calculator/Distance Calculator/main.c" -o $(BUILD_DIR)/distance_calc 2>/dev/null && \
		echo "$(GREEN)✓ distance_calc$(NC)" || \
		echo "$(YELLOW)⚠ distance_calc: Build skipped$(NC)"

build_employee_tax: $(BUILD_DIR)
	@echo "$(CYAN)Building employee_tax...$(NC)"
	@$(CC) $(CFLAGS) "Employee Tax Calculator/Employee Tax Calculator/main.c" -o $(BUILD_DIR)/employee_tax 2>/dev/null && \
		echo "$(GREEN)✓ employee_tax$(NC)" || \
		echo "$(YELLOW)⚠ employee_tax: Build skipped$(NC)"

build_grade_calc: $(BUILD_DIR)
	@echo "$(CYAN)Building grade_calc...$(NC)"
	@$(CC) $(CFLAGS) "Grade Calculator/Grade Calculator/main.c" -o $(BUILD_DIR)/grade_calc 2>/dev/null && \
		echo "$(GREEN)✓ grade_calc$(NC)" || \
		echo "$(YELLOW)⚠ grade_calc: Build skipped$(NC)"

build_poker_hand: $(BUILD_DIR)
	@echo "$(CYAN)Building poker_hand...$(NC)"
	@$(CC) $(CFLAGS) "Poker Hand Generator/Poker Hand Generator/main.c" -o $(BUILD_DIR)/poker_hand 2>/dev/null && \
		echo "$(GREEN)✓ poker_hand$(NC)" || \
		echo "$(YELLOW)⚠ poker_hand: Build skipped$(NC)"

build_program_i: $(BUILD_DIR)
	@echo "$(CYAN)Building program_i...$(NC)"
	@$(CC) $(CFLAGS) "Program I/Program I/main.c" -o $(BUILD_DIR)/program_i 2>/dev/null && \
		echo "$(GREEN)✓ program_i$(NC)" || \
		echo "$(YELLOW)⚠ program_i: Build skipped$(NC)"

build_program_v: $(BUILD_DIR)
	@echo "$(CYAN)Building program_v...$(NC)"
	@$(CC) $(CFLAGS) "Program V/Program V/main.c" -o $(BUILD_DIR)/program_v 2>/dev/null && \
		echo "$(GREEN)✓ program_v$(NC)" || \
		echo "$(YELLOW)⚠ program_v: Build skipped$(NC)"

build_project_ii: $(BUILD_DIR)
	@echo "$(CYAN)Building project_ii...$(NC)"
	@$(CXX) $(CXXFLAGS) "Project II/Project II/main.cpp" -o $(BUILD_DIR)/project_ii 2>/dev/null && \
		echo "$(GREEN)✓ project_ii$(NC)" || \
		echo "$(YELLOW)⚠ project_ii: Build skipped$(NC)"

build_project_iv: $(BUILD_DIR)
	@echo "$(CYAN)Building project_iv...$(NC)"
	@$(CC) $(CFLAGS) "Project IV/Project IV/main.c" -o $(BUILD_DIR)/project_iv 2>/dev/null && \
		echo "$(GREEN)✓ project_iv$(NC)" || \
		echo "$(YELLOW)⚠ project_iv: Build skipped$(NC)"

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
		echo "$(RED)Error: $(TARGET) not built. Run 'make build TARGET=$(TARGET)' first.$(NC)"; \
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
	@$(MAKE) --no-print-directory run TARGET=$(TARGET)
else
	@echo "$(YELLOW)Running distance_calc as default...$(NC)"
	@if [ -f "$(BUILD_DIR)/distance_calc" ]; then \
		echo "100" | ./$(BUILD_DIR)/distance_calc; \
	else \
		echo "$(RED)Error: Build first with 'make build'$(NC)"; \
	fi
endif

# ==============================================================================
# Clean Target
# ==============================================================================

clean:
	@echo "$(YELLOW)Cleaning build artifacts...$(NC)"
	@rm -rf $(BUILD_DIR)
	@echo "$(GREEN)Clean complete.$(NC)"
