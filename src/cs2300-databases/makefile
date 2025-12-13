# CS2300 Databases - Build System
# This makefile builds the compilable components of the database course project
#
# Available targets:
#   make build              - Build all targets
#   make build TARGET=X     - Build specific target
#   make run TARGET=X       - Run specific target interactively
#   make autorun TARGET=X   - Run specific target (no input needed)
#   make list               - List all available targets
#   make clean              - Remove all build artifacts
#   make help               - Display this help message
#
# Note: This course primarily contains SQL scripts and HTML files.
#       The only compilable target is the Random SQL Generator utility.

# ==============================================================================
# Configuration
# ==============================================================================

# Directories
BUILD_DIR = .build
SQL_GENERATOR_DIR = Database Code/C++/Random SQL Generator

# Color output for better readability
RED = \033[0;31m
GREEN = \033[0;32m
YELLOW = \033[1;33m
CYAN = \033[1;36m
NC = \033[0m

# Available build targets
TARGETS = sql_generator

# ==============================================================================
# Main Targets
# ==============================================================================

.PHONY: all help build run autorun list clean

# Default target
all: help

# Help target - displays available commands
help:
	@echo "$(CYAN)CS2300 Databases - Build System$(NC)"
	@echo ""
	@echo "$(YELLOW)Usage:$(NC)"
	@echo "  make build              - Build all targets"
	@echo "  make build TARGET=X     - Build specific target"
	@echo "  make run TARGET=X       - Run specific target"
	@echo "  make autorun TARGET=X   - Run specific target (generates SQL output)"
	@echo "  make list               - List all available targets"
	@echo "  make clean              - Remove all build artifacts"
	@echo ""
	@echo "$(YELLOW)Available Targets:$(NC)"
	@for target in $(TARGETS); do \
		echo "  $$target"; \
	done
	@echo ""
	@echo "$(YELLOW)Note:$(NC) This course primarily contains SQL scripts and HTML files."
	@echo "      The sql_generator creates random SQL INSERT statements."

# List available targets
list:
	@echo "$(CYAN)Available targets:$(NC)"
	@for target in $(TARGETS); do \
		echo "  $$target"; \
	done

# ==============================================================================
# Build Targets
# ==============================================================================

.PHONY: build build_sql_generator

build: $(BUILD_DIR)
ifdef TARGET
	@$(MAKE) --no-print-directory build_$(TARGET)
else
	@echo "$(CYAN)Building all targets...$(NC)"
	@$(MAKE) --no-print-directory build_sql_generator
	@echo "$(GREEN)All targets built successfully!$(NC)"
endif

$(BUILD_DIR):
	@mkdir -p $(BUILD_DIR)

# SQL Generator - generates random SQL INSERT statements for testing
build_sql_generator: $(BUILD_DIR)
	@echo "$(CYAN)Building sql_generator (Random SQL Generator)...$(NC)"
	@$(MAKE) -C "$(SQL_GENERATOR_DIR)" clean > /dev/null 2>&1 || true
	@$(MAKE) -C "$(SQL_GENERATOR_DIR)" production
	@cp "$(SQL_GENERATOR_DIR)/build" $(BUILD_DIR)/sql_generator
	@echo "$(GREEN)Built: $(BUILD_DIR)/sql_generator$(NC)"

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

# Autorun - same as run for this project (no input needed)
autorun:
ifdef TARGET
	@if [ -f "$(BUILD_DIR)/$(TARGET)" ]; then \
		echo "$(CYAN)Running $(TARGET)...$(NC)"; \
		./$(BUILD_DIR)/$(TARGET); \
	else \
		echo "$(RED)Error: Target '$(TARGET)' not found. Run 'make build TARGET=$(TARGET)' first.$(NC)"; \
		exit 1; \
	fi
else
	@echo "$(YELLOW)Running all targets...$(NC)"
	@for target in $(TARGETS); do \
		if [ -f "$(BUILD_DIR)/$$target" ]; then \
			echo "$(CYAN)Running $$target...$(NC)"; \
			./$(BUILD_DIR)/$$target; \
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
	@$(MAKE) -C "$(SQL_GENERATOR_DIR)" clean > /dev/null 2>&1 || true
	@echo "$(GREEN)Clean complete.$(NC)"
