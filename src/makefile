# Master Build System for All Course Projects
# This makefile provides a unified interface for building and running
# all course projects across the entire academic portfolio.

# Color output for better readability
RED = \033[0;31m
GREEN = \033[0;32m
YELLOW = \033[1;33m
BLUE = \033[1;34m
MAGENTA = \033[1;35m
CYAN = \033[1;36m
NC = \033[0m # No Color

# Course directories with makefiles
COURSES_WITH_MAKEFILES = cpe3150-micro-embedded-design cs1001-data-structures-lab

# Default target
.PHONY: all
all: help

# Help target - displays available commands
.PHONY: help
help:
	@echo "$(BLUE)╔════════════════════════════════════════════════════════════╗$(NC)"
	@echo "$(BLUE)║$(NC)  $(GREEN)Master Build System - Academic Portfolio$(NC)                 $(BLUE)║$(NC)"
	@echo "$(BLUE)╚════════════════════════════════════════════════════════════╝$(NC)"
	@echo ""
	@echo "$(YELLOW)Global Commands:$(NC)"
	@echo "  make build-all            - Build all courses"
	@echo "  make build COURSE=<name>  - Build specific course"
	@echo "  make test-all             - Run all tests"
	@echo "  make clean-all            - Clean all build artifacts"
	@echo "  make list-courses         - List all available courses"
	@echo ""
	@echo "$(YELLOW)Course-Specific Commands:$(NC)"
	@echo "  make <course>-build       - Build specific course"
	@echo "  make <course>-run         - Run targets in specific course"
	@echo "  make <course>-test        - Test specific course"
	@echo "  make <course>-clean       - Clean specific course"
	@echo ""
	@echo "$(CYAN)Available Courses:$(NC)"
	@for course in $(COURSES_WITH_MAKEFILES); do \
		echo "  • $$course"; \
	done

# Build all courses
.PHONY: build-all
build-all:
	@echo "$(GREEN)Building all courses...$(NC)"
	@for course in $(COURSES_WITH_MAKEFILES); do \
		echo "$(CYAN)════════════════════════════════════════$(NC)"; \
		echo "$(CYAN)Building $$course...$(NC)"; \
		echo "$(CYAN)════════════════════════════════════════$(NC)"; \
		$(MAKE) -C $$course build || exit 1; \
		echo ""; \
	done
	@echo "$(GREEN)✓ All courses built successfully!$(NC)"

# Build specific course
.PHONY: build
build:
ifdef COURSE
	@if [ -d "$(COURSE)" ] && [ -f "$(COURSE)/makefile" -o -f "$(COURSE)/Makefile" ]; then \
		echo "$(GREEN)Building $(COURSE)...$(NC)"; \
		$(MAKE) -C $(COURSE) build; \
	else \
		echo "$(RED)Error: Course '$(COURSE)' not found or has no makefile$(NC)"; \
		exit 1; \
	fi
else
	@echo "$(RED)Error: Please specify COURSE=<name>$(NC)"
	@echo "Example: make build COURSE=cpe3150-micro-embedded-design"
endif

# Test all courses
.PHONY: test-all
test-all:
	@echo "$(GREEN)Running tests for all courses...$(NC)"
	@for course in $(COURSES_WITH_MAKEFILES); do \
		echo "$(CYAN)Testing $$course...$(NC)"; \
		$(MAKE) -C $$course test || true; \
		echo ""; \
	done

# Clean all courses
.PHONY: clean-all
clean-all:
	@echo "$(YELLOW)Cleaning all courses...$(NC)"
	@for course in $(COURSES_WITH_MAKEFILES); do \
		echo "Cleaning $$course..."; \
		$(MAKE) -C $$course clean || true; \
	done
	@echo "$(GREEN)✓ All courses cleaned$(NC)"

# List all courses
.PHONY: list-courses
list-courses:
	@echo "$(CYAN)Available courses with build systems:$(NC)"
	@echo ""
	@for course in $(COURSES_WITH_MAKEFILES); do \
		echo "$(GREEN)$$course$(NC)"; \
		if [ -f "$$course/makefile" -o -f "$$course/Makefile" ]; then \
			$(MAKE) -C $$course list 2>/dev/null || echo "  (no list target)"; \
		fi; \
		echo ""; \
	done

# CPE3150 Micro/Embedded Design specific targets
.PHONY: cpe3150-micro-embedded-design-build
cpe3150-micro-embedded-design-build:
	@echo "$(CYAN)Building CPE3150 Micro/Embedded Design...$(NC)"
	@$(MAKE) -C cpe3150-micro-embedded-design build

.PHONY: cpe3150-micro-embedded-design-run
cpe3150-micro-embedded-design-run:
	@echo "$(CYAN)Running CPE3150 targets...$(NC)"
	@$(MAKE) -C cpe3150-micro-embedded-design run

.PHONY: cpe3150-micro-embedded-design-test
cpe3150-micro-embedded-design-test:
	@echo "$(CYAN)Testing CPE3150...$(NC)"
	@$(MAKE) -C cpe3150-micro-embedded-design test

.PHONY: cpe3150-micro-embedded-design-clean
cpe3150-micro-embedded-design-clean:
	@echo "$(CYAN)Cleaning CPE3150...$(NC)"
	@$(MAKE) -C cpe3150-micro-embedded-design clean

# Shorthand aliases for CPE3150
.PHONY: cpe3150-build cpe3150-run cpe3150-test cpe3150-clean
cpe3150-build: cpe3150-micro-embedded-design-build
cpe3150-run: cpe3150-micro-embedded-design-run
cpe3150-test: cpe3150-micro-embedded-design-test
cpe3150-clean: cpe3150-micro-embedded-design-clean

# CS1001 Data Structures Lab specific targets
.PHONY: cs1001-data-structures-lab-build
cs1001-data-structures-lab-build:
	@echo "$(CYAN)Building CS1001 Data Structures Lab...$(NC)"
	@$(MAKE) -C cs1001-data-structures-lab build

.PHONY: cs1001-data-structures-lab-run
cs1001-data-structures-lab-run:
	@echo "$(CYAN)Running CS1001 targets...$(NC)"
	@$(MAKE) -C cs1001-data-structures-lab run

.PHONY: cs1001-data-structures-lab-test
cs1001-data-structures-lab-test:
	@echo "$(CYAN)Testing CS1001...$(NC)"
	@$(MAKE) -C cs1001-data-structures-lab test

.PHONY: cs1001-data-structures-lab-clean
cs1001-data-structures-lab-clean:
	@echo "$(CYAN)Cleaning CS1001...$(NC)"
	@$(MAKE) -C cs1001-data-structures-lab clean

# Shorthand aliases for CS1001
.PHONY: cs1001-build cs1001-run cs1001-test cs1001-clean
cs1001-build: cs1001-data-structures-lab-build
cs1001-run: cs1001-data-structures-lab-run
cs1001-test: cs1001-data-structures-lab-test
cs1001-clean: cs1001-data-structures-lab-clean

# Additional course targets can be added here as more makefiles are created
# Template for adding new courses:
# .PHONY: <course-name>-build <course-name>-run <course-name>-test <course-name>-clean
# <course-name>-build:
#	@$(MAKE) -C <course-name> build
# ...

# Utility targets
.PHONY: stats
stats:
	@echo "$(CYAN)Course Statistics:$(NC)"
	@echo "Total courses with makefiles: $(words $(COURSES_WITH_MAKEFILES))"
	@for course in $(COURSES_WITH_MAKEFILES); do \
		if [ -d "$$course" ]; then \
			file_count=$$(find $$course -type f \( -name "*.c" -o -name "*.cpp" -o -name "*.h" -o -name "*.hpp" -o -name "*.a51" -o -name "*.asm" \) | wc -l); \
			echo "  $$course: $$file_count source files"; \
		fi; \
	done

# Quick test build for validation
.PHONY: validate
validate:
	@echo "$(YELLOW)Validating build systems...$(NC)"
	@failed=0; \
	for course in $(COURSES_WITH_MAKEFILES); do \
		echo -n "  $$course: "; \
		if $(MAKE) -C $$course build > /dev/null 2>&1; then \
			echo "$(GREEN)✓$(NC)"; \
		else \
			echo "$(RED)✗$(NC)"; \
			failed=$$((failed + 1)); \
		fi; \
	done; \
	if [ $$failed -eq 0 ]; then \
		echo "$(GREEN)All build systems validated successfully!$(NC)"; \
	else \
		echo "$(RED)$$failed course(s) failed validation$(NC)"; \
		exit 1; \
	fi