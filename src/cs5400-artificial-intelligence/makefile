# CS5400 Artificial Intelligence - Build System
# Graduate-level AI course covering search algorithms, game playing, and machine learning.
# Contains puzzle-series (Python) and game-series (multi-language with Joueur framework).
#
# Available targets:
#   make build              - Verify/build all assignments
#   make build TARGET=X     - Build specific target
#   make run TARGET=X       - Run specific target
#   make autorun TARGET=X   - Run with default inputs
#   make test TARGET=X      - Run tests for specific target
#   make list               - List available targets
#   make clean              - Remove all build artifacts
#   make help               - Display this help message

# ==============================================================================
# Configuration
# ==============================================================================

# Directories
PUZZLE_DIR = puzzle-series
GAME_DIR = game-series

# Color output for better readability
RED = \033[0;31m
GREEN = \033[0;32m
YELLOW = \033[1;33m
CYAN = \033[1;36m
NC = \033[0m

# Available targets
PUZZLE_TARGETS = puzzle1 puzzle2 puzzle3 puzzle4
GAME_TARGETS = game1 game2 game3 game4 game4_makeup
ALL_TARGETS = $(PUZZLE_TARGETS) $(GAME_TARGETS)

# ==============================================================================
# Main Targets
# ==============================================================================

.PHONY: all help build run autorun test list clean

# Default target
all: help

# Help target - displays available commands
help:
	@echo "$(CYAN)CS5400 Artificial Intelligence - Build System$(NC)"
	@echo "$(YELLOW)Graduate-level AI course$(NC)"
	@echo ""
	@echo "$(YELLOW)Usage:$(NC)"
	@echo "  make build              - Verify/build all assignments"
	@echo "  make build TARGET=X     - Build specific target"
	@echo "  make run TARGET=X       - Run specific target"
	@echo "  make autorun TARGET=X   - Run with default inputs"
	@echo "  make test TARGET=X      - Run tests for specific target"
	@echo "  make list               - List available targets"
	@echo "  make clean              - Remove all build artifacts"
	@echo ""
	@echo "$(YELLOW)Puzzle Series (Python):$(NC)"
	@echo "  puzzle1  - Mechanical Match (search algorithms)"
	@echo "  puzzle2  - Puzzle 2"
	@echo "  puzzle3  - Puzzle 3"
	@echo "  puzzle4  - Puzzle 4"
	@echo ""
	@echo "$(YELLOW)Game Series (Multi-language with Joueur framework):$(NC)"
	@echo "  game1        - Game 1 (C++/C#/Java/Python)"
	@echo "  game2        - Game 2 (C++/C#/Java/Python)"
	@echo "  game3        - Game 3 (C++/C#/Java/Python)"
	@echo "  game4        - Game 4 (C++/C#/Java/Python)"
	@echo "  game4_makeup - Game 4 Makeup (C++/C#/Java/Python)"

# List available targets
list:
	@echo "$(CYAN)Available targets:$(NC)"
	@echo ""
	@echo "$(YELLOW)Puzzle Series:$(NC)"
	@for target in $(PUZZLE_TARGETS); do \
		echo "  $$target"; \
	done
	@echo ""
	@echo "$(YELLOW)Game Series:$(NC)"
	@for target in $(GAME_TARGETS); do \
		echo "  $$target"; \
	done

# ==============================================================================
# Build Targets
# ==============================================================================

.PHONY: build

build:
ifdef TARGET
	@$(MAKE) --no-print-directory build_$(TARGET)
else
	@echo "$(CYAN)Building all AI assignments...$(NC)"
	@for target in $(PUZZLE_TARGETS); do \
		$(MAKE) --no-print-directory build_$$target; \
	done
	@for target in $(GAME_TARGETS); do \
		$(MAKE) --no-print-directory build_$$target; \
	done
	@echo "$(GREEN)All assignments verified!$(NC)"
endif

# Puzzle builds (Python - verification only)
build_puzzle1:
	@echo "$(CYAN)Verifying puzzle1...$(NC)"
	@if [ -f "$(PUZZLE_DIR)/2018-sp-a-puzzle_1-isgx2/src/main.py" ]; then \
		count=$$(find $(PUZZLE_DIR)/2018-sp-a-puzzle_1-isgx2/src -name "*.py" | wc -l | tr -d ' '); \
		echo "$(GREEN)✓ puzzle1: $$count Python files$(NC)"; \
	else \
		echo "$(RED)Error: puzzle1 source not found$(NC)"; \
		exit 1; \
	fi

build_puzzle2:
	@echo "$(CYAN)Verifying puzzle2...$(NC)"
	@if [ -f "$(PUZZLE_DIR)/2018-sp-a-puzzle_2-isgx2/src/main.py" ]; then \
		count=$$(find $(PUZZLE_DIR)/2018-sp-a-puzzle_2-isgx2/src -name "*.py" | wc -l | tr -d ' '); \
		echo "$(GREEN)✓ puzzle2: $$count Python files$(NC)"; \
	else \
		echo "$(RED)Error: puzzle2 source not found$(NC)"; \
		exit 1; \
	fi

build_puzzle3:
	@echo "$(CYAN)Verifying puzzle3...$(NC)"
	@if [ -f "$(PUZZLE_DIR)/2018-sp-a-puzzle_3-isgx2/src/main.py" ]; then \
		count=$$(find $(PUZZLE_DIR)/2018-sp-a-puzzle_3-isgx2/src -name "*.py" | wc -l | tr -d ' '); \
		echo "$(GREEN)✓ puzzle3: $$count Python files$(NC)"; \
	else \
		echo "$(RED)Error: puzzle3 source not found$(NC)"; \
		exit 1; \
	fi

build_puzzle4:
	@echo "$(CYAN)Verifying puzzle4...$(NC)"
	@if [ -f "$(PUZZLE_DIR)/2018-sp-a-puzzle_4-isgx2/src/main.py" ]; then \
		count=$$(find $(PUZZLE_DIR)/2018-sp-a-puzzle_4-isgx2/src -name "*.py" | wc -l | tr -d ' '); \
		echo "$(GREEN)✓ puzzle4: $$count Python files$(NC)"; \
	else \
		echo "$(RED)Error: puzzle4 source not found$(NC)"; \
		exit 1; \
	fi

# Game builds (multi-language - verify Joueur.py exists)
build_game1:
	@echo "$(CYAN)Verifying game1...$(NC)"
	@if [ -d "$(GAME_DIR)/2018-sp-a-game-1-isgx2/Joueur.py" ]; then \
		langs=$$(ls -d $(GAME_DIR)/2018-sp-a-game-1-isgx2/Joueur.* 2>/dev/null | wc -l | tr -d ' '); \
		echo "$(GREEN)✓ game1: $$langs language implementations$(NC)"; \
	else \
		echo "$(RED)Error: game1 source not found$(NC)"; \
		exit 1; \
	fi

build_game2:
	@echo "$(CYAN)Verifying game2...$(NC)"
	@if [ -d "$(GAME_DIR)/2018-sp-a-game-2-isgx2/Joueur.py" ]; then \
		langs=$$(ls -d $(GAME_DIR)/2018-sp-a-game-2-isgx2/Joueur.* 2>/dev/null | wc -l | tr -d ' '); \
		echo "$(GREEN)✓ game2: $$langs language implementations$(NC)"; \
	else \
		echo "$(RED)Error: game2 source not found$(NC)"; \
		exit 1; \
	fi

build_game3:
	@echo "$(CYAN)Verifying game3...$(NC)"
	@if [ -d "$(GAME_DIR)/2018-sp-a-game-3-isgx2/Joueur.py" ]; then \
		langs=$$(ls -d $(GAME_DIR)/2018-sp-a-game-3-isgx2/Joueur.* 2>/dev/null | wc -l | tr -d ' '); \
		echo "$(GREEN)✓ game3: $$langs language implementations$(NC)"; \
	else \
		echo "$(RED)Error: game3 source not found$(NC)"; \
		exit 1; \
	fi

build_game4:
	@echo "$(CYAN)Verifying game4...$(NC)"
	@if [ -d "$(GAME_DIR)/2018-sp-a-game-4-isgx2/Joueur.py" ]; then \
		langs=$$(ls -d $(GAME_DIR)/2018-sp-a-game-4-isgx2/Joueur.* 2>/dev/null | wc -l | tr -d ' '); \
		echo "$(GREEN)✓ game4: $$langs language implementations$(NC)"; \
	else \
		echo "$(RED)Error: game4 source not found$(NC)"; \
		exit 1; \
	fi

build_game4_makeup:
	@echo "$(CYAN)Verifying game4_makeup...$(NC)"
	@if [ -d "$(GAME_DIR)/2018-sp-a-game-4-makeup-isgx2/Joueur.py" ]; then \
		langs=$$(ls -d $(GAME_DIR)/2018-sp-a-game-4-makeup-isgx2/Joueur.* 2>/dev/null | wc -l | tr -d ' '); \
		echo "$(GREEN)✓ game4_makeup: $$langs language implementations$(NC)"; \
	else \
		echo "$(RED)Error: game4_makeup source not found$(NC)"; \
		exit 1; \
	fi

# ==============================================================================
# Run Targets
# ==============================================================================

.PHONY: run autorun

run:
ifdef TARGET
	@if [ "$(TARGET)" = "puzzle1" ]; then \
		echo "$(CYAN)Puzzle 1 - Mechanical Match$(NC)"; \
		echo "$(YELLOW)Usage: python3 src/main.py <input_file>$(NC)"; \
		echo ""; \
		echo "$(YELLOW)Available inputs:$(NC)"; \
		ls -1 $(PUZZLE_DIR)/2018-sp-a-puzzle_1-isgx2/input/*.txt 2>/dev/null | xargs -I {} basename {} || echo "  (none)"; \
		echo ""; \
		echo "$(YELLOW)Run from: $(PUZZLE_DIR)/2018-sp-a-puzzle_1-isgx2$(NC)"; \
	elif [ "$(TARGET)" = "puzzle2" ]; then \
		echo "$(CYAN)Puzzle 2$(NC)"; \
		echo "$(YELLOW)Usage: python3 src/main.py <input_file>$(NC)"; \
		echo "$(YELLOW)Run from: $(PUZZLE_DIR)/2018-sp-a-puzzle_2-isgx2$(NC)"; \
	elif [ "$(TARGET)" = "puzzle3" ]; then \
		echo "$(CYAN)Puzzle 3$(NC)"; \
		echo "$(YELLOW)Usage: python3 src/main.py <input_file>$(NC)"; \
		echo "$(YELLOW)Run from: $(PUZZLE_DIR)/2018-sp-a-puzzle_3-isgx2$(NC)"; \
	elif [ "$(TARGET)" = "puzzle4" ]; then \
		echo "$(CYAN)Puzzle 4$(NC)"; \
		echo "$(YELLOW)Usage: python3 src/main.py <input_file>$(NC)"; \
		echo "$(YELLOW)Run from: $(PUZZLE_DIR)/2018-sp-a-puzzle_4-isgx2$(NC)"; \
	elif [ "$(TARGET)" = "game1" ]; then \
		echo "$(CYAN)Game 1$(NC)"; \
		echo "$(YELLOW)Available implementations:$(NC)"; \
		ls -d $(GAME_DIR)/2018-sp-a-game-1-isgx2/Joueur.* 2>/dev/null | xargs -I {} basename {} || echo "  (none)"; \
		echo ""; \
		echo "$(YELLOW)Run with: ./play.sh <game_server_args>$(NC)"; \
		echo "$(YELLOW)Run from: $(GAME_DIR)/2018-sp-a-game-1-isgx2$(NC)"; \
	elif [ "$(TARGET)" = "game2" ]; then \
		echo "$(CYAN)Game 2$(NC)"; \
		echo "$(YELLOW)Available implementations:$(NC)"; \
		ls -d $(GAME_DIR)/2018-sp-a-game-2-isgx2/Joueur.* 2>/dev/null | xargs -I {} basename {} || echo "  (none)"; \
		echo ""; \
		echo "$(YELLOW)Run from: $(GAME_DIR)/2018-sp-a-game-2-isgx2$(NC)"; \
	elif [ "$(TARGET)" = "game3" ]; then \
		echo "$(CYAN)Game 3$(NC)"; \
		echo "$(YELLOW)Available implementations:$(NC)"; \
		ls -d $(GAME_DIR)/2018-sp-a-game-3-isgx2/Joueur.* 2>/dev/null | xargs -I {} basename {} || echo "  (none)"; \
		echo ""; \
		echo "$(YELLOW)Run from: $(GAME_DIR)/2018-sp-a-game-3-isgx2$(NC)"; \
	elif [ "$(TARGET)" = "game4" ]; then \
		echo "$(CYAN)Game 4$(NC)"; \
		echo "$(YELLOW)Available implementations:$(NC)"; \
		ls -d $(GAME_DIR)/2018-sp-a-game-4-isgx2/Joueur.* 2>/dev/null | xargs -I {} basename {} || echo "  (none)"; \
		echo ""; \
		echo "$(YELLOW)Run from: $(GAME_DIR)/2018-sp-a-game-4-isgx2$(NC)"; \
	elif [ "$(TARGET)" = "game4_makeup" ]; then \
		echo "$(CYAN)Game 4 Makeup$(NC)"; \
		echo "$(YELLOW)Available implementations:$(NC)"; \
		ls -d $(GAME_DIR)/2018-sp-a-game-4-makeup-isgx2/Joueur.* 2>/dev/null | xargs -I {} basename {} || echo "  (none)"; \
		echo ""; \
		echo "$(YELLOW)Run from: $(GAME_DIR)/2018-sp-a-game-4-makeup-isgx2$(NC)"; \
	else \
		echo "$(RED)Error: Unknown target '$(TARGET)'$(NC)"; \
		exit 1; \
	fi
else
	@echo "$(YELLOW)Available targets:$(NC)"
	@echo ""
	@echo "$(CYAN)Puzzle Series:$(NC)"
	@for target in $(PUZZLE_TARGETS); do \
		echo "  $$target"; \
	done
	@echo ""
	@echo "$(CYAN)Game Series:$(NC)"
	@for target in $(GAME_TARGETS); do \
		echo "  $$target"; \
	done
	@echo ""
	@echo "$(YELLOW)Usage: make run TARGET=<target>$(NC)"
endif

autorun:
ifdef TARGET
	@if [ "$(TARGET)" = "puzzle1" ]; then \
		echo "$(CYAN)Running puzzle1 with sample input...$(NC)"; \
		cd $(PUZZLE_DIR)/2018-sp-a-puzzle_1-isgx2 && python3 src/main.py input/puzzle1.txt; \
	elif [ "$(TARGET)" = "puzzle2" ]; then \
		echo "$(CYAN)Running puzzle2...$(NC)"; \
		cd $(PUZZLE_DIR)/2018-sp-a-puzzle_2-isgx2 && $(MAKE) run; \
	elif [ "$(TARGET)" = "puzzle3" ]; then \
		echo "$(CYAN)Running puzzle3...$(NC)"; \
		cd $(PUZZLE_DIR)/2018-sp-a-puzzle_3-isgx2 && $(MAKE) run; \
	elif [ "$(TARGET)" = "puzzle4" ]; then \
		echo "$(CYAN)Running puzzle4...$(NC)"; \
		cd $(PUZZLE_DIR)/2018-sp-a-puzzle_4-isgx2 && $(MAKE) run; \
	else \
		echo "$(YELLOW)Game autorun requires a game server.$(NC)"; \
		$(MAKE) --no-print-directory run TARGET=$(TARGET); \
	fi
else
	@echo "$(YELLOW)Running puzzle1 sample...$(NC)"
	@$(MAKE) --no-print-directory autorun TARGET=puzzle1
endif

# ==============================================================================
# Test Targets
# ==============================================================================

.PHONY: test

test:
ifdef TARGET
	@if echo "$(PUZZLE_TARGETS)" | grep -qw "$(TARGET)"; then \
		puzzle_num=$$(echo $(TARGET) | sed 's/puzzle//'); \
		echo "$(CYAN)Running tests for $(TARGET)...$(NC)"; \
		cd $(PUZZLE_DIR)/2018-sp-a-puzzle_$${puzzle_num}-isgx2 && $(MAKE) test; \
	else \
		echo "$(YELLOW)Tests only available for puzzle series$(NC)"; \
	fi
else
	@echo "$(YELLOW)Running all puzzle tests...$(NC)"
	@for i in 1 2 3 4; do \
		echo "$(CYAN)Testing puzzle$$i...$(NC)"; \
		cd $(PUZZLE_DIR)/2018-sp-a-puzzle_$${i}-isgx2 && $(MAKE) test || true; \
		cd ../..; \
	done
endif

# ==============================================================================
# Clean Target
# ==============================================================================

clean:
	@echo "$(YELLOW)Cleaning all build artifacts...$(NC)"
	@for i in 1 2 3 4; do \
		if [ -d "$(PUZZLE_DIR)/2018-sp-a-puzzle_$${i}-isgx2" ]; then \
			echo "  Cleaning puzzle$$i..."; \
			cd $(PUZZLE_DIR)/2018-sp-a-puzzle_$${i}-isgx2 && $(MAKE) clean 2>/dev/null || true; \
			cd ../..; \
		fi; \
	done
	@for game in 1 2 3 4; do \
		if [ -d "$(GAME_DIR)/2018-sp-a-game-$${game}-isgx2/Joueur.cpp/build" ]; then \
			echo "  Cleaning game$$game C++ build..."; \
			rm -rf $(GAME_DIR)/2018-sp-a-game-$${game}-isgx2/Joueur.cpp/build; \
		fi; \
	done
	@if [ -d "$(GAME_DIR)/2018-sp-a-game-4-makeup-isgx2/Joueur.cpp/build" ]; then \
		echo "  Cleaning game4_makeup C++ build..."; \
		rm -rf $(GAME_DIR)/2018-sp-a-game-4-makeup-isgx2/Joueur.cpp/build; \
	fi
	@echo "$(GREEN)Clean complete.$(NC)"
