# ====================================================================
# CPE3150 Micro/Embedded Design - Build System
# ====================================================================
# This makefile provides a unified build interface for all assignments 
# and projects in the CPE3150 Micro/Embedded Design course.
#
# Usage:
#   make build                  - Build all compilable targets
#   make build TARGET=<name>    - Build specific target
#   make test                   - Run tests (if available)
#   make run                    - List and run all targets interactively
#   make run TARGET=<name>      - Run specific target
#   make autorun TARGET=<name>  - Run target with piped input from input/
#   make clean                  - Remove all build artifacts
#   make list                   - List all available targets
#   make help                   - Show this help message
# ====================================================================

# Compiler Configuration
# ----------------------
AS51 = as51                    # 8051 assembler
CC = gcc                       # Standard C compiler
SDCC = sdcc                    # Small Device C Compiler for 8051
CFLAGS = -g -Wall             # Debug symbols and all warnings
SDCCFLAGS = -mmcs51           # Target 8051 microcontroller
LIBS = -lm -lncurses          # Math and ncurses libraries

# Terminal Color Codes
# --------------------
RED = \033[0;31m
GREEN = \033[0;32m
YELLOW = \033[1;33m
BLUE = \033[1;34m
CYAN = \033[1;36m
NC = \033[0m # No Color

# Build Targets List
# ------------------
# Standard C targets that can be compiled with gcc
STANDARD_C_TARGETS = homework-6-3 space-invaders

# 8051 microcontroller targets (require specialized tools)
EMBEDDED_TARGETS = homework-6-1 homework-6-2 homework-6-4 homework-6-5 project-1 penrose-music

# All targets combined
ALL_TARGETS = $(STANDARD_C_TARGETS) $(EMBEDDED_TARGETS)

# Default target shows help
.PHONY: all
all: help

# Help Target
# -----------
# Displays comprehensive usage information
.PHONY: help
help:
	@echo "$(BLUE)╔════════════════════════════════════════════════════════════╗$(NC)"
	@echo "$(BLUE)║$(NC)  $(GREEN)CPE3150 Micro/Embedded Design - Build System$(NC)             $(BLUE)║$(NC)"
	@echo "$(BLUE)╚════════════════════════════════════════════════════════════╝$(NC)"
	@echo ""
	@echo "$(YELLOW)Build Commands:$(NC)"
	@echo "  make build                  - Build all compilable projects"
	@echo "  make build TARGET=<name>    - Build specific target"
	@echo ""
	@echo "$(YELLOW)Execution Commands:$(NC)"
	@echo "  make run                    - List and run all targets interactively"
	@echo "  make run TARGET=<name>      - Run specific target"
	@echo "  make autorun TARGET=<name>  - Run with input from input/<name>.txt"
	@echo ""
	@echo "$(YELLOW)Maintenance Commands:$(NC)"
	@echo "  make test                   - Run tests (if available)"
	@echo "  make clean                  - Remove all build artifacts"
	@echo "  make list                   - List all available targets"
	@echo ""
	@echo "$(CYAN)Compilable Targets (Standard C):$(NC)"
	@echo "  • homework-6-3              - Homework 6, Problem 3"
	@echo "  • space-invaders            - Project 3: Space Invaders Game"
	@echo ""
	@echo "$(CYAN)8051 Microcontroller Targets:$(NC)"
	@echo "  • homework-6-1 through 6-5  - Embedded C for 8051"
	@echo "  • project-1                 - 8051 Assembly Project"
	@echo "  • penrose-music             - Music Player on 8051"

# ====================================================================
# Build Targets
# ====================================================================

# Main Build Target
# -----------------
# Builds all compilable targets or a specific target if TARGET is specified
.PHONY: build
build:
ifdef TARGET
	@echo "$(GREEN)Building specific target: $(TARGET)$(NC)"
	@if echo "$(STANDARD_C_TARGETS)" | grep -wq "$(TARGET)"; then \
		$(MAKE) build-$(TARGET); \
	elif echo "$(EMBEDDED_TARGETS)" | grep -wq "$(TARGET)"; then \
		echo "$(YELLOW)Warning: $(TARGET) requires 8051 tools (SDCC/Keil)$(NC)"; \
		$(MAKE) build-$(TARGET); \
	else \
		echo "$(RED)Error: Unknown target '$(TARGET)'$(NC)"; \
		echo "$(YELLOW)Run 'make list' to see available targets$(NC)"; \
		exit 1; \
	fi
else
	@echo "$(GREEN)Building all compilable targets...$(NC)"
	@echo "$(CYAN)──────────────────────────────────────$(NC)"
	@for target in $(STANDARD_C_TARGETS); do \
		$(MAKE) build-$$target || exit 1; \
	done
	@echo "$(CYAN)──────────────────────────────────────$(NC)"
	@echo "$(GREEN)✓ All standard C targets built successfully!$(NC)"
	@echo ""
	@echo "$(YELLOW)Note: Embedded targets require 8051 tools$(NC)"
endif

# Individual Build Targets
# ------------------------

# Homework 6, Problem 3 - Standard C program
.PHONY: build-homework-6-3
build-homework-6-3:
	@echo "$(CYAN)Building homework-6-3...$(NC)"
	@$(CC) $(CFLAGS) homework-6/3.c -o homework-6/homework-6-3
	@echo "$(GREEN)✓ homework-6-3 built successfully$(NC)"

# Space Invaders Game - Standard C with ncurses
.PHONY: build-space-invaders
build-space-invaders:
	@echo "$(CYAN)Building space-invaders...$(NC)"
	@cd project-3/code/space-invaders && \
		$(MAKE) clean >/dev/null 2>&1 && \
		$(MAKE) >/dev/null 2>&1
	@mv project-3/code/space-invaders/build \
		project-3/code/space-invaders/space-invaders 2>/dev/null || true
	@echo "$(GREEN)✓ space-invaders built successfully$(NC)"

# 8051 Embedded Targets (require specialized tools)
# --------------------------------------------------

.PHONY: build-homework-6-1
build-homework-6-1:
	@echo "$(YELLOW)homework-6-1: 8051 C (requires SDCC/Keil)$(NC)"
	@echo "  Source: homework-6/1.c (LaTeX embedded)"

.PHONY: build-homework-6-2
build-homework-6-2:
	@echo "$(YELLOW)homework-6-2: 8051 C (requires SDCC/Keil)$(NC)"
	@echo "  Source: homework-6/2.c"

.PHONY: build-homework-6-4
build-homework-6-4:
	@echo "$(YELLOW)homework-6-4: 8051 C (requires SDCC/Keil)$(NC)"
	@echo "  Source: homework-6/4.c"

.PHONY: build-homework-6-5
build-homework-6-5:
	@echo "$(YELLOW)homework-6-5: 8051 C (requires SDCC/Keil)$(NC)"
	@echo "  Source: homework-6/5.c"

.PHONY: build-project-1
build-project-1:
	@echo "$(YELLOW)project-1: 8051 Assembly (requires Keil uVision)$(NC)"
	@echo "  Pre-built: project-1/code/Objects/project1.hex"

.PHONY: build-penrose-music
build-penrose-music:
	@echo "$(YELLOW)penrose-music: 8051 C (requires SDCC/Keil)$(NC)"
	@echo "  Source: project-3/code/penrose-music/"

# ====================================================================
# Test Target
# ====================================================================
# Runs available tests (most embedded projects were hardware-tested)
.PHONY: test
test:
	@echo "$(YELLOW)No automated tests available for CPE3150$(NC)"
	@echo "Note: Projects were tested on 8051 hardware"

# ====================================================================
# Run Targets
# ====================================================================

# Main Run Target
# ---------------
# Runs specific target or lists all runnable targets
.PHONY: run
run:
ifdef TARGET
	@if echo "$(STANDARD_C_TARGETS)" | grep -wq "$(TARGET)"; then \
		echo "$(GREEN)Running: $(TARGET)$(NC)"; \
		$(MAKE) run-$(TARGET); \
	else \
		echo "$(RED)Error: '$(TARGET)' is not a runnable target$(NC)"; \
		echo "$(YELLOW)Available targets: $(STANDARD_C_TARGETS)$(NC)"; \
		exit 1; \
	fi
else
	@echo "$(CYAN)Available run targets:$(NC)"
	@for target in $(STANDARD_C_TARGETS); do \
		echo "  • $$target"; \
	done
	@echo ""
	@echo "$(YELLOW)To run a specific target:$(NC)"
	@echo "  make run TARGET=<name>"
	@echo ""
	@echo "$(YELLOW)To run all targets interactively:$(NC)"
	@built=0; \
	for target in $(STANDARD_C_TARGETS); do \
		binary=""; \
		if [ "$$target" = "homework-6-3" ]; then \
			binary="homework-6/homework-6-3"; \
		elif [ "$$target" = "space-invaders" ]; then \
			binary="project-3/code/space-invaders/space-invaders"; \
		fi; \
		if [ -f "$$binary" ]; then \
			built=$$((built + 1)); \
			echo "$(GREEN)[$$built] Running $$target...$(NC)"; \
			echo "Press Enter to run, or Ctrl+C to skip"; \
			read dummy; \
			$$binary || true; \
			echo ""; \
		else \
			echo "$(YELLOW)$$target not built (run 'make build TARGET=$$target')$(NC)"; \
		fi; \
	done; \
	if [ $$built -eq 0 ]; then \
		echo "$(RED)No targets built yet. Run 'make build' first$(NC)"; \
	fi
endif

# Individual Run Targets
# ----------------------

.PHONY: run-homework-6-3
run-homework-6-3:
	@if [ -f "homework-6/homework-6-3" ]; then \
		./homework-6/homework-6-3; \
	else \
		echo "$(RED)Error: homework-6-3 not built$(NC)"; \
		echo "$(YELLOW)Run: make build TARGET=homework-6-3$(NC)"; \
		exit 1; \
	fi

.PHONY: run-space-invaders
run-space-invaders:
	@if [ -f "project-3/code/space-invaders/space-invaders" ]; then \
		./project-3/code/space-invaders/space-invaders; \
	else \
		echo "$(RED)Error: space-invaders not built$(NC)"; \
		echo "$(YELLOW)Run: make build TARGET=space-invaders$(NC)"; \
		exit 1; \
	fi

# ====================================================================
# Autorun Targets
# ====================================================================
# Runs targets with piped input from input/ directory

.PHONY: autorun
autorun:
ifdef TARGET
	@if echo "$(STANDARD_C_TARGETS)" | grep -wq "$(TARGET)"; then \
		echo "$(GREEN)Auto-running: $(TARGET)$(NC)"; \
		input_file="../../input/cpe3150-$(TARGET).txt"; \
		if [ -f "$$input_file" ]; then \
			echo "$(CYAN)Using input from: $$input_file$(NC)"; \
			$(MAKE) autorun-$(TARGET); \
		else \
			echo "$(YELLOW)No input file found at: $$input_file$(NC)"; \
			echo "$(YELLOW)Creating empty input file...$(NC)"; \
			mkdir -p ../../input; \
			touch "$$input_file"; \
			echo "$(CYAN)Running with empty input...$(NC)"; \
			$(MAKE) autorun-$(TARGET); \
		fi; \
	else \
		echo "$(RED)Error: '$(TARGET)' is not a valid autorun target$(NC)"; \
		echo "$(YELLOW)Available targets: $(STANDARD_C_TARGETS)$(NC)"; \
		exit 1; \
	fi
else
	@echo "$(RED)Error: Please specify TARGET for autorun$(NC)"
	@echo "Example: make autorun TARGET=homework-6-3"
endif

# Individual Autorun Targets
# --------------------------

.PHONY: autorun-homework-6-3
autorun-homework-6-3:
	@if [ -f "homework-6/homework-6-3" ]; then \
		input_file="../../input/cpe3150-homework-6-3.txt"; \
		if [ -f "$$input_file" ]; then \
			./homework-6/homework-6-3 < "$$input_file"; \
		else \
			./homework-6/homework-6-3; \
		fi; \
	else \
		echo "$(RED)Error: homework-6-3 not built$(NC)"; \
		exit 1; \
	fi

.PHONY: autorun-space-invaders
autorun-space-invaders:
	@if [ -f "project-3/code/space-invaders/space-invaders" ]; then \
		input_file="../../input/cpe3150-space-invaders.txt"; \
		if [ -f "$$input_file" ]; then \
			./project-3/code/space-invaders/space-invaders < "$$input_file"; \
		else \
			./project-3/code/space-invaders/space-invaders; \
		fi; \
	else \
		echo "$(RED)Error: space-invaders not built$(NC)"; \
		exit 1; \
	fi

# ====================================================================
# Clean Target
# ====================================================================
# Removes all build artifacts
.PHONY: clean
clean:
	@echo "$(YELLOW)Cleaning build artifacts...$(NC)"
	@rm -f homework-6/homework-6-3
	@rm -f homework-6/homework-6-1 homework-6/homework-6-2
	@rm -f homework-6/homework-6-4 homework-6/homework-6-5
	@cd project-3/code/space-invaders && \
		$(MAKE) clean >/dev/null 2>&1 || true
	@rm -f project-3/code/space-invaders/space-invaders
	@echo "$(GREEN)✓ Clean complete$(NC)"

# ====================================================================
# List Target
# ====================================================================
# Lists all available targets with descriptions
.PHONY: list
list:
	@echo "$(BLUE)╔════════════════════════════════════════════════════════════╗$(NC)"
	@echo "$(BLUE)║$(NC)  $(GREEN)Available Build Targets$(NC)                                   $(BLUE)║$(NC)"
	@echo "$(BLUE)╚════════════════════════════════════════════════════════════╝$(NC)"
	@echo ""
	@echo "$(CYAN)Standard C Targets (Compilable):$(NC)"
	@echo "  • homework-6-3    - Bit manipulation program"
	@echo "  • space-invaders  - Terminal-based game with ncurses"
	@echo ""
	@echo "$(CYAN)8051 Embedded Targets (Require SDCC/Keil):$(NC)"
	@echo "  • homework-6-1    - Binary to decimal converter"
	@echo "  • homework-6-2    - ROM data reader"
	@echo "  • homework-6-4    - 16-bit multiplication"
	@echo "  • homework-6-5    - Power calculation"
	@echo "  • project-1       - Music player (Assembly)"
	@echo "  • penrose-music   - Advanced music system"