# CS1570 Introduction to Programming - Build System
# Builds and runs all homework assignments
#
# Available Targets:
#   homework2       - GGPA calculator program
#   homework3       - Sherlock Holmes text analysis
#   homework4       - Wavelength Calculator 5000
#   homework5       - TODist program
#   homework6       - Wavelength Calculator 5001 (multi-file)
#   homework7       - Xcode project (simple main)
#   homework8       - DNA/Dental cow identification
#   final_boss      - Crime scene investigation game
#   final_project   - Pants tailor simulation
#
# Usage:
#   make build                    - Build all targets
#   make build TARGET=homework3   - Build specific target
#   make run TARGET=homework3     - Run specific target (interactive)
#   make autorun TARGET=homework3 - Run with piped input from input/
#   make list                     - List all targets
#   make clean                    - Remove build artifacts
#   make help                     - Show this help

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
ALL_TARGETS = homework2 homework3 homework4 homework5 homework6 homework7 homework8 final_boss final_project

# Default target
.PHONY: all
all: help

# Help target
.PHONY: help
help:
	@echo "$(CYAN)CS1570 Introduction to Programming - Build System$(NC)"
	@echo ""
	@echo "$(YELLOW)Usage:$(NC)"
	@echo "  make build                    - Build all targets"
	@echo "  make build TARGET=<name>      - Build specific target"
	@echo "  make run TARGET=<name>        - Run specific target (interactive)"
	@echo "  make autorun TARGET=<name>    - Run with input from input/"
	@echo "  make list                     - List all targets"
	@echo "  make clean                    - Remove build artifacts"
	@echo ""
	@echo "$(YELLOW)Available Targets:$(NC)"
	@echo "  homework2       - GGPA calculator program"
	@echo "  homework3       - Sherlock Holmes text analysis"
	@echo "  homework4       - Wavelength Calculator 5000"
	@echo "  homework5       - TODist program"
	@echo "  homework6       - Wavelength Calculator 5001 (multi-file)"
	@echo "  homework7       - Xcode project (simple main)"
	@echo "  homework8       - DNA/Dental cow identification"
	@echo "  final_boss      - Crime scene investigation game"
	@echo "  final_project   - Pants tailor simulation"
	@echo ""
	@echo "$(YELLOW)Note:$(NC)"
	@echo "  Homework1 is a text file only (no compilation needed)"

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
	@$(MAKE) --no-print-directory build_homework2
	@$(MAKE) --no-print-directory build_homework3
	@$(MAKE) --no-print-directory build_homework4
	@$(MAKE) --no-print-directory build_homework5
	@$(MAKE) --no-print-directory build_homework6
	@$(MAKE) --no-print-directory build_homework7
	@$(MAKE) --no-print-directory build_homework8
	@$(MAKE) --no-print-directory build_final_boss
	@$(MAKE) --no-print-directory build_final_project
	@echo "$(GREEN)All targets built successfully.$(NC)"
endif

# Individual build targets
.PHONY: build_homework2
build_homework2: $(BUILD_DIR)
	@echo "$(CYAN)Building homework2 (GGPA Program)...$(NC)"
	@$(CXX) $(CXXFLAGS) Homework2/Homework2.cpp -o $(BUILD_DIR)/homework2
	@echo "$(GREEN)homework2 built successfully.$(NC)"

.PHONY: build_homework3
build_homework3: $(BUILD_DIR)
	@echo "$(CYAN)Building homework3 (Sherlock Holmes)...$(NC)"
	@$(CXX) $(CXXFLAGS) Homework3/SherlockHolmes.cpp -o $(BUILD_DIR)/homework3
	@echo "$(GREEN)homework3 built successfully.$(NC)"

.PHONY: build_homework4
build_homework4: $(BUILD_DIR)
	@echo "$(CYAN)Building homework4 (Wavelength Calculator 5000)...$(NC)"
	@$(CXX) $(CXXFLAGS) Homework4/WavelengthCalculator5000.cpp -o $(BUILD_DIR)/homework4
	@echo "$(GREEN)homework4 built successfully.$(NC)"

.PHONY: build_homework5
build_homework5: $(BUILD_DIR)
	@echo "$(CYAN)Building homework5 (TODist)...$(NC)"
	@$(CXX) $(CXXFLAGS) Homework5/TODist.cpp -o $(BUILD_DIR)/homework5
	@echo "$(GREEN)homework5 built successfully.$(NC)"

.PHONY: build_homework6
build_homework6: $(BUILD_DIR)
	@echo "$(CYAN)Building homework6 (Wavelength Calculator 5001)...$(NC)"
	@$(CXX) $(CXXFLAGS) -I Homework6 \
		Homework6/WavelengthCalculator5001.cpp \
		Homework6/WavelengthCalculator5001_Functions.cpp \
		-o $(BUILD_DIR)/homework6
	@echo "$(GREEN)homework6 built successfully.$(NC)"

