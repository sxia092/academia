# CPE3150 - Micro/Embedded Design

## Course Overview
This repository contains coursework for Computer Engineering 3150: *Introduction to Microcontrollers and Embedded Systems* at Missouri University of Science and Technology. The course focuses on 8051 microcontroller programming using both assembly language and embedded C.

## Build System
The repository includes a comprehensive Makefile that provides a unified build interface for all assignments and projects.

### Available Make Targets

#### Build Commands

##### `make build`
- **Input**: None
- **Output**: Builds all compilable C targets (homework-6-3 and space-invaders)
- **Description**: Compiles all standard C programs that can be built with gcc

##### `make build TARGET=<name>`
- **Input**: TARGET parameter specifying which target to build
- **Output**: Builds the specified target executable
- **Valid targets**: homework-6-3, space-invaders, homework-6-1 through 6-5, project-1, penrose-music
- **Note**: Embedded targets (6-1, 6-2, 6-4, 6-5, project-1, penrose-music) require 8051 tools

#### Execution Commands

##### `make run`
- **Input**: None (interactive mode)
- **Output**: Lists all available runnable targets and provides interactive execution
- **Description**: Shows menu of compiled programs and allows sequential execution

##### `make run TARGET=<name>`
- **Input**: TARGET parameter specifying which program to run
- **Output**: Executes the specified program
- **Valid targets**: homework-6-3, space-invaders

##### `make autorun TARGET=<name>`
- **Input**: 
  - TARGET parameter
  - Optional input file at `../../input/cpe3150-<target>.txt`
- **Output**: Runs target with piped input from file if available
- **Description**: Automated execution with predefined input

#### Maintenance Commands

##### `make clean`
- **Input**: None
- **Output**: Removes all build artifacts and executables
- **Description**: Cleans the build directory

##### `make test`
- **Input**: None
- **Output**: Message indicating no automated tests available
- **Note**: Projects were tested on actual 8051 hardware

##### `make list`
- **Input**: None
- **Output**: Formatted list of all available build targets with descriptions
- **Description**: Shows all targets organized by category

##### `make help`
- **Input**: None
- **Output**: Comprehensive usage guide with all commands and descriptions
- **Description**: Default target that displays help information

## Project Structure

### Homework 6
Location: `homework-6/`

#### Problem 1: Binary to Decimal Converter (8051)
- **File**: `1.c` (embedded in LaTeX)
- **Platform**: 8051 microcontroller
- **Description**: Converts binary input to decimal output using ports P1 (input) and P2 (output)
- **Build**: Requires SDCC or Keil uVision

#### Problem 2: ROM Data Reader (8051)
- **File**: `2.c`
- **Platform**: 8051 microcontroller
- **Description**: Reads Fibonacci sequence from ROM or calculates dynamically based on P2^1 flag
- **Build**: Requires SDCC or Keil uVision

#### Problem 3: Bit Manipulation
- **File**: `3.c`
- **Platform**: Standard C
- **Description**: Swaps high and low nibbles of a byte
- **Build**: `make build TARGET=homework-6-3`
- **Run**: `make run TARGET=homework-6-3`
- **Input**: None (hardcoded value 0x38)
- **Output**: Hexadecimal result of bit swap (0x83)

#### Problem 4: 16-bit Multiplication (8051)
- **File**: `4.c`
- **Platform**: 8051 microcontroller  
- **Description**: Performs 16-bit multiplication on 8051
- **Build**: Requires SDCC or Keil uVision

#### Problem 5: Power Calculation (8051)
- **File**: `5.c`
- **Platform**: 8051 microcontroller
- **Description**: Calculates power function on 8051
- **Build**: Requires SDCC or Keil uVision

### Project 1: Music Player
Location: `project-1/`

- **Platform**: 8051 Assembly
- **Files**: 
  - `project1.a51` - Main assembly code
  - `music.a51` - Music data and routines
  - `reg932.inc` - Register definitions
- **Build**: Requires Keil uVision
- **Pre-built**: `code/Objects/project1.hex` available
- **Description**: Assembly language music player for 8051

### Project 3: Terminal Games
Location: `project-3/`

#### Space Invaders
- **Location**: `code/space-invaders/`
- **Platform**: Standard C with ncurses
- **Build**: `make build TARGET=space-invaders`
- **Run**: `make run TARGET=space-invaders`
- **Input**: Keyboard controls (terminal-based game)
- **Output**: Interactive ncurses-based Space Invaders game
- **Known Issues**: Aliens don't shoot or move (incomplete implementation)
- **Dependencies**: ncurses library

#### Penrose Music System
- **Location**: `code/penrose-music/`
- **Platform**: 8051 microcontroller
- **Features**:
  - Musical keyboard with different notes per button
  - Pre-programmed song (Hurricane's Eye)
  - Binary counter using LEDs
- **Build**: Requires SDCC or Keil uVision
- **Description**: Menu-driven music system for 8051

## Build Requirements

### Standard C Targets
- **Compiler**: gcc
- **Flags**: `-g -Wall`
- **Libraries**: `-lm -lncurses` (for space-invaders)

### 8051 Embedded Targets
- **Option 1**: SDCC (Small Device C Compiler)
  - Flags: `-mmcs51`
- **Option 2**: Keil uVision
  - Required for assembly projects
- **Hardware**: 8051 microcontroller for testing
- **Additional Tools**: Flash Magic for programming

## Color-Coded Output
The Makefile uses ANSI color codes for better readability:
- 🟢 Green: Success messages
- 🔵 Blue: Headers and section titles
- 🔷 Cyan: Progress indicators
- 🟡 Yellow: Warnings and notes
- 🔴 Red: Error messages

## Usage Examples

```bash
# Build all standard C programs
make build

# Build and run homework 6, problem 3
make build TARGET=homework-6-3
make run TARGET=homework-6-3

# Build and run Space Invaders
make build TARGET=space-invaders
make run TARGET=space-invaders

# Clean all build artifacts
make clean

# Show available targets
make list

# Get help
make help
```

## Notes
- Standard C targets can be built and run on any system with gcc
- Embedded targets require specialized 8051 development tools
- Some homework solutions are embedded within LaTeX documents
- Project documentation and reports available in respective directories
- Hardware testing was performed on actual 8051 microcontrollers

## Legacy Status
As noted in the project documentation, this coursework is considered legacy and further support has been discontinued. The code serves as reference material for 8051 microcontroller programming and embedded systems development.