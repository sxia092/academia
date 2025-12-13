# CS3001 Skills Development - Build System
# This course contains professional development presentations and deliverables.
# There is no compilable source code in this course.
#
# Available targets:
#   make build              - No-op (no code to build)
#   make list               - List course contents
#   make clean              - No-op (no build artifacts)
#   make help               - Display this help message

# ==============================================================================
# Configuration
# ==============================================================================

# Color output for better readability
RED = \033[0;31m
GREEN = \033[0;32m
YELLOW = \033[1;33m
CYAN = \033[1;36m
NC = \033[0m

# ==============================================================================
# Main Targets
# ==============================================================================

.PHONY: all help build run autorun list clean

# Default target
all: help

# Help target - displays available commands
help:
	@echo "$(CYAN)CS3001 Skills Development - Build System$(NC)"
	@echo ""
	@echo "$(YELLOW)Note:$(NC) This course contains professional development"
	@echo "      presentations and deliverables. No compilable code."
	@echo ""
	@echo "$(YELLOW)Contents:$(NC)"
	@echo "  assets/       - Presentation images and resources"
	@echo "  deliverables/ - Video presentations and homework submissions"
	@echo "  skills.numbers - Grade tracking spreadsheet"

# List course contents
list:
	@echo "$(CYAN)Course contents (no compilable targets):$(NC)"
	@echo ""
	@echo "$(YELLOW)Deliverables:$(NC)"
	@ls -1 deliverables/ 2>/dev/null || echo "  (none)"
	@echo ""
	@echo "$(YELLOW)Assets:$(NC)"
	@ls -1 assets/ 2>/dev/null || echo "  (none)"

# Build target - no-op for this course
build:
	@echo "$(YELLOW)CS3001 Skills Development: No code to build$(NC)"
	@echo "This course contains presentations and deliverables only."

# Run target - no-op for this course
run:
	@echo "$(YELLOW)CS3001 Skills Development: No executables to run$(NC)"
	@echo "This course contains presentations and deliverables only."

# Autorun target - no-op for this course
autorun:
	@echo "$(YELLOW)CS3001 Skills Development: No executables to run$(NC)"
	@echo "This course contains presentations and deliverables only."

# Clean target - no-op for this course
clean:
	@echo "$(YELLOW)CS3001 Skills Development: No build artifacts to clean$(NC)"
