################################################################################
# Makefile for CS1200 Discrete Mathematics
#
# This makefile provides a unified build system for all homework assignments
# in the CS1200 Discrete Mathematics course.
#
# Usage:
#   make build                - Build all targets
#   make build TARGET=<name>  - Build specific target (e.g., homework1)
#   make run                  - List all available targets
#   make run TARGET=<name>    - Run specific target
#   make autorun TARGET=<name>- Run target with input from input/<name>.txt
#   make clean                - Remove all build artifacts
#   make list                 - List all available targets
#   make help                 - Show this help message
################################################################################

# Compiler settings
CXX = g++
CXXFLAGS = -Wall -Wextra -std=c++11 -g

# Directory settings
BUILD_DIR = build
INPUT_DIR = ../../input

# Create build directory if it doesn't exist
$(shell mkdir -p $(BUILD_DIR))

################################################################################
# Target Definitions
################################################################################

# C++ Targets
CPP_TARGETS = homework1 homework2 homework3 homework4 homework5 homework6

# Python Targets (informational only)
PYTHON_TARGETS = homework4_hamming homework5_montyhall

# All targets
ALL_TARGETS = $(CPP_TARGETS)

################################################################################
# Default and Help Targets
################################################################################

.PHONY: all help list build clean run autorun

all: help

help:
	@echo "CS1200 Discrete Mathematics Build System"
	@echo "========================================="
	@echo ""
	@echo "Build Commands:"
	@echo "  make build                - Build all C++ targets"
	@echo "  make build TARGET=<name>  - Build specific target"
	@echo ""
	@echo "Run Commands:"
	@echo "  make run                  - List all available targets"
	@echo "  make run TARGET=<name>    - Run specific target"
	@echo "  make autorun TARGET=<name>- Run with input from input/<name>.txt"
	@echo ""
	@echo "Other Commands:"
	@echo "  make clean                - Remove all build artifacts"
	@echo "  make list                 - List all available targets"
	@echo ""
	@echo "Use 'make list' to see all available targets"

list:
	@echo "Available targets:"
	@echo "=================="
	@echo ""
	@echo "C++ Programs:"
	@echo "  homework1   - Argument form printer"
	@echo "  homework2   - Magic number checker (Collatz conjecture)"
	@echo "  homework3   - Factorial calculator with LaTeX output"
	@echo "  homework4   - Binary/Gray code converter"
	@echo "  homework5   - Monty Hall simulation"
	@echo "  homework6   - Hello World template"
	@echo ""
	@echo "Python Scripts (run directly):"
	@echo "  Homework #4/Python/Hamming Distance Calculator.py"
	@echo "  Homework #5/Monty Hall.py"

################################################################################
# Build Rules
################################################################################

build:
ifdef TARGET
	@$(MAKE) build_$(TARGET)
else
	@$(MAKE) build_all
endif

build_all: build_homework1 build_homework2 build_homework3 build_homework4 build_homework5 build_homework6
	@echo "All targets built successfully"

# Homework 1 - Argument form printer
.PHONY: build_homework1
build_homework1:
	@echo "Building homework1..."
	@$(CXX) $(CXXFLAGS) -I"Homework #1/Homework 1" \
		"Homework #1/Homework 1/main.cpp" \
		"Homework #1/Homework 1/Argument.cpp" \
		-o $(BUILD_DIR)/homework1

# Homework 2 - Magic number checker
.PHONY: build_homework2
build_homework2:
	@echo "Building homework2..."
	@$(CXX) $(CXXFLAGS) \
		"Homework #2/Homework 2/main.cpp" \
		-o $(BUILD_DIR)/homework2

# Homework 3 - Factorial calculator
.PHONY: build_homework3
build_homework3:
	@echo "Building homework3..."
	@$(CXX) $(CXXFLAGS) -I"Homework #3/Homework #3" \
		"Homework #3/Homework #3/main.cpp" \
		"Homework #3/Homework #3/Factorial.cpp" \
		-o $(BUILD_DIR)/homework3

# Homework 4 - Binary/Gray code converter
.PHONY: build_homework4
build_homework4:
	@echo "Building homework4..."
	@$(CXX) $(CXXFLAGS) -I"Homework #4/Homework #4" \
		"Homework #4/Homework #4/main.cpp" \
		"Homework #4/Homework #4/Functions.cpp" \
		-o $(BUILD_DIR)/homework4

# Homework 5 - Monty Hall simulation
.PHONY: build_homework5
build_homework5:
	@echo "Building homework5..."
	@$(CXX) $(CXXFLAGS) -I"Homework #5/Homework #5" \
		"Homework #5/Homework #5/main.cpp" \
		"Homework #5/Homework #5/MontyHall.cpp" \
		-o $(BUILD_DIR)/homework5

# Homework 6 - Hello World template
.PHONY: build_homework6
build_homework6:
	@echo "Building homework6..."
	@$(CXX) $(CXXFLAGS) \
		"Homework #6/Homework #6/main.cpp" \
		-o $(BUILD_DIR)/homework6

################################################################################
# Run Rules
################################################################################

run:
ifndef TARGET
	@echo "Available targets to run:"
	@echo "========================="
	@echo ""
	@echo "C++ Programs:"
	@for target in $(CPP_TARGETS); do \
		if [ -f $(BUILD_DIR)/$$target ]; then \
			echo "  $$target [built]"; \
		else \
			echo "  $$target [not built]"; \
		fi; \
	done
	@echo ""
	@echo "Usage: make run TARGET=<name>"
else
	@if echo "$(CPP_TARGETS)" | grep -qw "$(TARGET)"; then \
		if [ -f $(BUILD_DIR)/$(TARGET) ]; then \
			echo "Running $(TARGET)..."; \
			$(BUILD_DIR)/$(TARGET); \
		else \
			echo "Error: $(TARGET) not built. Run 'make build TARGET=$(TARGET)' first"; \
			exit 1; \
		fi; \
	else \
		echo "Error: Unknown target '$(TARGET)'"; \
		echo "Use 'make list' to see available targets"; \
		exit 1; \
	fi
endif

autorun:
ifndef TARGET
	@echo "Error: TARGET not specified"
	@echo "Usage: make autorun TARGET=<name>"
	@echo "This will run the target with input from $(INPUT_DIR)/<name>.txt"
else
	@if echo "$(CPP_TARGETS)" | grep -qw "$(TARGET)"; then \
		if [ -f $(BUILD_DIR)/$(TARGET) ]; then \
			if [ -f $(INPUT_DIR)/cs1200-$(TARGET).txt ]; then \
				echo "Running $(TARGET) with input from $(INPUT_DIR)/cs1200-$(TARGET).txt..."; \
				$(BUILD_DIR)/$(TARGET) < $(INPUT_DIR)/cs1200-$(TARGET).txt; \
			else \
				echo "Warning: No input file found at $(INPUT_DIR)/cs1200-$(TARGET).txt"; \
				echo "Running without input..."; \
				$(BUILD_DIR)/$(TARGET); \
			fi; \
		else \
			echo "Error: $(TARGET) not built. Run 'make build TARGET=$(TARGET)' first"; \
			exit 1; \
		fi; \
	else \
		echo "Error: Unknown target '$(TARGET)'"; \
		echo "Use 'make list' to see available targets"; \
		exit 1; \
	fi
endif

################################################################################
# Clean Rules
################################################################################

clean:
	@echo "Cleaning build artifacts..."
	@rm -rf $(BUILD_DIR)
	@echo "Clean complete"
