# CS1580 Intro to Programming Lab Makefile
# Compiles and runs all lab assignments in order with non-interactive input

CXX = g++
CXXFLAGS = -std=c++11 -Wall -g

.PHONY: all clean lab1 lab2 lab3 lab4 lab5 lab6 lab7 lab8 lab9 lab10 lab11 lab12 lab13 lab14 lab15

# Build and run all labs in order
all:
	@$(MAKE) lab1
	@echo ""
	@$(MAKE) lab2
	@echo ""
	@$(MAKE) lab3
	@echo ""
	@$(MAKE) lab4
	@echo ""
	@$(MAKE) lab5
	@echo ""
	@$(MAKE) lab6
	@echo ""
	@$(MAKE) lab7
	@echo ""
	@$(MAKE) lab8
	@echo ""
	@$(MAKE) lab9
	@echo ""
	@$(MAKE) lab10
	@echo ""
	@$(MAKE) lab11
	@echo ""
	@$(MAKE) lab12
	@echo ""
	@$(MAKE) lab13
	@echo ""
	@$(MAKE) lab14
	@echo ""
	@$(MAKE) lab15

# Lab 1 - Simple Hello World (no input needed)
lab1:
	@echo "=== Building and Running Lab 1 ==="
	$(CXX) $(CXXFLAGS) lab1/lab1.cpp -o lab1/lab1
	cd lab1 && ./lab1
	@echo "========================="
	@echo "========================="

# Lab 2 - Multiplication (needs name and two numbers)
lab2:
	@echo "=== Building and Running Lab 2 ==="
	$(CXX) $(CXXFLAGS) lab2/lab2.cpp -o lab2/lab2
	cd lab2 && echo -e "Test User\n5\n3" > temp_input.txt && ./lab2 < temp_input.txt && rm temp_input.txt
	@echo "========================="
	@echo "========================="

# Lab 3 - BMI Calculator (needs mass and height)
lab3:
	@echo "=== Building and Running Lab 3 ==="
	$(CXX) $(CXXFLAGS) lab3/Lab3.cpp -o lab3/Lab3
	cd lab3 && echo -e "150\n70" > temp_input.txt && ./Lab3 < temp_input.txt && rm temp_input.txt
	@echo "========================="
	@echo "========================="

# Lab 4 - Calculator Averager (needs y/n responses and numbers)
lab4:
	@echo "=== Building and Running Lab 4 ==="
	$(CXX) $(CXXFLAGS) lab4/lab4.cpp -o lab4/lab4
	cd lab4 && echo -e "y\n15\ny\n10\ny\n9\nn" > temp_input.txt && ./lab4 < temp_input.txt && rm temp_input.txt
	@echo "========================="
	@echo "========================="

# Lab 5 - E-Voting System (needs 10 voting choices)
lab5:
	@echo "=== Building and Running Lab 5 ==="
	$(CXX) $(CXXFLAGS) lab5/lab5.cpp -o lab5/lab5
	cd lab5 && echo -e "A\nB\nC\nD\nA\nB\nC\nD\nA\nB" > temp_input.txt && ./lab5 < temp_input.txt && rm temp_input.txt
	@echo "========================="
	@echo "========================="

# Lab 6 - Harmonic and Arithmetic Mean (needs 3 positive numbers)
lab6:
	@echo "=== Building and Running Lab 6 ==="
	$(CXX) $(CXXFLAGS) lab6/lab6.cpp -o lab6/lab6
	cd lab6 && echo -e "5.0\n10.0\n15.0" > temp_input.txt && ./lab6 < temp_input.txt && rm temp_input.txt
	@echo "========================="
	@echo "========================="

# Lab 7 - Random Number Generator (needs lower and upper limits)
lab7:
	@echo "=== Building and Running Lab 7 ==="
	$(CXX) $(CXXFLAGS) lab7/lab7.cpp -o lab7/lab7
	cd lab7 && echo -e "5\n20" > temp_input.txt && ./lab7 < temp_input.txt && rm temp_input.txt
	@echo "========================="
	@echo "========================="

