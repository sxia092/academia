# Master Build System for All Course Projects
# This makefile provides a unified interface for building and running
# all course projects across the entire academic portfolio.

# Color output for better readability
RED = \033[0;31m
GREEN = \033[0;32m
YELLOW = \033[1;33m
BLUE = \033[1;34m
MAGENTA = \033[1;35m
CYAN = \033[1;36m
NC = \033[0m # No Color

# Course directories with makefiles
COURSES_WITH_MAKEFILES = cpe3150-micro-embedded-design cs1001-data-structures-lab cs1200-discrete-math cs1510-data-structures cs1570-intro-to-programming cs1580-intro-to-programming-lab cs2200-theory-of-computer-science cs2300-databases cs2500-algorithms cs3001-skills-development cs3100-software-engineering-i cs3200-numerical-methods cs3500-programming-languages-and-translators cs3800-operating-systems cs4096-software-systems-development cs4099-undergrad-research cs5200-analysis-of-algorithms cs5201-object-oriented-numerical-modeling-ninjas cs5400-artificial-intelligence cs5402-data-mining math3304-differential-equations missouri-valley-college

# Default target
.PHONY: all
all: help

# ==============================================================================
# Install Dependencies
# ==============================================================================
# Installs required dependencies for various course projects:
#   - boost: Required for cs4099 CFG tracer (C++ regex)
#   - progressbar2: Required for cs5400 AI puzzle solvers (Python)
#
# Usage: make install
# ==============================================================================
.PHONY: install
install:
	@echo "$(CYAN)Installing dependencies...$(NC)"
	@echo ""
	@echo "$(YELLOW)Installing Boost (for cs4099-undergrad-research)...$(NC)"
	@if command -v brew >/dev/null 2>&1; then \
		brew install boost 2>/dev/null || echo "$(GREEN)✓ Boost already installed$(NC)"; \
	else \
		echo "$(RED)Homebrew not found. Install manually: https://brew.sh$(NC)"; \
	fi
	@echo ""
	@echo "$(YELLOW)Installing Python dependencies (for cs5400-artificial-intelligence)...$(NC)"
	@if command -v pip3 >/dev/null 2>&1; then \
		pip3 install --quiet progressbar2 && echo "$(GREEN)✓ progressbar2 installed$(NC)"; \
	elif command -v pip >/dev/null 2>&1; then \
		pip install --quiet progressbar2 && echo "$(GREEN)✓ progressbar2 installed$(NC)"; \
	else \
		echo "$(RED)pip not found. Install Python/pip first.$(NC)"; \
	fi
	@echo ""
	@echo "$(GREEN)✓ Dependency installation complete$(NC)"

# Help target - displays available commands
.PHONY: help
help:
	@echo "$(BLUE)╔════════════════════════════════════════════════════════════╗$(NC)"
	@echo "$(BLUE)║$(NC)  $(GREEN)Master Build System - Academic Portfolio$(NC)                 $(BLUE)║$(NC)"
	@echo "$(BLUE)╚════════════════════════════════════════════════════════════╝$(NC)"
	@echo ""
	@echo "$(YELLOW)Global Commands:$(NC)"
	@echo "  make build-all            - Build all courses"
	@echo "  make build COURSE=<name>  - Build specific course"
	@echo "  make test-all             - Run all tests"
	@echo "  make clean-all            - Clean all build artifacts"
	@echo "  make list-courses         - List all available courses"
	@echo ""
	@echo "$(YELLOW)Course-Specific Commands:$(NC)"
	@echo "  make <course>-build       - Build specific course"
	@echo "  make <course>-run         - Run targets in specific course"
	@echo "  make <course>-test        - Test specific course"
	@echo "  make <course>-clean       - Clean specific course"
	@echo ""
	@echo "$(CYAN)Available Courses:$(NC)"
	@for course in $(COURSES_WITH_MAKEFILES); do \
		echo "  • $$course"; \
	done

# Build all courses
.PHONY: build-all
build-all:
	@echo "$(GREEN)Building all courses...$(NC)"
	@for course in $(COURSES_WITH_MAKEFILES); do \
		echo "$(CYAN)════════════════════════════════════════$(NC)"; \
		echo "$(CYAN)Building $$course...$(NC)"; \
		echo "$(CYAN)════════════════════════════════════════$(NC)"; \
		$(MAKE) -C $$course build || exit 1; \
		echo ""; \
	done
	@echo "$(GREEN)✓ All courses built successfully!$(NC)"

# Build specific course
.PHONY: build
build:
ifdef COURSE
	@if [ -d "$(COURSE)" ] && [ -f "$(COURSE)/makefile" -o -f "$(COURSE)/Makefile" ]; then \
		echo "$(GREEN)Building $(COURSE)...$(NC)"; \
		$(MAKE) -C $(COURSE) build; \
	else \
		echo "$(RED)Error: Course '$(COURSE)' not found or has no makefile$(NC)"; \
		exit 1; \
	fi
else
	@echo "$(RED)Error: Please specify COURSE=<name>$(NC)"
	@echo "Example: make build COURSE=cpe3150-micro-embedded-design"
endif

# Test all courses
.PHONY: test-all
test-all:
	@echo "$(GREEN)Running tests for all courses...$(NC)"
	@for course in $(COURSES_WITH_MAKEFILES); do \
		echo "$(CYAN)Testing $$course...$(NC)"; \
		$(MAKE) -C $$course test || true; \
		echo ""; \
	done

# Clean all courses
.PHONY: clean-all
clean-all:
	@echo "$(YELLOW)Cleaning all courses...$(NC)"
	@for course in $(COURSES_WITH_MAKEFILES); do \
		echo "Cleaning $$course..."; \
		$(MAKE) -C $$course clean || true; \
	done
	@echo "$(GREEN)✓ All courses cleaned$(NC)"

# List all courses
.PHONY: list-courses
list-courses:
	@echo "$(CYAN)Available courses with build systems:$(NC)"
	@echo ""
	@for course in $(COURSES_WITH_MAKEFILES); do \
		echo "$(GREEN)$$course$(NC)"; \
		if [ -f "$$course/makefile" -o -f "$$course/Makefile" ]; then \
			$(MAKE) -C $$course list 2>/dev/null || echo "  (no list target)"; \
		fi; \
		echo ""; \
	done

# CPE3150 Micro/Embedded Design specific targets
.PHONY: cpe3150-micro-embedded-design-build
cpe3150-micro-embedded-design-build:
	@echo "$(CYAN)Building CPE3150 Micro/Embedded Design...$(NC)"
	@$(MAKE) -C cpe3150-micro-embedded-design build

.PHONY: cpe3150-micro-embedded-design-run
cpe3150-micro-embedded-design-run:
	@echo "$(CYAN)Running CPE3150 targets...$(NC)"
	@$(MAKE) -C cpe3150-micro-embedded-design run

.PHONY: cpe3150-micro-embedded-design-test
cpe3150-micro-embedded-design-test:
	@echo "$(CYAN)Testing CPE3150...$(NC)"
	@$(MAKE) -C cpe3150-micro-embedded-design test

.PHONY: cpe3150-micro-embedded-design-clean
cpe3150-micro-embedded-design-clean:
	@echo "$(CYAN)Cleaning CPE3150...$(NC)"
	@$(MAKE) -C cpe3150-micro-embedded-design clean

# Shorthand aliases for CPE3150
.PHONY: cpe3150-build cpe3150-run cpe3150-test cpe3150-clean
cpe3150-build: cpe3150-micro-embedded-design-build
cpe3150-run: cpe3150-micro-embedded-design-run
cpe3150-test: cpe3150-micro-embedded-design-test
cpe3150-clean: cpe3150-micro-embedded-design-clean

# CS1001 Data Structures Lab specific targets
.PHONY: cs1001-data-structures-lab-build
cs1001-data-structures-lab-build:
	@echo "$(CYAN)Building CS1001 Data Structures Lab...$(NC)"
	@$(MAKE) -C cs1001-data-structures-lab build

.PHONY: cs1001-data-structures-lab-run
cs1001-data-structures-lab-run:
	@echo "$(CYAN)Running CS1001 targets...$(NC)"
	@$(MAKE) -C cs1001-data-structures-lab run

.PHONY: cs1001-data-structures-lab-test
cs1001-data-structures-lab-test:
	@echo "$(CYAN)Testing CS1001...$(NC)"
	@$(MAKE) -C cs1001-data-structures-lab test

.PHONY: cs1001-data-structures-lab-clean
cs1001-data-structures-lab-clean:
	@echo "$(CYAN)Cleaning CS1001...$(NC)"
	@$(MAKE) -C cs1001-data-structures-lab clean

# Shorthand aliases for CS1001
.PHONY: cs1001-build cs1001-run cs1001-test cs1001-clean
cs1001-build: cs1001-data-structures-lab-build
cs1001-run: cs1001-data-structures-lab-run
cs1001-test: cs1001-data-structures-lab-test
cs1001-clean: cs1001-data-structures-lab-clean

# CS1200 Discrete Mathematics specific targets
.PHONY: cs1200-discrete-math-build
cs1200-discrete-math-build:
	@echo "$(CYAN)Building CS1200 Discrete Mathematics...$(NC)"
	@$(MAKE) -C cs1200-discrete-math build

.PHONY: cs1200-discrete-math-run
cs1200-discrete-math-run:
	@echo "$(CYAN)Running CS1200 targets...$(NC)"
	@$(MAKE) -C cs1200-discrete-math run

.PHONY: cs1200-discrete-math-clean
cs1200-discrete-math-clean:
	@echo "$(CYAN)Cleaning CS1200...$(NC)"
	@$(MAKE) -C cs1200-discrete-math clean

# Shorthand aliases for CS1200
.PHONY: cs1200-build cs1200-run cs1200-clean
cs1200-build: cs1200-discrete-math-build
cs1200-run: cs1200-discrete-math-run
cs1200-clean: cs1200-discrete-math-clean

# CS1510 Data Structures specific targets
.PHONY: cs1510-data-structures-build
cs1510-data-structures-build:
	@echo "$(CYAN)Building CS1510 Data Structures...$(NC)"
	@$(MAKE) -C cs1510-data-structures build

.PHONY: cs1510-data-structures-run
cs1510-data-structures-run:
	@echo "$(CYAN)Running CS1510 targets...$(NC)"
	@$(MAKE) -C cs1510-data-structures run

.PHONY: cs1510-data-structures-clean
cs1510-data-structures-clean:
	@echo "$(CYAN)Cleaning CS1510...$(NC)"
	@$(MAKE) -C cs1510-data-structures clean

# Shorthand aliases for CS1510
.PHONY: cs1510-build cs1510-run cs1510-clean
cs1510-build: cs1510-data-structures-build
cs1510-run: cs1510-data-structures-run
cs1510-clean: cs1510-data-structures-clean

# CS1570 Introduction to Programming specific targets
.PHONY: cs1570-intro-to-programming-build
cs1570-intro-to-programming-build:
	@echo "$(CYAN)Building CS1570 Introduction to Programming...$(NC)"
	@$(MAKE) -C cs1570-intro-to-programming build

.PHONY: cs1570-intro-to-programming-run
cs1570-intro-to-programming-run:
	@echo "$(CYAN)Running CS1570 targets...$(NC)"
	@$(MAKE) -C cs1570-intro-to-programming run

.PHONY: cs1570-intro-to-programming-clean
cs1570-intro-to-programming-clean:
	@echo "$(CYAN)Cleaning CS1570...$(NC)"
	@$(MAKE) -C cs1570-intro-to-programming clean

# Shorthand aliases for CS1570
.PHONY: cs1570-build cs1570-run cs1570-clean
cs1570-build: cs1570-intro-to-programming-build
cs1570-run: cs1570-intro-to-programming-run
cs1570-clean: cs1570-intro-to-programming-clean

# CS1580 Introduction to Programming Lab specific targets
.PHONY: cs1580-intro-to-programming-lab-build
cs1580-intro-to-programming-lab-build:
	@echo "$(CYAN)Building CS1580 Introduction to Programming Lab...$(NC)"
	@$(MAKE) -C cs1580-intro-to-programming-lab build

.PHONY: cs1580-intro-to-programming-lab-run
cs1580-intro-to-programming-lab-run:
	@echo "$(CYAN)Running CS1580 targets...$(NC)"
	@$(MAKE) -C cs1580-intro-to-programming-lab run

.PHONY: cs1580-intro-to-programming-lab-clean
cs1580-intro-to-programming-lab-clean:
	@echo "$(CYAN)Cleaning CS1580...$(NC)"
	@$(MAKE) -C cs1580-intro-to-programming-lab clean

# Shorthand aliases for CS1580
.PHONY: cs1580-build cs1580-run cs1580-clean
cs1580-build: cs1580-intro-to-programming-lab-build
cs1580-run: cs1580-intro-to-programming-lab-run
cs1580-clean: cs1580-intro-to-programming-lab-clean

# CS2200 Theory of Computer Science specific targets
.PHONY: cs2200-theory-of-computer-science-build
cs2200-theory-of-computer-science-build:
	@echo "$(CYAN)Building CS2200 Theory of Computer Science...$(NC)"
	@$(MAKE) -C cs2200-theory-of-computer-science build

.PHONY: cs2200-theory-of-computer-science-run
cs2200-theory-of-computer-science-run:
	@echo "$(CYAN)Running CS2200 targets...$(NC)"
	@$(MAKE) -C cs2200-theory-of-computer-science run

.PHONY: cs2200-theory-of-computer-science-clean
cs2200-theory-of-computer-science-clean:
	@echo "$(CYAN)Cleaning CS2200...$(NC)"
	@$(MAKE) -C cs2200-theory-of-computer-science clean

# Shorthand aliases for CS2200
.PHONY: cs2200-build cs2200-run cs2200-clean
cs2200-build: cs2200-theory-of-computer-science-build
cs2200-run: cs2200-theory-of-computer-science-run
cs2200-clean: cs2200-theory-of-computer-science-clean

# CS2300 Databases specific targets
.PHONY: cs2300-databases-build
cs2300-databases-build:
	@echo "$(CYAN)Building CS2300 Databases...$(NC)"
	@$(MAKE) -C cs2300-databases build

.PHONY: cs2300-databases-run
cs2300-databases-run:
	@echo "$(CYAN)Running CS2300 targets...$(NC)"
	@$(MAKE) -C cs2300-databases run

.PHONY: cs2300-databases-clean
cs2300-databases-clean:
	@echo "$(CYAN)Cleaning CS2300...$(NC)"
	@$(MAKE) -C cs2300-databases clean

# Shorthand aliases for CS2300
.PHONY: cs2300-build cs2300-run cs2300-clean
cs2300-build: cs2300-databases-build
cs2300-run: cs2300-databases-run
cs2300-clean: cs2300-databases-clean

# CS2500 Algorithms specific targets
.PHONY: cs2500-algorithms-build
cs2500-algorithms-build:
	@echo "$(CYAN)Building CS2500 Algorithms...$(NC)"
	@$(MAKE) -C cs2500-algorithms build

.PHONY: cs2500-algorithms-run
cs2500-algorithms-run:
	@echo "$(CYAN)Running CS2500 targets...$(NC)"
	@$(MAKE) -C cs2500-algorithms run

.PHONY: cs2500-algorithms-clean
cs2500-algorithms-clean:
	@echo "$(CYAN)Cleaning CS2500...$(NC)"
	@$(MAKE) -C cs2500-algorithms clean

# Shorthand aliases for CS2500
.PHONY: cs2500-build cs2500-run cs2500-clean
cs2500-build: cs2500-algorithms-build
cs2500-run: cs2500-algorithms-run
cs2500-clean: cs2500-algorithms-clean

# CS3001 Skills Development specific targets (no compilable code)
.PHONY: cs3001-skills-development-build
cs3001-skills-development-build:
	@echo "$(CYAN)Building CS3001 Skills Development...$(NC)"
	@$(MAKE) -C cs3001-skills-development build

.PHONY: cs3001-skills-development-run
cs3001-skills-development-run:
	@echo "$(CYAN)Running CS3001 targets...$(NC)"
	@$(MAKE) -C cs3001-skills-development run

.PHONY: cs3001-skills-development-clean
cs3001-skills-development-clean:
	@echo "$(CYAN)Cleaning CS3001...$(NC)"
	@$(MAKE) -C cs3001-skills-development clean

# Shorthand aliases for CS3001
.PHONY: cs3001-build cs3001-run cs3001-clean
cs3001-build: cs3001-skills-development-build
cs3001-run: cs3001-skills-development-run
cs3001-clean: cs3001-skills-development-clean

# CS3100 Software Engineering I specific targets (Python - Camelot project)
.PHONY: cs3100-software-engineering-i-build
cs3100-software-engineering-i-build:
	@echo "$(CYAN)Building CS3100 Software Engineering I...$(NC)"
	@$(MAKE) -C cs3100-software-engineering-i build

.PHONY: cs3100-software-engineering-i-run
cs3100-software-engineering-i-run:
	@echo "$(CYAN)Running CS3100 targets...$(NC)"
	@$(MAKE) -C cs3100-software-engineering-i run

.PHONY: cs3100-software-engineering-i-clean
cs3100-software-engineering-i-clean:
	@echo "$(CYAN)Cleaning CS3100...$(NC)"
	@$(MAKE) -C cs3100-software-engineering-i clean

# Shorthand aliases for CS3100
.PHONY: cs3100-build cs3100-run cs3100-clean
cs3100-build: cs3100-software-engineering-i-build
cs3100-run: cs3100-software-engineering-i-run
cs3100-clean: cs3100-software-engineering-i-clean

# CS3200 Numerical Methods specific targets (MATLAB)
.PHONY: cs3200-numerical-methods-build
cs3200-numerical-methods-build:
	@echo "$(CYAN)Building CS3200 Numerical Methods...$(NC)"
	@$(MAKE) -C cs3200-numerical-methods build

.PHONY: cs3200-numerical-methods-run
cs3200-numerical-methods-run:
	@echo "$(CYAN)Running CS3200 targets...$(NC)"
	@$(MAKE) -C cs3200-numerical-methods run

.PHONY: cs3200-numerical-methods-clean
cs3200-numerical-methods-clean:
	@echo "$(CYAN)Cleaning CS3200...$(NC)"
	@$(MAKE) -C cs3200-numerical-methods clean

# Shorthand aliases for CS3200
.PHONY: cs3200-build cs3200-run cs3200-clean
cs3200-build: cs3200-numerical-methods-build
cs3200-run: cs3200-numerical-methods-run
cs3200-clean: cs3200-numerical-methods-clean

# CS3500 Programming Languages and Translators specific targets
.PHONY: cs3500-programming-languages-and-translators-build
cs3500-programming-languages-and-translators-build:
	@echo "$(CYAN)Building CS3500 Programming Languages and Translators...$(NC)"
	@$(MAKE) -C cs3500-programming-languages-and-translators build

.PHONY: cs3500-programming-languages-and-translators-run
cs3500-programming-languages-and-translators-run:
	@echo "$(CYAN)Running CS3500 targets...$(NC)"
	@$(MAKE) -C cs3500-programming-languages-and-translators run

.PHONY: cs3500-programming-languages-and-translators-clean
cs3500-programming-languages-and-translators-clean:
	@echo "$(CYAN)Cleaning CS3500...$(NC)"
	@$(MAKE) -C cs3500-programming-languages-and-translators clean

# Shorthand aliases for CS3500
.PHONY: cs3500-build cs3500-run cs3500-clean
cs3500-build: cs3500-programming-languages-and-translators-build
cs3500-run: cs3500-programming-languages-and-translators-run
cs3500-clean: cs3500-programming-languages-and-translators-clean

# ------------------------------------------------------------------------------
# CS3800 Operating Systems
# ------------------------------------------------------------------------------
.PHONY: cs3800-operating-systems-build cs3800-operating-systems-run
.PHONY: cs3800-operating-systems-autorun cs3800-operating-systems-clean

cs3800-operating-systems-build:
	@$(MAKE) -C cs3800-operating-systems build

cs3800-operating-systems-run:
ifdef TARGET
	@$(MAKE) -C cs3800-operating-systems run TARGET=$(TARGET)
else
	@$(MAKE) -C cs3800-operating-systems run
endif

cs3800-operating-systems-autorun:
ifdef TARGET
	@$(MAKE) -C cs3800-operating-systems autorun TARGET=$(TARGET)
else
	@$(MAKE) -C cs3800-operating-systems autorun
endif

cs3800-operating-systems-clean:
	@$(MAKE) -C cs3800-operating-systems clean

# Shorthand aliases for CS3800
.PHONY: cs3800-build cs3800-run cs3800-autorun cs3800-clean
cs3800-build: cs3800-operating-systems-build
cs3800-run: cs3800-operating-systems-run
cs3800-autorun: cs3800-operating-systems-autorun
cs3800-clean: cs3800-operating-systems-clean

# ------------------------------------------------------------------------------
# CS4096 Software Systems Development (Splatoonio)
# ------------------------------------------------------------------------------
.PHONY: cs4096-software-systems-development-build cs4096-software-systems-development-run
.PHONY: cs4096-software-systems-development-autorun cs4096-software-systems-development-clean

cs4096-software-systems-development-build:
	@$(MAKE) -C cs4096-software-systems-development build

cs4096-software-systems-development-run:
ifdef TARGET
	@$(MAKE) -C cs4096-software-systems-development run TARGET=$(TARGET)
else
	@$(MAKE) -C cs4096-software-systems-development run
endif

cs4096-software-systems-development-autorun:
ifdef TARGET
	@$(MAKE) -C cs4096-software-systems-development autorun TARGET=$(TARGET)
else
	@$(MAKE) -C cs4096-software-systems-development autorun
endif

cs4096-software-systems-development-clean:
	@$(MAKE) -C cs4096-software-systems-development clean

# Shorthand aliases for CS4096
.PHONY: cs4096-build cs4096-run cs4096-autorun cs4096-clean
cs4096-build: cs4096-software-systems-development-build
cs4096-run: cs4096-software-systems-development-run
cs4096-autorun: cs4096-software-systems-development-autorun
cs4096-clean: cs4096-software-systems-development-clean

# ------------------------------------------------------------------------------
# CS4099 Undergraduate Research (CFG Tracer)
# ------------------------------------------------------------------------------
.PHONY: cs4099-undergrad-research-build cs4099-undergrad-research-run
.PHONY: cs4099-undergrad-research-autorun cs4099-undergrad-research-clean

cs4099-undergrad-research-build:
	@$(MAKE) -C cs4099-undergrad-research build

cs4099-undergrad-research-run:
ifdef TARGET
	@$(MAKE) -C cs4099-undergrad-research run TARGET=$(TARGET)
else
	@$(MAKE) -C cs4099-undergrad-research run
endif

cs4099-undergrad-research-autorun:
ifdef TARGET
	@$(MAKE) -C cs4099-undergrad-research autorun TARGET=$(TARGET)
else
	@$(MAKE) -C cs4099-undergrad-research autorun
endif

cs4099-undergrad-research-clean:
	@$(MAKE) -C cs4099-undergrad-research clean

# Shorthand aliases for CS4099
.PHONY: cs4099-build cs4099-run cs4099-autorun cs4099-clean
cs4099-build: cs4099-undergrad-research-build
cs4099-run: cs4099-undergrad-research-run
cs4099-autorun: cs4099-undergrad-research-autorun
cs4099-clean: cs4099-undergrad-research-clean

# ------------------------------------------------------------------------------
# CS5200 Analysis of Algorithms
# ------------------------------------------------------------------------------
.PHONY: cs5200-analysis-of-algorithms-build cs5200-analysis-of-algorithms-run
.PHONY: cs5200-analysis-of-algorithms-autorun cs5200-analysis-of-algorithms-clean

cs5200-analysis-of-algorithms-build:
	@$(MAKE) -C cs5200-analysis-of-algorithms build

cs5200-analysis-of-algorithms-run:
ifdef TARGET
	@$(MAKE) -C cs5200-analysis-of-algorithms run TARGET=$(TARGET)
else
	@$(MAKE) -C cs5200-analysis-of-algorithms run
endif

cs5200-analysis-of-algorithms-autorun:
ifdef TARGET
	@$(MAKE) -C cs5200-analysis-of-algorithms autorun TARGET=$(TARGET)
else
	@$(MAKE) -C cs5200-analysis-of-algorithms autorun
endif

cs5200-analysis-of-algorithms-clean:
	@$(MAKE) -C cs5200-analysis-of-algorithms clean

# Shorthand aliases for CS5200
.PHONY: cs5200-build cs5200-run cs5200-autorun cs5200-clean
cs5200-build: cs5200-analysis-of-algorithms-build
cs5200-run: cs5200-analysis-of-algorithms-run
cs5200-autorun: cs5200-analysis-of-algorithms-autorun
cs5200-clean: cs5200-analysis-of-algorithms-clean

# ------------------------------------------------------------------------------
# CS5201 Object-Oriented Numerical Modeling
# ------------------------------------------------------------------------------
.PHONY: cs5201-object-oriented-numerical-modeling-ninjas-build
.PHONY: cs5201-object-oriented-numerical-modeling-ninjas-run
.PHONY: cs5201-object-oriented-numerical-modeling-ninjas-autorun
.PHONY: cs5201-object-oriented-numerical-modeling-ninjas-clean

cs5201-object-oriented-numerical-modeling-ninjas-build:
	@$(MAKE) -C cs5201-object-oriented-numerical-modeling-ninjas build

cs5201-object-oriented-numerical-modeling-ninjas-run:
ifdef TARGET
	@$(MAKE) -C cs5201-object-oriented-numerical-modeling-ninjas run TARGET=$(TARGET)
else
	@$(MAKE) -C cs5201-object-oriented-numerical-modeling-ninjas run
endif

cs5201-object-oriented-numerical-modeling-ninjas-autorun:
ifdef TARGET
	@$(MAKE) -C cs5201-object-oriented-numerical-modeling-ninjas autorun TARGET=$(TARGET)
else
	@$(MAKE) -C cs5201-object-oriented-numerical-modeling-ninjas autorun
endif

cs5201-object-oriented-numerical-modeling-ninjas-clean:
	@$(MAKE) -C cs5201-object-oriented-numerical-modeling-ninjas clean

# Shorthand aliases for CS5201
.PHONY: cs5201-build cs5201-run cs5201-autorun cs5201-clean
cs5201-build: cs5201-object-oriented-numerical-modeling-ninjas-build
cs5201-run: cs5201-object-oriented-numerical-modeling-ninjas-run
cs5201-autorun: cs5201-object-oriented-numerical-modeling-ninjas-autorun
cs5201-clean: cs5201-object-oriented-numerical-modeling-ninjas-clean

# ------------------------------------------------------------------------------
# CS5400 Artificial Intelligence
# ------------------------------------------------------------------------------
.PHONY: cs5400-artificial-intelligence-build cs5400-artificial-intelligence-run
.PHONY: cs5400-artificial-intelligence-autorun cs5400-artificial-intelligence-test
.PHONY: cs5400-artificial-intelligence-clean

cs5400-artificial-intelligence-build:
	@$(MAKE) -C cs5400-artificial-intelligence build

cs5400-artificial-intelligence-run:
ifdef TARGET
	@$(MAKE) -C cs5400-artificial-intelligence run TARGET=$(TARGET)
else
	@$(MAKE) -C cs5400-artificial-intelligence run
endif

cs5400-artificial-intelligence-autorun:
ifdef TARGET
	@$(MAKE) -C cs5400-artificial-intelligence autorun TARGET=$(TARGET)
else
	@$(MAKE) -C cs5400-artificial-intelligence autorun
endif

cs5400-artificial-intelligence-test:
ifdef TARGET
	@$(MAKE) -C cs5400-artificial-intelligence test TARGET=$(TARGET)
else
	@$(MAKE) -C cs5400-artificial-intelligence test
endif

cs5400-artificial-intelligence-clean:
	@$(MAKE) -C cs5400-artificial-intelligence clean

# Shorthand aliases for CS5400
.PHONY: cs5400-build cs5400-run cs5400-autorun cs5400-test cs5400-clean
cs5400-build: cs5400-artificial-intelligence-build
cs5400-run: cs5400-artificial-intelligence-run
cs5400-autorun: cs5400-artificial-intelligence-autorun
cs5400-test: cs5400-artificial-intelligence-test
cs5400-clean: cs5400-artificial-intelligence-clean

# ------------------------------------------------------------------------------
# CS5402 Data Mining
# ------------------------------------------------------------------------------
.PHONY: cs5402-data-mining-build cs5402-data-mining-run
.PHONY: cs5402-data-mining-autorun cs5402-data-mining-clean

cs5402-data-mining-build:
	@$(MAKE) -C cs5402-data-mining build

cs5402-data-mining-run:
ifdef TARGET
	@$(MAKE) -C cs5402-data-mining run TARGET=$(TARGET)
else
	@$(MAKE) -C cs5402-data-mining run
endif

cs5402-data-mining-autorun:
ifdef TARGET
	@$(MAKE) -C cs5402-data-mining autorun TARGET=$(TARGET)
else
	@$(MAKE) -C cs5402-data-mining autorun
endif

cs5402-data-mining-clean:
	@$(MAKE) -C cs5402-data-mining clean

# Shorthand aliases for CS5402
.PHONY: cs5402-build cs5402-run cs5402-autorun cs5402-clean
cs5402-build: cs5402-data-mining-build
cs5402-run: cs5402-data-mining-run
cs5402-autorun: cs5402-data-mining-autorun
cs5402-clean: cs5402-data-mining-clean

# ------------------------------------------------------------------------------
# MATH3304 Differential Equations
# ------------------------------------------------------------------------------
.PHONY: math3304-differential-equations-build math3304-differential-equations-run
.PHONY: math3304-differential-equations-autorun math3304-differential-equations-clean

math3304-differential-equations-build:
	@$(MAKE) -C math3304-differential-equations build

math3304-differential-equations-run:
ifdef TARGET
	@$(MAKE) -C math3304-differential-equations run TARGET=$(TARGET)
else
	@$(MAKE) -C math3304-differential-equations run
endif

math3304-differential-equations-autorun:
ifdef TARGET
	@$(MAKE) -C math3304-differential-equations autorun TARGET=$(TARGET)
else
	@$(MAKE) -C math3304-differential-equations autorun
endif

math3304-differential-equations-clean:
	@$(MAKE) -C math3304-differential-equations clean

# Shorthand aliases for MATH3304
.PHONY: math3304-build math3304-run math3304-autorun math3304-clean
math3304-build: math3304-differential-equations-build
math3304-run: math3304-differential-equations-run
math3304-autorun: math3304-differential-equations-autorun
math3304-clean: math3304-differential-equations-clean

# ------------------------------------------------------------------------------
# Missouri Valley College (Pre-transfer coursework)
# ------------------------------------------------------------------------------
.PHONY: missouri-valley-college-build missouri-valley-college-run
.PHONY: missouri-valley-college-autorun missouri-valley-college-clean

missouri-valley-college-build:
	@$(MAKE) -C missouri-valley-college build

missouri-valley-college-run:
ifdef TARGET
	@$(MAKE) -C missouri-valley-college run TARGET=$(TARGET)
else
	@$(MAKE) -C missouri-valley-college run
endif

missouri-valley-college-autorun:
ifdef TARGET
	@$(MAKE) -C missouri-valley-college autorun TARGET=$(TARGET)
else
	@$(MAKE) -C missouri-valley-college autorun
endif

missouri-valley-college-clean:
	@$(MAKE) -C missouri-valley-college clean

# Shorthand aliases for MVC
.PHONY: mvc-build mvc-run mvc-autorun mvc-clean
mvc-build: missouri-valley-college-build
mvc-run: missouri-valley-college-run
mvc-autorun: missouri-valley-college-autorun
mvc-clean: missouri-valley-college-clean

# Additional course targets can be added here as more makefiles are created
# Template for adding new courses:
# .PHONY: <course-name>-build <course-name>-run <course-name>-test <course-name>-clean
# <course-name>-build:
#	@$(MAKE) -C <course-name> build
# ...

# Utility targets
.PHONY: stats
stats:
	@echo "$(CYAN)Course Statistics:$(NC)"
	@echo "Total courses with makefiles: $(words $(COURSES_WITH_MAKEFILES))"
	@for course in $(COURSES_WITH_MAKEFILES); do \
		if [ -d "$$course" ]; then \
			file_count=$$(find $$course -type f \( -name "*.c" -o -name "*.cpp" -o -name "*.h" -o -name "*.hpp" -o -name "*.a51" -o -name "*.asm" \) | wc -l); \
			echo "  $$course: $$file_count source files"; \
		fi; \
	done

# Quick test build for validation
.PHONY: validate
validate:
	@echo "$(YELLOW)Validating build systems...$(NC)"
	@failed=0; \
	for course in $(COURSES_WITH_MAKEFILES); do \
		echo -n "  $$course: "; \
		if $(MAKE) -C $$course build > /dev/null 2>&1; then \
			echo "$(GREEN)✓$(NC)"; \
		else \
			echo "$(RED)✗$(NC)"; \
			failed=$$((failed + 1)); \
		fi; \
	done; \
	if [ $$failed -eq 0 ]; then \
		echo "$(GREEN)All build systems validated successfully!$(NC)"; \
	else \
		echo "$(RED)$$failed course(s) failed validation$(NC)"; \
		exit 1; \
	fi