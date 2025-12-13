################################################################################
# Makefile for CS1510 Data Structures
#
# This makefile builds all homework assignments for CS1510. Directory names
# contain spaces and special characters, requiring special handling.
#
# Targets:
#   build              - Build all targets (or specific TARGET=<name>)
#   run                - Run a target interactively (requires TARGET=<name>)
#   autorun            - Run a target with piped input (requires TARGET=<name>)
#   list               - List all available targets
#   clean              - Remove all build artifacts
#   help               - Display this help message
#
# Usage Examples:
#   make build                    # Build all targets
#   make build TARGET=homework2   # Build only homework2
#   make run TARGET=homework3     # Run homework3 interactively
#   make autorun TARGET=homework4 # Run homework4 with input file
#   make list                     # Show all targets
#   make clean                    # Clean build directory
#
# Notes:
#   - homework1 requires libdc1394 (firewire camera library) and is skipped
#   - homework2 uses smalltester.cpp (largetester.cpp is commented out)
#   - homework7 and homework8 are stub projects (Hello World only)
################################################################################

# Compiler settings
CXX = g++
CXXFLAGS = -Wall -Wextra -std=c++11 -g

# Directory settings
BUILD_DIR = build
INPUT_DIR = ../../input

# Create build directory if it doesn't exist
$(shell mkdir -p $(BUILD_DIR))

# Define source directories (with spaces and special characters)
HW1_DIR = Homework \#1/Homework \#1
HW2_DIR = Homework \#2/Homework \#2
HW3_DIR = Homework \#3/Homework \#3
HW4_DIR = Homework \#4/Homework \#4
HW5_DIR = Homework \#5/Homework \#5
HW6_DIR = Homework \#6/Homework \#6
HW7_DIR = Homework \#7/Homework \#7
HW8_DIR = Homework \#8/Homework \#8

# Available targets (homework1 excluded - requires external libdc1394 library)
CPP_TARGETS = homework2 homework3 homework4 homework5 homework6 homework7 homework8