# Lab 8 - Xcode project
lab8:
	@echo "=== Building and Running Lab 8 ==="
	$(CXX) $(CXXFLAGS) lab8/lab8/main.cpp -o lab8/lab8/main
	cd lab8/lab8 && ./main
	@echo "========================="
	@echo "========================="

# Lab 9 - Xcode project with multiple files
lab9:
	@echo "=== Building and Running Lab 9 ==="
	$(CXX) $(CXXFLAGS) lab9/lab9/main.cpp lab9/lab9/lab9.cpp -o lab9/lab9/main
	cd lab9/lab9 && ./main
	@echo "========================="
	@echo "========================="

# Lab 10 - Xcode project (requires input)
lab10:
	@echo "=== Building and Running Lab 10 ==="
	$(CXX) $(CXXFLAGS) "Lab10/Lab10/main.cpp" -o "Lab10/Lab10/main"
	cd "Lab10/Lab10" && echo -e "Test\nUser\npassword1\npassword1" > temp_input.txt && ./main < temp_input.txt && rm temp_input.txt
	@echo "========================="
	@echo "========================="

# Lab 11 - Xcode project with I/O files (uses input.txt)
lab11:
	@echo "=== Building and Running Lab 11 ==="
	$(CXX) $(CXXFLAGS) "Lab11/Lab11/main.cpp" -o "Lab11/Lab11/main"
	cd "Lab11/Lab11" && ./main
	@echo "========================="
	@echo "========================="

# Lab 12 - Xcode project with multiple files (requires input)
lab12:
	@echo "=== Building and Running Lab 12 ==="
	$(CXX) $(CXXFLAGS) "Lab12/Lab12/main.cpp" "Lab12/Lab12/Time.cpp" -o "Lab12/Lab12/main"
	cd "Lab12/Lab12" && echo -e "12\n34\n56\nN" > temp_input.txt && ./main < temp_input.txt && rm temp_input.txt
	@echo "========================="
	@echo "========================="

# Lab 13 - Xcode project (Rectangle class)
lab13:
	@echo "=== Building and Running Lab 13 ==="
	$(CXX) $(CXXFLAGS) "Lab 13/Lab 13/main.cpp" -o "Lab 13/Lab 13/main"
	cd "Lab 13/Lab 13" && ./main
	@echo "========================="
	@echo "========================="

# Lab 14 - Xcode project with template Array class
lab14:
	@echo "=== Building and Running Lab 14 ==="
	$(CXX) $(CXXFLAGS) "Lab 14/Lab 14/main.cpp" -o "Lab 14/Lab 14/main"
	cd "Lab 14/Lab 14" && ./main
	@echo "========================="
	@echo "========================="

# Lab 15 - Xcode project
lab15:
	@echo "=== Building and Running Lab 15 ==="
	$(CXX) $(CXXFLAGS) "Lab 15/Lab 15/main.cpp" -o "Lab 15/Lab 15/main"
	cd "Lab 15/Lab 15" && ./main
	@echo "========================="
	@echo "========================="

# Clean all built executables and temporary files
clean:
	@echo "=== Cleaning build artifacts ==="
	-rm -f lab1/lab1 lab2/lab2 lab3/Lab3 lab4/lab4 lab5/lab5 lab6/lab6 lab7/lab7
	-rm -f lab8/lab8/main lab9/lab9/main
	-rm -f "Lab10/Lab10/main" "Lab11/Lab11/main" "Lab12/Lab12/main"
	-rm -f "Lab 13/Lab 13/main" "Lab 14/Lab 14/main" "Lab 15/Lab 15/main"
	-rm -f lab1/a.out lab2/a.out lab3/a.out lab4/a.out lab5/a.out lab6/a.out lab7/a.out
	-rm -f *.dSYM
	-rm -rf lab1/lab1.dSYM lab2/lab2.dSYM lab3/Lab3.dSYM lab4/lab4.dSYM lab5/lab5.dSYM lab6/lab6.dSYM
	@echo "Clean complete"