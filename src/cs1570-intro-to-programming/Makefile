# CS1570 Introduction to Programming - Master Makefile
# Builds and runs all homework assignments in order

CXX = g++
CXXFLAGS = -Wall -g -std=c++11

# Help target - shows available commands
.PHONY: help
help:
	@echo "CS1570 Introduction to Programming - Build System"
	@echo ""
	@echo "Available targets:"
	@echo "  help              - Show this help message"
	@echo "  build-all         - Build all working homework assignments (default)"
	@echo "  build-working     - Same as build-all"
	@echo "  build-all-force   - Attempt to build everything including problematic assignments"
	@echo "  clean             - Clean all build artifacts"
	@echo ""
	@echo "Individual homework targets:"
	@echo "  homework1         - Show Homework 1 text file"
	@echo "  build-homework2   - Build Homework 2 (GGPA Program)"
	@echo "  build-homework3   - Build Homework 3 (Sherlock Holmes)"
	@echo "  build-homework4   - Build Homework 4 (WavelengthCalculator5000)"
	@echo "  build-homework5   - Build Homework 5 (TODist)"
	@echo "  build-homework6   - Build Homework 6 (WavelengthCalculator5001)"
	@echo "  build-homework7   - Build Homework 7 (Xcode project)"
	@echo "  build-homework8   - Build Homework 8 (has source errors)"
	@echo "  build-final-boss  - Build Final Boss (has source errors)" 
	@echo "  build-final-project - Build Final Project"
	@echo ""
	@echo "Running homework (interactive programs need input):"
	@echo "  run-all           - Build and run all homework in order"
	@echo "  homework2         - Build and run Homework 2"
	@echo "  homework3         - Build and run Homework 3"
	@echo "  (etc...)"
	@echo ""

# Default target - builds all homework
.PHONY: all
all: build-all

# Run all homework (interactive programs will need manual input)
.PHONY: run-all
run-all: homework1 homework2 homework3 homework4 homework5 homework6 homework7 homework8 final-boss final-project

# Homework 1 - Text file only, no compilation needed
.PHONY: homework1
homework1:
	@echo "=== Homework 1 ==="
	@echo "Homework 1 is a text file with algorithm descriptions"
	@cat Homework1/Homework1.txt
	@echo ""

# Homework 2 - GGPA Program
.PHONY: homework2
homework2: clean-homework2
	@echo "=== Building Homework 2 ==="
	$(CXX) $(CXXFLAGS) Homework2/Homework2.cpp -o Homework2/Homework2
	@echo "=== Running Homework 2 ==="
	cd Homework2 && ./Homework2
	@echo ""

# Homework 3 - Sherlock Holmes
.PHONY: homework3
homework3: clean-homework3
	@echo "=== Building Homework 3 ==="
	$(CXX) $(CXXFLAGS) Homework3/SherlockHolmes.cpp -o Homework3/SherlockHolmes
	@echo "=== Running Homework 3 ==="
	cd Homework3 && ./SherlockHolmes
	@echo ""

# Homework 4 - WavelengthCalculator5000
.PHONY: homework4
homework4: clean-homework4
	@echo "=== Building Homework 4 ==="
	$(CXX) $(CXXFLAGS) Homework4/WavelengthCalculator5000.cpp -o Homework4/WavelengthCalculator5000
	@echo "=== Running Homework 4 ==="
	cd Homework4 && ./WavelengthCalculator5000
	@echo ""

# Homework 5 - TODist
.PHONY: homework5
homework5: clean-homework5
	@echo "=== Building Homework 5 ==="
	$(CXX) $(CXXFLAGS) Homework5/TODist.cpp -o Homework5/TODist
	@echo "=== Running Homework 5 ==="
	cd Homework5 && ./TODist
	@echo ""

