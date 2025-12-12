# CS1001 Data Structures Lab - Build System Documentation

## Overview

This build system provides a unified interface for compiling and running all CS1001 Data Structures Lab assignments. The system is designed to preserve the original college coursework while providing a modern, maintainable build infrastructure.

## Quick Start

### Building All Targets
```bash
make build
```

### Building a Specific Target
```bash
make build TARGET=lab06_triangle
```

### Running a Target (Interactive)
```bash
make run TARGET=lab06_triangle
# Prompts for user input interactively
```

### Running a Target (Automated with Input File)
```bash
make autorun TARGET=lab14_functional
# Reads input from ../../input/lab14_functional.txt
```

### Listing All Available Targets
```bash
make list
```

### Running Tests
```bash
make test
# Note: Only lab11 has tests; requires Boost library
```

### Cleaning Build Artifacts
```bash
make clean
```

## Available Targets

### C++ Programs (16 targets)

| Target | Description | Source Location |
|--------|-------------|-----------------|
| `lab02_filter` | Filter program | 2016sp-a-lab02-isgx2/Filter.cpp |
| `lab03_filter` | Filter program (improved) | 2016sp-a-lab03-isgx2/filter.cpp |
| `lab06_triangle` | Triangle printer with factorials | 2016sp-b-lab06-isgx2/ |
| `lab07_triangle` | Triangle printer (enhanced) | 2016sp-b-lab07-isgx2/ |
| `lab08_list` | Linked list implementation | 2016sp-b-lab08-isgx2/list.cpp |
| `lab09_prob1` | Memory management problem 1 | 2016sp-b-lab09-isgx2/prob1.cpp |
| `lab09_prob2` | Memory management problem 2 | 2016sp-b-lab09-isgx2/prob2.cpp |
| `lab09_prob3` | Memory management problem 3 | 2016sp-b-lab09-isgx2/prob3.cpp |
| `lab10_prob1` | Template problem 1 | 2016sp-b-lab10-isgx2/prob1.cpp |
| `lab10_prob2` | Template problem 2 | 2016sp-b-lab10-isgx2/prob2.cpp |
| `lab10_prob3` | Template problem 3 | 2016sp-b-lab10-isgx2/prob3.cpp |
| `lab11_main` | List with unit tests | 2016sp-b-lab11-isgx2/ |
| `lab12_leak_delete` | Memory leak with delete | 2016sp-b-lab12-isgx2/leak_delete.cpp |
| `lab12_leak_shared_ptr` | Smart pointer example | 2016sp-b-lab12-isgx2/leak_shared_ptr.cpp |
| `lab13_phonebook` | Qt phonebook application | 2016sp-b-lab13-isgx2/ |
| `lab14_functional` | Functional C++ with lambdas | 2016sp-b-lab14-functional_cpp-isgx2/main.cpp |

### Shell Scripts (3 targets)

| Target | Description | Script Location |
|--------|-------------|-----------------|
| `lab04_menu` | Interactive menu system | 2016sp-b-lab04-isgx2/Menu.sh |
| `lab04_math` | Math operations script | 2016sp-b-lab04-isgx2/Math.sh |
| `lab_project1_present` | Presentation script | 2016sp-b-project-1-isgx2/present.sh |

## Build Configuration

### Compiler Settings
- **Compiler**: g++
- **C++ Standard**: C++11
- **Flags**: `-Wall -Wextra -std=c++11 -g`
- **Debug Symbols**: Enabled (`-g` flag)

### Special Build Requirements

#### Lab 11 (Unit Testing)
- Uses existing makefile in `2016sp-b-lab11-isgx2/`
- Requires Boost Test library for testing
- Main target builds without Boost
- Test target requires: `#include <boost/test/unit_test.hpp>`

#### Lab 13 (Qt Phonebook)
- Requires Qt4 libraries (QtCore, QtGui)
- Falls back to placeholder if Qt not available
- Original uses qmake-generated Makefile

## Input Files for Automated Testing

Input files should be placed in `../../input/` (repository root `input/` directory):

### Example Input Files

**lab06_triangle.txt**:
```
5
```

**lab14_functional.txt**:
```
Rick
```

**lab02_filter.txt**:
```
hello world
this is a test
filter this line
keep this one
end of test
```

## Build System Architecture

### Directory Structure
```
cs1001-data-structures-lab/
├── makefile                    # Main build system
├── BUILD_SYSTEM.md            # This documentation
├── build/                      # Build output directory
│   ├── lab02_filter           # Compiled binaries
│   ├── lab03_filter
│   └── ...
├── 2016sp-a-lab02-isgx2/      # Lab assignments
├── 2016sp-a-lab03-isgx2/
└── ...
```

### Build Process
1. **Compilation**: All C++ files compiled with consistent flags
2. **Linking**: Automatic dependency resolution
3. **Output**: Binaries placed in `build/` directory
4. **Cleanup**: Removes all build artifacts including debug symbols

### Integration with Top-Level Build System

From `src/` directory:
```bash
make cs1001-build        # Build CS1001 course
make cs1001-run          # List CS1001 run targets
make cs1001-test         # Run CS1001 tests
make cs1001-clean        # Clean CS1001 artifacts
make build-all           # Build all courses
```

## Troubleshooting

### Qt Not Found
If lab13_phonebook shows "Qt libraries not found":
- Install Qt4 development libraries
- Or use placeholder (functionality limited)

### Boost Test Not Found
If lab11 tests fail:
- Install Boost Test library: `brew install boost` (macOS)
- Or skip tests and use main target only

### Shell Scripts Not Executing
- Ensure scripts have execute permissions
- Run from makefile using `make run TARGET=<script_name>`

## Code Modifications

The following minimal changes were made to fix compilation errors:

1. **2016sp-a-lab03-isgx2/filter.cpp**: Fixed missing closing parenthesis (line 32)
2. **2016sp-b-lab11-isgx2/makefile**: Removed header files from linker command
3. **2016sp-b-lab14-functional_cpp-isgx2/main.cpp**: Fixed C++11 lambda parameter types (lines 16, 37, 42)

All other code remains unchanged to preserve the original college work.

## Build Statistics

- **Total Targets**: 19 (16 C++, 3 shell scripts)
- **Total Labs**: 12 unique lab assignments
- **C++ Standard**: C++11
- **Lines of Code**: ~2000+ (estimated across all labs)
- **Build Time**: <5 seconds for full build

## Additional Commands

### List All Targets
```bash
make list
```

### Help
```bash
make help
```

### Clean Specific Target
```bash
make clean_lab06_triangle
```

## Notes

- Some programs have warnings (unused variables, parameters) - these are intentional as part of the original student work
- Shell scripts may have infinite loops or other original behavior - this is preserved
- Lab 13 Qt application requires specific Qt4 libraries not commonly available on modern systems
- All builds tested on macOS with clang++ (g++ alias)
