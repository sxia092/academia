# CS1580 Introduction to Programming Lab - Build System
# Builds and runs all lab assignments
#
# Available Targets:
#   lab1  - Hello World
#   lab2  - Multiplication calculator
#   lab3  - BMI calculator
#   lab4  - Calculator averager
#   lab5  - E-Voting system
#   lab6  - Harmonic and arithmetic mean
#   lab7  - Random number generator
#   lab8  - Xcode project (simple)
#   lab9  - Multi-file project
#   lab10 - User registration
#   lab11 - File I/O
#   lab12 - Time class (multi-file)
#   lab13 - Rectangle class
#   lab14 - Template Array class
#   lab15 - Final lab
#
# Usage:
#   make build                 - Build all targets
#   make build TARGET=lab3     - Build specific target
#   make run TARGET=lab3       - Run specific target (interactive)
#   make autorun TARGET=lab3   - Run with piped input from input/
#   make list                  - List all targets
#   make clean                 - Remove build artifacts
#   make help                  - Show this help

# Compiler settings
CXX = g++
CXXFLAGS = -Wall -Wextra -std=c++11 -g

# Directories
BUILD_DIR = .build
INPUT_DIR = ../../input

# Color output
RED = \033[0;31m
GREEN = \033[0;32m
YELLOW = \033[1;33m
CYAN = \033[0;36m
NC = \033[0m

# All available targets
ALL_TARGETS = lab1 lab2 lab3 lab4 lab5 lab6 lab7 lab8 lab9 lab10 lab11 lab12 lab13 lab14 lab15

# Default target
.PHONY: all
all: help

# Help target
.PHONY: help
help:
	@echo "$(CYAN)CS1580 Introduction to Programming Lab - Build System$(NC)"
	@echo ""
	@echo "$(YELLOW)Usage:$(NC)"
	@echo "  make build                 - Build all targets"
	@echo "  make build TARGET=<name>   - Build specific target"
	@echo "  make run TARGET=<name>     - Run specific target (interactive)"
	@echo "  make autorun TARGET=<name> - Run with input from input/"
	@echo "  make list                  - List all targets"
	@echo "  make clean                 - Remove build artifacts"
	@echo ""
	@echo "$(YELLOW)Available Targets:$(NC)"
	@echo "  lab1  - Hello World"
	@echo "  lab2  - Multiplication calculator"
	@echo "  lab3  - BMI calculator"
	@echo "  lab4  - Calculator averager"
	@echo "  lab5  - E-Voting system"
	@echo "  lab6  - Harmonic and arithmetic mean"
	@echo "  lab7  - Random number generator"
	@echo "  lab8  - Xcode project (simple)"
	@echo "  lab9  - Multi-file project"
	@echo "  lab10 - User registration"
	@echo "  lab11 - File I/O"
	@echo "  lab12 - Time class (multi-file)"
	@echo "  lab13 - Rectangle class"
	@echo "  lab14 - Template Array class"
	@echo "  lab15 - Final lab"

# List targets
.PHONY: list
list:
	@echo "$(CYAN)Available targets:$(NC)"
	@for target in $(ALL_TARGETS); do \
		echo "  $$target"; \
	done

# Create build directory
$(BUILD_DIR):
	@mkdir -p $(BUILD_DIR)

# Build target - builds all or specific target
.PHONY: build
build: $(BUILD_DIR)
ifdef TARGET
	@$(MAKE) --no-print-directory build_$(TARGET)
else
	@echo "$(CYAN)Building all targets...$(NC)"
	@$(MAKE) --no-print-directory build_lab1
	@$(MAKE) --no-print-directory build_lab2
	@$(MAKE) --no-print-directory build_lab3
	@$(MAKE) --no-print-directory build_lab4
	@$(MAKE) --no-print-directory build_lab5
	@$(MAKE) --no-print-directory build_lab6
	@$(MAKE) --no-print-directory build_lab7
	@$(MAKE) --no-print-directory build_lab8
	@$(MAKE) --no-print-directory build_lab9
	@$(MAKE) --no-print-directory build_lab10
	@$(MAKE) --no-print-directory build_lab11
	@$(MAKE) --no-print-directory build_lab12
	@$(MAKE) --no-print-directory build_lab13
	@$(MAKE) --no-print-directory build_lab14
	@$(MAKE) --no-print-directory build_lab15
	@echo "$(GREEN)All targets built successfully.$(NC)"
endif

# Individual build targets
.PHONY: build_lab1
build_lab1: $(BUILD_DIR)
	@echo "$(CYAN)Building lab1 (Hello World)...$(NC)"
	@$(CXX) $(CXXFLAGS) lab1/lab1.cpp -o $(BUILD_DIR)/lab1
	@echo "$(GREEN)lab1 built successfully.$(NC)"

.PHONY: build_lab2
build_lab2: $(BUILD_DIR)
	@echo "$(CYAN)Building lab2 (Multiplication)...$(NC)"
	@$(CXX) $(CXXFLAGS) lab2/lab2.cpp -o $(BUILD_DIR)/lab2
	@echo "$(GREEN)lab2 built successfully.$(NC)"

.PHONY: build_lab3
build_lab3: $(BUILD_DIR)
	@echo "$(CYAN)Building lab3 (BMI Calculator)...$(NC)"
	@$(CXX) $(CXXFLAGS) lab3/Lab3.cpp -o $(BUILD_DIR)/lab3
	@echo "$(GREEN)lab3 built successfully.$(NC)"

.PHONY: build_lab4
build_lab4: $(BUILD_DIR)
	@echo "$(CYAN)Building lab4 (Calculator Averager)...$(NC)"
	@$(CXX) $(CXXFLAGS) lab4/lab4.cpp -o $(BUILD_DIR)/lab4
	@echo "$(GREEN)lab4 built successfully.$(NC)"

.PHONY: build_lab5
build_lab5: $(BUILD_DIR)
	@echo "$(CYAN)Building lab5 (E-Voting)...$(NC)"
	@$(CXX) $(CXXFLAGS) lab5/lab5.cpp -o $(BUILD_DIR)/lab5
	@echo "$(GREEN)lab5 built successfully.$(NC)"

.PHONY: build_lab6
build_lab6: $(BUILD_DIR)
	@echo "$(CYAN)Building lab6 (Mean Calculator)...$(NC)"
	@$(CXX) $(CXXFLAGS) lab6/lab6.cpp -o $(BUILD_DIR)/lab6
	@echo "$(GREEN)lab6 built successfully.$(NC)"

.PHONY: build_lab7
build_lab7: $(BUILD_DIR)
	@echo "$(CYAN)Building lab7 (Random Number Generator)...$(NC)"
	@$(CXX) $(CXXFLAGS) lab7/lab7.cpp -o $(BUILD_DIR)/lab7
	@echo "$(GREEN)lab7 built successfully.$(NC)"

.PHONY: build_lab8
build_lab8: $(BUILD_DIR)
	@echo "$(CYAN)Building lab8 (Xcode project)...$(NC)"
	@$(CXX) $(CXXFLAGS) lab8/lab8/main.cpp -o $(BUILD_DIR)/lab8
	@echo "$(GREEN)lab8 built successfully.$(NC)"

.PHONY: build_lab9
build_lab9: $(BUILD_DIR)
	@echo "$(CYAN)Building lab9 (Multi-file)...$(NC)"
	@$(CXX) $(CXXFLAGS) lab9/lab9/main.cpp lab9/lab9/lab9.cpp -o $(BUILD_DIR)/lab9
	@echo "$(GREEN)lab9 built successfully.$(NC)"

.PHONY: build_lab10
build_lab10: $(BUILD_DIR)
	@echo "$(CYAN)Building lab10 (User Registration)...$(NC)"
	@$(CXX) $(CXXFLAGS) "Lab10/Lab10/main.cpp" -o $(BUILD_DIR)/lab10
	@echo "$(GREEN)lab10 built successfully.$(NC)"

.PHONY: build_lab11
build_lab11: $(BUILD_DIR)
	@echo "$(CYAN)Building lab11 (File I/O)...$(NC)"
	@$(CXX) $(CXXFLAGS) "Lab11/Lab11/main.cpp" -o $(BUILD_DIR)/lab11
	@echo "$(GREEN)lab11 built successfully.$(NC)"

.PHONY: build_lab12
build_lab12: $(BUILD_DIR)
	@echo "$(CYAN)Building lab12 (Time Class)...$(NC)"
	@$(CXX) $(CXXFLAGS) "Lab12/Lab12/main.cpp" "Lab12/Lab12/Time.cpp" -o $(BUILD_DIR)/lab12
	@echo "$(GREEN)lab12 built successfully.$(NC)"

.PHONY: build_lab13
build_lab13: $(BUILD_DIR)
	@echo "$(CYAN)Building lab13 (Rectangle Class)...$(NC)"
	@$(CXX) $(CXXFLAGS) "Lab 13/Lab 13/main.cpp" -o $(BUILD_DIR)/lab13
	@echo "$(GREEN)lab13 built successfully.$(NC)"

.PHONY: build_lab14
build_lab14: $(BUILD_DIR)
	@echo "$(CYAN)Building lab14 (Template Array)...$(NC)"
	@$(CXX) $(CXXFLAGS) "Lab 14/Lab 14/main.cpp" -o $(BUILD_DIR)/lab14
	@echo "$(GREEN)lab14 built successfully.$(NC)"

.PHONY: build_lab15
build_lab15: $(BUILD_DIR)
	@echo "$(CYAN)Building lab15 (Final Lab)...$(NC)"
	@$(CXX) $(CXXFLAGS) "Lab 15/Lab 15/main.cpp" -o $(BUILD_DIR)/lab15
	@echo "$(GREEN)lab15 built successfully.$(NC)"

# Run target - runs specific target interactively
.PHONY: run
run:
ifndef TARGET
	@echo "$(YELLOW)Usage: make run TARGET=<name>$(NC)"
	@echo ""
	@echo "Available targets:"
	@for target in $(ALL_TARGETS); do \
		echo "  $$target"; \
	done
else
	@if [ "$(TARGET)" = "lab11" ]; then \
		echo "$(CYAN)Running lab11 (from data directory)...$(NC)"; \
		cd "Lab11/Lab11" && ../../$(BUILD_DIR)/lab11; \
	else \
		echo "$(CYAN)Running $(TARGET)...$(NC)"; \
		./$(BUILD_DIR)/$(TARGET); \
	fi
endif

# Autorun target - runs with piped input
.PHONY: autorun
autorun:
ifndef TARGET
	@echo "$(YELLOW)Usage: make autorun TARGET=<name>$(NC)"
	@echo ""
	@echo "Available targets with input files:"
	@ls -1 $(INPUT_DIR)/cs1580-*.txt 2>/dev/null | xargs -I{} basename {} | sed 's/cs1580-/  /;s/.txt//' || echo "  (no input files found)"
else
	@if [ "$(TARGET)" = "lab11" ]; then \
		echo "$(CYAN)Running lab11 with input (from data directory)...$(NC)"; \
		cd "Lab11/Lab11" && ../../$(BUILD_DIR)/lab11; \
	else \
		echo "$(CYAN)Running $(TARGET) with input...$(NC)"; \
		if [ -f "$(INPUT_DIR)/cs1580-$(TARGET).txt" ]; then \
			cat $(INPUT_DIR)/cs1580-$(TARGET).txt | ./$(BUILD_DIR)/$(TARGET); \
		else \
			echo "$(YELLOW)No input file found at $(INPUT_DIR)/cs1580-$(TARGET).txt$(NC)"; \
			echo "$(YELLOW)Running interactively...$(NC)"; \
			./$(BUILD_DIR)/$(TARGET); \
		fi; \
	fi
endif

# Clean target
.PHONY: clean
clean:
	@echo "$(CYAN)Cleaning build artifacts...$(NC)"
	@rm -rf $(BUILD_DIR)
	@rm -f lab1/lab1 lab2/lab2 lab3/Lab3 lab4/lab4 lab5/lab5 lab6/lab6 lab7/lab7
	@rm -f lab8/lab8/main lab9/lab9/main
	@rm -f "Lab10/Lab10/main" "Lab11/Lab11/main" "Lab12/Lab12/main"
	@rm -f "Lab 13/Lab 13/main" "Lab 14/Lab 14/main" "Lab 15/Lab 15/main"
	@rm -rf *.dSYM lab*/*.dSYM Lab*/*.dSYM "Lab "*/*.dSYM
	@echo "$(GREEN)Clean complete.$(NC)"