# Homework 6 - WavelengthCalculator5001
.PHONY: homework6
homework6: clean-homework6
	@echo "=== Building Homework 6 ==="
	$(CXX) $(CXXFLAGS) Homework6/WavelengthCalculator5001.cpp Homework6/WavelengthCalculator5001_Functions.cpp -o Homework6/WavelengthCalculator5001
	@echo "=== Running Homework 6 ==="
	cd Homework6 && ./WavelengthCalculator5001
	@echo ""

# Homework 7 - Xcode project
.PHONY: homework7
homework7: clean-homework7
	@echo "=== Building Homework 7 ==="
	$(CXX) $(CXXFLAGS) Homework7/Homework7/main.cpp -o Homework7/hw7_executable
	@echo "=== Running Homework 7 ==="
	cd Homework7 && ./hw7_executable
	@echo ""

# Homework 8 - Xcode project with multiple files
.PHONY: homework8
homework8: clean-homework8
	@echo "=== Building Homework 8 ==="
	$(CXX) $(CXXFLAGS) "Homework8/Homework 8/main.cpp" "Homework8/Homework 8/Functions.cpp" -o Homework8/Homework8
	@echo "=== Running Homework 8 ==="
	cd Homework8 && ./Homework8
	@echo ""

# Final Boss - Crime scene investigation game
.PHONY: final-boss
final-boss: clean-final-boss
	@echo "=== Building Final Boss ==="
	$(CXX) $(CXXFLAGS) "Final Boss/Final Boss/Agent.cpp" "Final Boss/Final Boss/CrimeRoom.cpp" "Final Boss/Final Boss/Functions.cpp" "Final Boss/Final Boss/Judicial.cpp" "Final Boss/Final Boss/Resident.cpp" "Final Boss/Final Boss/main.cpp" -o "Final Boss/FinalBoss"
	@echo "=== Running Final Boss ==="
	cd "Final Boss" && ./FinalBoss
	@echo ""

# Final Project - Uses its own makefile
.PHONY: final-project
final-project: clean-final-project
	@echo "=== Building Final Project ==="
	$(MAKE) -C cs1570-final-project
	@echo "=== Running Final Project ==="
	cd cs1570-final-project && ./driver
	@echo ""

# Clean targets for each homework
.PHONY: clean-homework2
clean-homework2:
	rm -f Homework2/Homework2 Homework2/53drv

.PHONY: clean-homework3
clean-homework3:
	rm -f Homework3/SherlockHolmes

.PHONY: clean-homework4
clean-homework4:
	rm -f Homework4/WavelengthCalculator5000

.PHONY: clean-homework5
clean-homework5:
	rm -f Homework5/TODist

.PHONY: clean-homework6
clean-homework6:
	rm -f Homework6/WavelengthCalculator5001

.PHONY: clean-homework7
clean-homework7:
	rm -f Homework7/hw7_executable

.PHONY: clean-homework8
clean-homework8:
	rm -f Homework8/Homework8 "Homework8/First Test - Brute Force"
	rm -rf "Homework8/Homework 8/build"

.PHONY: clean-final-boss
clean-final-boss:
	rm -f "Final Boss/FinalBoss" "Final Boss/Final Boss/a.out"
	find "Final Boss" -name ".DS_Store" -delete 2>/dev/null || true

.PHONY: clean-final-project
clean-final-project:
	rm -f cs1570-final-project/driver

# Clean everything
.PHONY: clean
clean: clean-homework2 clean-homework3 clean-homework4 clean-homework5 clean-homework6 clean-homework7 clean-homework8 clean-final-boss clean-final-project
	@echo "All homework assignments cleaned"