.PHONY: build_homework7
build_homework7: $(BUILD_DIR)
	@echo "$(CYAN)Building homework7 (Xcode project)...$(NC)"
	@$(CXX) $(CXXFLAGS) Homework7/Homework7/main.cpp -o $(BUILD_DIR)/homework7
	@echo "$(GREEN)homework7 built successfully.$(NC)"

.PHONY: build_homework8
build_homework8: $(BUILD_DIR)
	@echo "$(CYAN)Building homework8 (DNA/Dental)...$(NC)"
	@$(CXX) $(CXXFLAGS) -I "Homework8/Homework 8" \
		"Homework8/Homework 8/main.cpp" \
		"Homework8/Homework 8/Functions.cpp" \
		-o $(BUILD_DIR)/homework8
	@echo "$(GREEN)homework8 built successfully.$(NC)"

.PHONY: build_final_boss
build_final_boss: $(BUILD_DIR)
	@echo "$(CYAN)Building final_boss (Crime Investigation)...$(NC)"
	@$(CXX) $(CXXFLAGS) -I "Final Boss/Final Boss" \
		"Final Boss/Final Boss/Agent.cpp" \
		"Final Boss/Final Boss/CrimeRoom.cpp" \
		"Final Boss/Final Boss/Functions.cpp" \
		"Final Boss/Final Boss/Judicial.cpp" \
		"Final Boss/Final Boss/Resident.cpp" \
		"Final Boss/Final Boss/main.cpp" \
		-o $(BUILD_DIR)/final_boss
	@echo "$(GREEN)final_boss built successfully.$(NC)"

.PHONY: build_final_project
build_final_project: $(BUILD_DIR)
	@echo "$(CYAN)Building final_project (Pants Tailor)...$(NC)"
	@$(CXX) $(CXXFLAGS) -I cs1570-final-project \
		cs1570-final-project/main.cpp \
		cs1570-final-project/bully.cpp \
		cs1570-final-project/functions.cpp \
		cs1570-final-project/location.cpp \
		cs1570-final-project/pants.cpp \
		cs1570-final-project/tailor.cpp \
		cs1570-final-project/town.cpp \
		-o $(BUILD_DIR)/final_project
	@echo "$(GREEN)final_project built successfully.$(NC)"

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
	@if [ "$(TARGET)" = "final_boss" ]; then \
		echo "$(CYAN)Running final_boss (from data directory)...$(NC)"; \
		cd "Final Boss/Final Boss" && ../../$(BUILD_DIR)/final_boss; \
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
	@ls -1 $(INPUT_DIR)/cs1570-*.txt 2>/dev/null | xargs -I{} basename {} | sed 's/cs1570-/  /;s/.txt//' || echo "  (no input files found)"
else
	@if [ "$(TARGET)" = "final_boss" ]; then \
		echo "$(CYAN)Running final_boss with input (from data directory)...$(NC)"; \
		if [ -f "$(INPUT_DIR)/cs1570-final_boss.txt" ]; then \
			cd "Final Boss/Final Boss" && cat ../../../input/cs1570-final_boss.txt | ../../$(BUILD_DIR)/final_boss; \
		else \
			echo "$(YELLOW)No input file found at $(INPUT_DIR)/cs1570-final_boss.txt$(NC)"; \
			echo "$(YELLOW)Running interactively...$(NC)"; \
			cd "Final Boss/Final Boss" && ../../$(BUILD_DIR)/final_boss; \
		fi; \
	else \
		echo "$(CYAN)Running $(TARGET) with input...$(NC)"; \
		if [ -f "$(INPUT_DIR)/cs1570-$(TARGET).txt" ]; then \
			cat $(INPUT_DIR)/cs1570-$(TARGET).txt | ./$(BUILD_DIR)/$(TARGET); \
		else \
			echo "$(YELLOW)No input file found at $(INPUT_DIR)/cs1570-$(TARGET).txt$(NC)"; \
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
	@rm -f Homework2/Homework2 Homework2/53drv "Homework2/Homework2 2"
	@rm -f Homework3/SherlockHolmes
	@rm -f Homework4/WavelengthCalculator5000
	@rm -f Homework5/TODist
	@rm -f Homework6/WavelengthCalculator5001
	@rm -f Homework7/hw7_executable
	@rm -f Homework8/Homework8 "Homework8/First Test - Brute Force"
	@rm -f "Final Boss/FinalBoss" "Final Boss/Final Boss/a.out"
	@rm -f cs1570-final-project/driver
	@echo "$(GREEN)Clean complete.$(NC)"
