# Academic Portfolio Makefile
# Builds and runs homework assignments across all courses

# Compiler settings
CXX = g++
CXXFLAGS = -std=c++17 -Wall -Wextra -g
PYTHON = python3
MATLAB = matlab

# CS1570 Homework paths (relative from current working directory)
CS1570_BASE = ../cs1570-intro-to-programming
HW1_DIR = $(CS1570_BASE)/Homework1
HW2_DIR = $(CS1570_BASE)/Homework2
HW3_DIR = $(CS1570_BASE)/Homework3
HW4_DIR = $(CS1570_BASE)/Homework4
HW5_DIR = $(CS1570_BASE)/Homework5
HW6_DIR = $(CS1570_BASE)/Homework6
HW7_DIR = $(CS1570_BASE)/Homework7
HW8_DIR = $(CS1570_BASE)/Homework8

# Default target
.PHONY: all clean help
all: homework1 homework2 homework3 homework4 homework5 homework6 homework7 homework8

help:
	@echo "Available targets:"
	@echo "  all         - Build and run all homework assignments"
	@echo "  homework1   - Run homework 1 (algorithm descriptions)"
	@echo "  homework2   - Build and run homework 2 (GGPA Program)"
	@echo "  homework3   - Build and run homework 3 (SherlockHolmes)"
	@echo "  homework4   - Build and run homework 4 (WavelengthCalculator5000)"
	@echo "  homework5   - Build and run homework 5 (TODist)"
	@echo "  homework6   - Build and run homework 6 (WavelengthCalculator5001)"
	@echo "  homework7   - Build and run homework 7"
	@echo "  homework8   - Build and run homework 8"
	@echo "  clean       - Clean all build artifacts"

# Homework 1 - Algorithm descriptions (text only)
homework1:
	@echo "=== Running Homework 1 ==="
	@echo "This homework contains algorithm descriptions:"
	@if [ -f "$(HW1_DIR)/Homework1.txt" ]; then \
		head -10 "$(HW1_DIR)/Homework1.txt"; \
		echo "... (showing first 10 lines)"; \
	else \
		echo "Homework1.txt not found"; \
	fi
	@echo

# Homework 2 - GGPA Program
homework2: $(HW2_DIR)/Homework2
	@echo "=== Running Homework 2 ==="
	@echo "Providing test input: height=10, width=5, length=8, angle=0.5"
	cd $(HW2_DIR) && echo -e "10\n5\n8\n0.5" | ./Homework2
	@echo

$(HW2_DIR)/Homework2: $(HW2_DIR)/Homework2.cpp
	cd $(HW2_DIR) && $(CXX) $(CXXFLAGS) Homework2.cpp -o Homework2

# Homework 3 - SherlockHolmes
homework3: $(HW3_DIR)/SherlockHolmes
	@echo "=== Running Homework 3 ==="
	cd $(HW3_DIR) && ./SherlockHolmes
	@echo

$(HW3_DIR)/SherlockHolmes: $(HW3_DIR)/SherlockHolmes.cpp
	cd $(HW3_DIR) && $(CXX) $(CXXFLAGS) SherlockHolmes.cpp -o SherlockHolmes

# Homework 4 - WavelengthCalculator5000
homework4: $(HW4_DIR)/WavelengthCalculator5000
	@echo "=== Running Homework 4 ==="
	cd $(HW4_DIR) && ./WavelengthCalculator5000
	@echo

$(HW4_DIR)/WavelengthCalculator5000: $(HW4_DIR)/WavelengthCalculator5000.cpp
	cd $(HW4_DIR) && $(CXX) $(CXXFLAGS) WavelengthCalculator5000.cpp -o WavelengthCalculator5000

# Homework 5 - TODist
homework5: $(HW5_DIR)/TODist
	@echo "=== Running Homework 5 ==="
	cd $(HW5_DIR) && ./TODist
	@echo

$(HW5_DIR)/TODist: $(HW5_DIR)/TODist.cpp
	cd $(HW5_DIR) && $(CXX) $(CXXFLAGS) TODist.cpp -o TODist

# Homework 6 - WavelengthCalculator5001 (multi-file)
homework6: $(HW6_DIR)/WavelengthCalculator5001
	@echo "=== Running Homework 6 ==="
	cd $(HW6_DIR) && ./WavelengthCalculator5001
	@echo

$(HW6_DIR)/WavelengthCalculator5001: $(HW6_DIR)/WavelengthCalculator5001.cpp $(HW6_DIR)/WavelengthCalculator5001_Functions.cpp $(HW6_DIR)/WavelengthCalculator5001.h
	cd $(HW6_DIR) && $(CXX) $(CXXFLAGS) WavelengthCalculator5001.cpp WavelengthCalculator5001_Functions.cpp -o WavelengthCalculator5001

# Homework 7 - Xcode project (compile with g++)
homework7: $(HW7_DIR)/hw7
	@echo "=== Running Homework 7 ==="
	cd $(HW7_DIR) && ./hw7
	@echo

$(HW7_DIR)/hw7: $(HW7_DIR)/Homework7/main.cpp
	cd $(HW7_DIR) && $(CXX) $(CXXFLAGS) Homework7/main.cpp -o hw7

# Homework 8 - Xcode project (multi-file)
homework8: $(HW8_DIR)/hw8
	@echo "=== Running Homework 8 ==="
	cd $(HW8_DIR) && ./hw8
	@echo

$(HW8_DIR)/hw8: $(HW8_DIR)/Homework\ 8/main.cpp $(HW8_DIR)/Homework\ 8/Functions.cpp $(HW8_DIR)/Homework\ 8/Functions.h $(HW8_DIR)/Homework\ 8/Constants.h
	cd $(HW8_DIR) && $(CXX) $(CXXFLAGS) "Homework 8/main.cpp" "Homework 8/Functions.cpp" -o hw8

# Clean target
clean:
	@echo "Cleaning build artifacts..."
	-rm -f $(HW2_DIR)/Homework2
	-rm -f $(HW3_DIR)/SherlockHolmes
	-rm -f $(HW4_DIR)/WavelengthCalculator5000
	-rm -f $(HW5_DIR)/TODist
	-rm -f $(HW6_DIR)/WavelengthCalculator5001
	-rm -f $(HW7_DIR)/hw7
	-rm -f $(HW8_DIR)/hw8
	@echo "Clean complete."