# Build all homework assignments that compile successfully
.PHONY: build-all
build-all: build-homework2 build-homework3 build-homework4 build-homework5 build-homework6 build-homework7 build-final-project
	@echo ""
	@echo "Build Summary:"
	@echo "  ✓ Homework 2 - GGPA Program (compiles successfully)"
	@echo "  ✓ Homework 3 - Sherlock Holmes (compiles with warnings)"  
	@echo "  ✓ Homework 4 - WavelengthCalculator5000 (compiles successfully)"
	@echo "  ✓ Homework 5 - TODist (compiles successfully)"
	@echo "  ✓ Homework 6 - WavelengthCalculator5001 (compiles with warnings)"
	@echo "  ✓ Homework 7 - Xcode project (compiles successfully)"
	@echo "  ✓ Final Project - Uses makefile (compiles successfully)"
	@echo ""
	@echo "Skipped due to source code issues:"
	@echo "  ✗ Homework 8 - Missing array initializer in Constants.h:85"
	@echo "  ✗ Final Boss - Function name conflict with std::round"
	@echo ""

# Build working assignments only (excludes problematic ones)
.PHONY: build-working
build-working: build-homework2 build-homework3 build-homework4 build-homework5 build-homework6 build-homework7 build-final-project
	@echo "All working homework assignments built successfully!"

# Attempt to build everything (including problematic ones)
.PHONY: build-all-force
build-all-force: build-homework2 build-homework3 build-homework4 build-homework5 build-homework6 build-homework7 build-final-project
	@echo "Attempting to build problematic assignments..."
	@-$(MAKE) build-homework8 2>/dev/null || echo "  ✗ Homework 8 failed (source code issue)"
	@-$(MAKE) build-final-boss 2>/dev/null || echo "  ✗ Final Boss failed (source code issue)"

# Individual build targets (no running)
.PHONY: build-homework2
build-homework2: clean-homework2
	@echo "=== Building Homework 2 ==="
	$(CXX) $(CXXFLAGS) Homework2/Homework2.cpp -o Homework2/Homework2

.PHONY: build-homework3
build-homework3: clean-homework3
	@echo "=== Building Homework 3 ==="
	$(CXX) $(CXXFLAGS) Homework3/SherlockHolmes.cpp -o Homework3/SherlockHolmes

.PHONY: build-homework4
build-homework4: clean-homework4
	@echo "=== Building Homework 4 ==="
	$(CXX) $(CXXFLAGS) Homework4/WavelengthCalculator5000.cpp -o Homework4/WavelengthCalculator5000

.PHONY: build-homework5
build-homework5: clean-homework5
	@echo "=== Building Homework 5 ==="
	$(CXX) $(CXXFLAGS) Homework5/TODist.cpp -o Homework5/TODist

.PHONY: build-homework6
build-homework6: clean-homework6
	@echo "=== Building Homework 6 ==="
	$(CXX) $(CXXFLAGS) Homework6/WavelengthCalculator5001.cpp Homework6/WavelengthCalculator5001_Functions.cpp -o Homework6/WavelengthCalculator5001

.PHONY: build-homework7
build-homework7: clean-homework7
	@echo "=== Building Homework 7 ==="
	$(CXX) $(CXXFLAGS) Homework7/Homework7/main.cpp -o Homework7/hw7_executable

.PHONY: build-homework8
build-homework8: clean-homework8
	@echo "=== Building Homework 8 ==="
	$(CXX) $(CXXFLAGS) "Homework8/Homework 8/main.cpp" "Homework8/Homework 8/Functions.cpp" -o Homework8/Homework8

.PHONY: build-final-boss
build-final-boss: clean-final-boss
	@echo "=== Building Final Boss ==="
	$(CXX) $(CXXFLAGS) "Final Boss/Final Boss/Agent.cpp" "Final Boss/Final Boss/CrimeRoom.cpp" "Final Boss/Final Boss/Functions.cpp" "Final Boss/Final Boss/Judicial.cpp" "Final Boss/Final Boss/Resident.cpp" "Final Boss/Final Boss/main.cpp" -o "Final Boss/FinalBoss"

.PHONY: build-final-project
build-final-project: clean-final-project
	@echo "=== Building Final Project ==="
	$(MAKE) -C cs1570-final-project main