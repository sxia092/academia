# CS4099 Undergraduate Research - Build System
# This is control flow graph (CFG) tracing research.
# The C++ program transforms source code to insert CFG instrumentation.
#
# Available targets:
#   make build              - Build the CFG tracer driver
#   make run TARGET=X       - Run specific target
#   make autorun TARGET=X   - Run with bundled input files
#   make list               - List available targets
#   make clean              - Remove build artifacts
#   make help               - Display this help message
#
# Note: Building requires Boost regex library (libboost_regex)

# ==============================================================================
# Configuration
# ==============================================================================

# Compiler and flags
CXX = g++
CXXFLAGS = -std=c++14 -I/opt/homebrew/include
LDFLAGS = -L/opt/homebrew/lib -lboost_regex

# Directories
BUILD_DIR = .build
INPUT_DIR = input

# Color output for better readability
RED = \033[0;31m
GREEN = \033[0;32m
YELLOW = \033[1;33m
CYAN = \033[1;36m
NC = \033[0m

# Available targets
TARGETS = research tester

# ==============================================================================
# Main Targets
# ==============================================================================

.PHONY: all help build run autorun list clean

# Default target
all: help

# Help target - displays available commands
help:
	@echo "$(CYAN)CS4099 Undergraduate Research - Build System$(NC)"
	@echo "$(YELLOW)Project: Control Flow Graph (CFG) Tracer$(NC)"
	@echo ""
	@echo "$(YELLOW)Usage:$(NC)"
	@echo "  make build              - Build the CFG tracer driver"
	@echo "  make run TARGET=X       - Run specific target"
	@echo "  make autorun TARGET=X   - Run with bundled input files"
	@echo "  make list               - List available targets"
	@echo "  make clean              - Remove build artifacts"
	@echo ""
	@echo "$(YELLOW)Available Targets:$(NC)"
	@echo "  research  - CFG tracer driver (C++ with Boost)"
	@echo "  tester    - Test runner (Python)"
	@echo ""
	@echo "$(YELLOW)Note:$(NC) Building requires Boost regex library"

# List available targets
list:
	@echo "$(CYAN)Available targets:$(NC)"
	@echo "  research  - CFG tracer driver (C++)"
	@echo "  tester    - Test runner (Python)"

# ==============================================================================
# Build Targets
# ==============================================================================

.PHONY: build build_research build_tester

$(BUILD_DIR):
	@mkdir -p $(BUILD_DIR)

build: $(BUILD_DIR)
ifdef TARGET
	@$(MAKE) --no-print-directory build_$(TARGET)
else
	@echo "$(CYAN)Building all targets...$(NC)"
	@$(MAKE) --no-print-directory build_research
	@$(MAKE) --no-print-directory build_tester
	@echo "$(GREEN)All targets built successfully!$(NC)"
endif

# Research - CFG tracer (C++ with Boost)
# Note: Requires Boost regex library. Build is optional if Boost is not installed.
build_research: $(BUILD_DIR)
	@echo "$(CYAN)Building research (CFG tracer)...$(NC)"
	@if [ -f "main.cpp" ] && [ -f "functions.cpp" ]; then \
		echo "$(GREEN)✓ research: Source files verified$(NC)"; \
	else \
		echo "$(RED)Error: Source files not found$(NC)"; \
		exit 1; \
	fi
	@if $(CXX) $(CXXFLAGS) main.cpp functions.cpp $(LDFLAGS) -o $(BUILD_DIR)/research 2>/dev/null; then \
		echo "$(GREEN)✓ research: CFG tracer compiled$(NC)"; \
	elif $(CXX) -std=c++14 main.cpp functions.cpp -lboost_regex -o $(BUILD_DIR)/research 2>/dev/null; then \
		echo "$(GREEN)✓ research: CFG tracer compiled$(NC)"; \
	else \
		echo "$(YELLOW)⚠ research: Boost regex not available - skipping compilation$(NC)"; \
		echo "$(YELLOW)  Install with: brew install boost$(NC)"; \
	fi

# Tester - Python script (no compilation needed)
build_tester: $(BUILD_DIR)
	@echo "$(CYAN)Verifying tester (Python script)...$(NC)"
	@if [ -f "tester.py" ]; then \
		cp tester.py $(BUILD_DIR)/tester.py; \
		echo "$(GREEN)✓ tester: Python test runner$(NC)"; \
	else \
		echo "$(RED)Error: tester.py not found$(NC)"; \
		exit 1; \
	fi

# ==============================================================================
# Run Targets
# ==============================================================================

.PHONY: run autorun

run:
ifdef TARGET
	@if [ "$(TARGET)" = "research" ]; then \
		if [ -f "$(BUILD_DIR)/research" ]; then \
			echo "$(CYAN)Running CFG tracer...$(NC)"; \
			echo "$(YELLOW)Usage: ./$(BUILD_DIR)/research <input_file.cpp>$(NC)"; \
			echo ""; \
			echo "$(YELLOW)Available input files in $(INPUT_DIR)/:$(NC)"; \
			ls -1 $(INPUT_DIR)/*.cpp 2>/dev/null | xargs -I {} basename {} || echo "  (no input files found)"; \
		else \
			echo "$(RED)Error: research not built. Run 'make build' first.$(NC)"; \
			exit 1; \
		fi \
	elif [ "$(TARGET)" = "tester" ]; then \
		if [ -f "$(BUILD_DIR)/research" ]; then \
			echo "$(CYAN)Running test suite...$(NC)"; \
			echo "$(YELLOW)Usage: python3 tester.py <input_directory>$(NC)"; \
			echo ""; \
			python3 tester.py $(INPUT_DIR); \
		else \
			echo "$(RED)Error: Build research first. Run 'make build' first.$(NC)"; \
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
	@if [ "$(TARGET)" = "research" ]; then \
		if [ -f "$(BUILD_DIR)/research" ]; then \
			echo "$(CYAN)Running CFG tracer on sample input...$(NC)"; \
			if [ -f "$(INPUT_DIR)/binary.cpp" ]; then \
				echo "$(YELLOW)Input: $(INPUT_DIR)/binary.cpp$(NC)"; \
				echo "$(YELLOW)--- Transformed Output ---$(NC)"; \
				./$(BUILD_DIR)/research $(INPUT_DIR)/binary.cpp; \
			else \
				echo "$(RED)Error: Sample input file not found$(NC)"; \
				exit 1; \
			fi \
		else \
			echo "$(RED)Error: research not built. Run 'make build' first.$(NC)"; \
			exit 1; \
		fi \
	elif [ "$(TARGET)" = "tester" ]; then \
		$(MAKE) --no-print-directory run TARGET=tester; \
	else \
		echo "$(RED)Error: Unknown target '$(TARGET)'$(NC)"; \
		exit 1; \
	fi
else
	@echo "$(YELLOW)Running CFG tracer with sample input...$(NC)"
	@$(MAKE) --no-print-directory autorun TARGET=research
endif

# ==============================================================================
# Clean Target
# ==============================================================================

clean:
	@echo "$(YELLOW)Cleaning build artifacts...$(NC)"
	@rm -rf $(BUILD_DIR)
	@rm -f driver temporary
	@rm -rf input-after
	@echo "$(GREEN)Clean complete.$(NC)"
