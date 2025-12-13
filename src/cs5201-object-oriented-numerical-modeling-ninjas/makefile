# CS5201 Object-Oriented Numerical Modeling - Build System
# Graduate-level C++ numerical modeling with templates, exceptions, and testing.
# Each homework assignment has its own makefile with driver and test targets.
#
# Available targets:
#   make build              - Verify all source files exist
#   make build TARGET=X     - Verify specific homework
#   make run TARGET=X       - Show run instructions
#   make autorun TARGET=X   - Show run instructions
#   make list               - List available targets
#   make clean              - Remove all build artifacts
#   make help               - Display this help message
#
# Note: Original code requires Linux with g++-7, gcov-7, and C++17 filesystem.
#       On macOS, compilation may require modifications to the original makefiles.

# ==============================================================================
# Configuration
# ==============================================================================

# Directories
BUILD_DIR = .build
HW_DIRS = 2018-sp-a-hw2-isgx2 2018-sp-a-hw3-isgx2 2018-sp-a-hw4-isgx2 2018-sp-a-hw5-isgx2 2018-sp-a-hw6-isgx2

# Color output for better readability
RED = \033[0;31m
GREEN = \033[0;32m
YELLOW = \033[1;33m
CYAN = \033[1;36m
NC = \033[0m

# Available targets
TARGETS = homework2 homework3 homework4 homework5 homework6

# ==============================================================================
# Main Targets
# ==============================================================================

.PHONY: all help build run autorun test list clean

# Default target
all: help

# Help target - displays available commands
help:
	@echo "$(CYAN)CS5201 Object-Oriented Numerical Modeling - Build System$(NC)"
	@echo "$(YELLOW)Graduate-level C++ numerical modeling$(NC)"
	@echo ""
	@echo "$(YELLOW)Usage:$(NC)"
	@echo "  make build              - Verify all source files exist"
	@echo "  make build TARGET=X     - Verify specific homework"
	@echo "  make run TARGET=X       - Show run instructions"
	@echo "  make list               - List available targets"
	@echo "  make clean              - Remove all build artifacts"
	@echo ""
	@echo "$(YELLOW)Available Targets:$(NC)"
	@echo "  homework2  - Polar pairs and norms"
	@echo "  homework3  - Vectors and lower triangular matrices"
	@echo "  homework4  - Interpolation"
	@echo "  homework5  - Gaussian elimination and square matrices"
	@echo "  homework6  - Steepest descent solver with matrix types"
	@echo ""
	@echo "$(YELLOW)Build Requirements:$(NC)"
	@echo "  - Linux with g++-7 and gcov-7"
	@echo "  - C++17 with filesystem support (-lstdc++fs)"
	@echo "  - Catch testing framework (included)"

# List available targets
list:
	@echo "$(CYAN)Available targets:$(NC)"
	@for target in $(TARGETS); do \
		echo "  $$target"; \
	done

# ==============================================================================
# Build Targets (Verification)
# ==============================================================================

.PHONY: build

build:
ifdef TARGET
	@$(MAKE) --no-print-directory build_$(TARGET)
else
	@echo "$(CYAN)Verifying all homework source files...$(NC)"
	@$(MAKE) --no-print-directory build_homework2
	@$(MAKE) --no-print-directory build_homework3
	@$(MAKE) --no-print-directory build_homework4
	@$(MAKE) --no-print-directory build_homework5
	@$(MAKE) --no-print-directory build_homework6
	@echo "$(GREEN)All source files verified!$(NC)"
	@echo ""
	@echo "$(YELLOW)Note: To compile, use original makefiles on Linux:$(NC)"
	@echo "  cd 2018-sp-a-hw6-isgx2 && make driver"
endif

build_homework2:
	@echo "$(CYAN)Verifying homework2...$(NC)"
	@if [ -f "2018-sp-a-hw2-isgx2/src/main.cpp" ] && [ -f "2018-sp-a-hw2-isgx2/makefile" ]; then \
		src_count=$$(find 2018-sp-a-hw2-isgx2 -name "*.cpp" | wc -l | tr -d ' '); \
		hdr_count=$$(find 2018-sp-a-hw2-isgx2 -name "*.h" -o -name "*.hpp" | wc -l | tr -d ' '); \
		echo "$(GREEN)✓ homework2: $$src_count source, $$hdr_count headers$(NC)"; \
	else \
		echo "$(RED)Error: homework2 files not found$(NC)"; \
		exit 1; \
	fi

build_homework3:
	@echo "$(CYAN)Verifying homework3...$(NC)"
	@if [ -f "2018-sp-a-hw3-isgx2/src/main.cpp" ] && [ -f "2018-sp-a-hw3-isgx2/makefile" ]; then \
		src_count=$$(find 2018-sp-a-hw3-isgx2 -name "*.cpp" | wc -l | tr -d ' '); \
		hdr_count=$$(find 2018-sp-a-hw3-isgx2 -name "*.h" -o -name "*.hpp" | wc -l | tr -d ' '); \
		echo "$(GREEN)✓ homework3: $$src_count source, $$hdr_count headers$(NC)"; \
	else \
		echo "$(RED)Error: homework3 files not found$(NC)"; \
		exit 1; \
	fi

build_homework4:
	@echo "$(CYAN)Verifying homework4...$(NC)"
	@if [ -f "2018-sp-a-hw4-isgx2/src/main.cpp" ] && [ -f "2018-sp-a-hw4-isgx2/makefile" ]; then \
		src_count=$$(find 2018-sp-a-hw4-isgx2 -name "*.cpp" | wc -l | tr -d ' '); \
		hdr_count=$$(find 2018-sp-a-hw4-isgx2 -name "*.h" -o -name "*.hpp" | wc -l | tr -d ' '); \
		echo "$(GREEN)✓ homework4: $$src_count source, $$hdr_count headers$(NC)"; \
	else \
		echo "$(RED)Error: homework4 files not found$(NC)"; \
		exit 1; \
	fi

build_homework5:
	@echo "$(CYAN)Verifying homework5...$(NC)"
	@if [ -f "2018-sp-a-hw5-isgx2/src/main.cpp" ] && [ -f "2018-sp-a-hw5-isgx2/makefile" ]; then \
		src_count=$$(find 2018-sp-a-hw5-isgx2 -name "*.cpp" | wc -l | tr -d ' '); \
		hdr_count=$$(find 2018-sp-a-hw5-isgx2 -name "*.h" -o -name "*.hpp" | wc -l | tr -d ' '); \
		echo "$(GREEN)✓ homework5: $$src_count source, $$hdr_count headers$(NC)"; \
	else \
		echo "$(RED)Error: homework5 files not found$(NC)"; \
		exit 1; \
	fi

build_homework6:
	@echo "$(CYAN)Verifying homework6...$(NC)"
	@if [ -f "2018-sp-a-hw6-isgx2/src/main.cpp" ] && [ -f "2018-sp-a-hw6-isgx2/makefile" ]; then \
		src_count=$$(find 2018-sp-a-hw6-isgx2 -name "*.cpp" | wc -l | tr -d ' '); \
		hdr_count=$$(find 2018-sp-a-hw6-isgx2 -name "*.h" -o -name "*.hpp" | wc -l | tr -d ' '); \
		echo "$(GREEN)✓ homework6: $$src_count source, $$hdr_count headers$(NC)"; \
	else \
		echo "$(RED)Error: homework6 files not found$(NC)"; \
		exit 1; \
	fi

# ==============================================================================
# Run Targets
# ==============================================================================

.PHONY: run autorun

run:
ifdef TARGET
	@hw_num=$$(echo $(TARGET) | sed 's/homework//'); \
	dir="2018-sp-a-hw$${hw_num}-isgx2"; \
	echo "$(CYAN)$(TARGET) - Run Instructions$(NC)"; \
	echo "$(YELLOW)To build and run on Linux:$(NC)"; \
	echo "  cd $$dir"; \
	echo "  make driver"; \
	echo "  ./driver"; \
	echo ""; \
	echo "$(YELLOW)To run tests:$(NC)"; \
	echo "  make test"
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
	@$(MAKE) --no-print-directory run TARGET=homework6
endif

# ==============================================================================
# Test Targets
# ==============================================================================

.PHONY: test

test:
	@echo "$(CYAN)Test Instructions$(NC)"
	@echo "$(YELLOW)To run tests on Linux (requires g++-7, gcov-7):$(NC)"
	@echo ""
	@for dir in $(HW_DIRS); do \
		echo "  cd $$dir && make test"; \
	done
	@echo ""
	@echo "$(YELLOW)Tests use Catch framework with coverage analysis.$(NC)"

# ==============================================================================
# Clean Target
# ==============================================================================

clean:
	@echo "$(YELLOW)Cleaning all build artifacts...$(NC)"
	@rm -rf $(BUILD_DIR)
	@for dir in $(HW_DIRS); do \
		if [ -d "$$dir" ]; then \
			echo "  Cleaning $$dir..."; \
			cd $$dir && $(MAKE) clean 2>/dev/null || true; \
			cd ..; \
		fi; \
	done
	@echo "$(GREEN)Clean complete.$(NC)"