# Color definitions for terminal output
GREEN  = \033[0;32m
CYAN   = \033[0;36m
YELLOW = \033[0;33m
RED    = \033[0;31m
NC     = \033[0m

################################################################################
# Primary Targets
################################################################################

.PHONY: all help list build clean run autorun

## help: Display available targets and usage information
help:
	@echo "$(CYAN)CS1510 Data Structures - Build System$(NC)"
	@echo ""
	@echo "$(GREEN)Available targets:$(NC)"
	@echo "  build              Build all targets (or TARGET=<name> for specific)"
	@echo "  run                Run a target interactively (requires TARGET=<name>)"
	@echo "  autorun            Run a target with piped input (requires TARGET=<name>)"
	@echo "  list               List all available targets"
	@echo "  clean              Remove all build artifacts"
	@echo "  help               Display this help message"
	@echo ""
	@echo "$(GREEN)Examples:$(NC)"
	@echo "  make build"
	@echo "  make build TARGET=homework3"
	@echo "  make run TARGET=homework4"
	@echo "  make autorun TARGET=homework5"
	@echo ""
	@echo "$(YELLOW)Notes:$(NC)"
	@echo "  - homework1 requires libdc1394 (firewire camera library) - skipped"
	@echo "  - homework7/homework8 are stub projects (Hello World only)"

## list: Display all available build targets
list:
	@echo "$(CYAN)Available targets:$(NC)"
	@for target in $(CPP_TARGETS); do \
		echo "  $$target"; \
	done

## build: Build all targets or a specific target if TARGET is specified
build:
ifdef TARGET
	@$(MAKE) build_$(TARGET)
else
	@$(MAKE) build_all
endif

## clean: Remove all build artifacts
clean:
	@echo "$(CYAN)Cleaning build directory...$(NC)"
	@rm -rf $(BUILD_DIR)
	@echo "$(GREEN)Clean complete.$(NC)"

## run: Run a specific target interactively
run:
ifndef TARGET
	@echo "$(YELLOW)Usage: make run TARGET=<target_name>$(NC)"
	@echo ""
	@$(MAKE) list
else
	@if [ -f "$(BUILD_DIR)/$(TARGET)" ]; then \
		echo "$(CYAN)Running $(TARGET)...$(NC)"; \
		./$(BUILD_DIR)/$(TARGET); \
	else \
		echo "$(RED)Error: $(TARGET) not found. Run 'make build TARGET=$(TARGET)' first.$(NC)"; \
	fi
endif

## autorun: Run a specific target with input from file
autorun:
ifndef TARGET
	@echo "$(YELLOW)Usage: make autorun TARGET=<target_name>$(NC)"
	@echo ""
	@$(MAKE) list
else
	@if [ -f "$(BUILD_DIR)/$(TARGET)" ]; then \
		if [ -f "$(INPUT_DIR)/cs1510-$(TARGET).txt" ]; then \
			echo "$(CYAN)Running $(TARGET) with input from $(INPUT_DIR)/cs1510-$(TARGET).txt...$(NC)"; \
			./$(BUILD_DIR)/$(TARGET) < "$(INPUT_DIR)/cs1510-$(TARGET).txt"; \
		else \
			echo "$(YELLOW)Warning: Input file $(INPUT_DIR)/cs1510-$(TARGET).txt not found.$(NC)"; \
			echo "$(CYAN)Running $(TARGET) without input...$(NC)"; \
			./$(BUILD_DIR)/$(TARGET); \
		fi \
	else \
		echo "$(RED)Error: $(TARGET) not found. Run 'make build TARGET=$(TARGET)' first.$(NC)"; \
	fi
endif

################################################################################
# Build All Target
################################################################################

.PHONY: build_all
build_all: $(addprefix build_,$(CPP_TARGETS))
	@echo "$(GREEN)All targets built successfully.$(NC)"

################################################################################
# Individual Build Targets
################################################################################

# Note: homework1 (tube.cpp) requires libdc1394 library for firewire camera
# capture. It is excluded from the default build. To build it manually:
#   g++ -Wall -Wextra -std=c++11 "Homework #1/Homework #1/tube.cpp" -ldc1394 -o build/homework1

.PHONY: build_homework2
build_homework2:
	@echo "$(CYAN)Building homework2 (smalltester)...$(NC)"
	@$(CXX) $(CXXFLAGS) -I"Homework #2/Homework #2" \
		"Homework #2/Homework #2/smalltester.cpp" \
		-o $(BUILD_DIR)/homework2
	@echo "$(GREEN)homework2 built successfully.$(NC)"

.PHONY: build_homework3
build_homework3:
	@echo "$(CYAN)Building homework3 (linkedlist tester)...$(NC)"
	@$(CXX) $(CXXFLAGS) -I"Homework #3/Homework #3" \
		"Homework #3/Homework #3/tester.cpp" \
		-o $(BUILD_DIR)/homework3
	@echo "$(GREEN)homework3 built successfully.$(NC)"

.PHONY: build_homework4
build_homework4:
	@echo "$(CYAN)Building homework4 (packages)...$(NC)"
	@$(CXX) $(CXXFLAGS) -I"Homework #4/Homework #4" \
		"Homework #4/Homework #4/main.cpp" \
		"Homework #4/Homework #4/packages.cpp" \
		-o $(BUILD_DIR)/homework4
	@echo "$(GREEN)homework4 built successfully.$(NC)"

.PHONY: build_homework5
build_homework5:
	@echo "$(CYAN)Building homework5 (braincalc)...$(NC)"
	@$(CXX) $(CXXFLAGS) -I"Homework #5/Homework #5" \
		"Homework #5/Homework #5/braincalc.cpp" \
		"Homework #5/Homework #5/TheBrain.cpp" \
		-o $(BUILD_DIR)/homework5
	@echo "$(GREEN)homework5 built successfully.$(NC)"

.PHONY: build_homework6
build_homework6:
	@echo "$(CYAN)Building homework6 (tickets queue)...$(NC)"
	@$(CXX) $(CXXFLAGS) -I"Homework #6/Homework #6" \
		"Homework #6/Homework #6/Tickets.cpp" \
		"Homework #6/Homework #6/ArrayQueue.cpp" \
		"Homework #6/Homework #6/Customer.cpp" \
		-o $(BUILD_DIR)/homework6
	@echo "$(GREEN)homework6 built successfully.$(NC)"

.PHONY: build_homework7
build_homework7:
	@echo "$(CYAN)Building homework7 (stub)...$(NC)"
	@$(CXX) $(CXXFLAGS) -I"Homework #7/Homework #7" \
		"Homework #7/Homework #7/main.cpp" \
		-o $(BUILD_DIR)/homework7
	@echo "$(GREEN)homework7 built successfully.$(NC)"

.PHONY: build_homework8
build_homework8:
	@echo "$(CYAN)Building homework8 (stub)...$(NC)"
	@$(CXX) $(CXXFLAGS) -I"Homework #8/Homework #8" \
		"Homework #8/Homework #8/main.cpp" \
		-o $(BUILD_DIR)/homework8
	@echo "$(GREEN)homework8 built successfully.$(NC)"
