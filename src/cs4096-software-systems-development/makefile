# CS4096 Software Systems Development - Build System
# This is the "Splatoonio" capstone project - a multiplayer mobile game
# with a Python backend server and Android frontend app.
#
# Available targets:
#   make build              - Verify all project files exist
#   make build TARGET=X     - Verify specific target
#   make run TARGET=X       - Run specific target (server requires PostgreSQL)
#   make autorun TARGET=X   - Same as run (no input files for this project)
#   make list               - List available targets
#   make clean              - Remove Python cache files
#   make help               - Display this help message
#
# Note: The server requires PostgreSQL database to be running.
# Note: The Android app requires Android SDK and Gradle to build.

# ==============================================================================
# Configuration
# ==============================================================================

# Color output for better readability
RED = \033[0;31m
GREEN = \033[0;32m
YELLOW = \033[1;33m
CYAN = \033[1;36m
NC = \033[0m

# Available targets
TARGETS = server android

# ==============================================================================
# Main Targets
# ==============================================================================

.PHONY: all help build run autorun list clean

# Default target
all: help

# Help target - displays available commands
help:
	@echo "$(CYAN)CS4096 Software Systems Development - Build System$(NC)"
	@echo "$(YELLOW)Project: Splatoonio (Multiplayer Mobile Game)$(NC)"
	@echo ""
	@echo "$(YELLOW)Usage:$(NC)"
	@echo "  make build              - Verify all project files exist"
	@echo "  make build TARGET=X     - Verify specific target"
	@echo "  make run TARGET=X       - Run specific target"
	@echo "  make autorun TARGET=X   - Same as run"
	@echo "  make list               - List available targets"
	@echo "  make clean              - Remove Python cache files"
	@echo ""
	@echo "$(YELLOW)Available Targets:$(NC)"
	@echo "  server   - Python Falcon/Gunicorn backend (requires PostgreSQL)"
	@echo "  android  - Kotlin Android app (requires Android SDK + Gradle)"
	@echo ""
	@echo "$(YELLOW)Notes:$(NC)"
	@echo "  - Server requires PostgreSQL database to run"
	@echo "  - Android app requires Android SDK and Gradle"

# List available targets
list:
	@echo "$(CYAN)Available targets:$(NC)"
	@echo "  server   - Python Falcon/Gunicorn backend"
	@echo "  android  - Kotlin Android app"

# ==============================================================================
# Build Targets (Verification - interpreted languages)
# ==============================================================================

.PHONY: build build_server build_android

build:
ifdef TARGET
	@$(MAKE) --no-print-directory build_$(TARGET)
else
	@echo "$(CYAN)Verifying all project files...$(NC)"
	@$(MAKE) --no-print-directory build_server
	@$(MAKE) --no-print-directory build_android
	@echo "$(GREEN)All project files verified!$(NC)"
endif

# Server - Python Falcon backend
build_server:
	@echo "$(CYAN)Verifying server (Python Falcon)...$(NC)"
	@if [ -f "splatoonio/server/src/app/app.py" ]; then \
		echo "$(GREEN)✓ server: app.py$(NC)"; \
	else \
		echo "$(RED)Error: splatoonio/server/src/app/app.py not found$(NC)"; \
		exit 1; \
	fi
	@if [ -f "splatoonio/server/src/app/routes.py" ]; then \
		echo "$(GREEN)✓ server: routes.py$(NC)"; \
	else \
		echo "$(RED)Error: splatoonio/server/src/app/routes.py not found$(NC)"; \
		exit 1; \
	fi
	@if [ -f "splatoonio/server/requirements.txt" ]; then \
		echo "$(GREEN)✓ server: requirements.txt$(NC)"; \
	else \
		echo "$(RED)Error: splatoonio/server/requirements.txt not found$(NC)"; \
		exit 1; \
	fi
	@echo "$(GREEN)✓ Server files verified$(NC)"

# Android - Kotlin/Gradle app
build_android:
	@echo "$(CYAN)Verifying Android app (Kotlin)...$(NC)"
	@if [ -f "splatoonio/android/build.gradle" ]; then \
		echo "$(GREEN)✓ android: build.gradle$(NC)"; \
	else \
		echo "$(RED)Error: splatoonio/android/build.gradle not found$(NC)"; \
		exit 1; \
	fi
	@if [ -f "splatoonio/android/app/src/main/java/com/example/splatoonio/splatoonio/LoginActivity.kt" ]; then \
		echo "$(GREEN)✓ android: LoginActivity.kt$(NC)"; \
	else \
		echo "$(RED)Error: Android source files not found$(NC)"; \
		exit 1; \
	fi
	@echo "$(GREEN)✓ Android files verified$(NC)"
	@echo "$(YELLOW)Note: Build with: cd splatoonio/android && ./gradlew build$(NC)"

# ==============================================================================
# Run Targets
# ==============================================================================

.PHONY: run autorun

run:
ifdef TARGET
	@if [ "$(TARGET)" = "server" ]; then \
		echo "$(CYAN)Running Splatoonio Server...$(NC)"; \
		echo "$(YELLOW)Prerequisites:$(NC)"; \
		echo "  1. PostgreSQL must be running"; \
		echo "  2. Database 'warpaint' must exist"; \
		echo "  3. pip install -r splatoonio/server/requirements.txt"; \
		echo ""; \
		echo "$(YELLOW)To run manually:$(NC)"; \
		echo "  cd splatoonio/server && bash run.sh localhost"; \
		echo ""; \
		if command -v gunicorn > /dev/null 2>&1; then \
			echo "$(CYAN)Starting server on localhost:8000...$(NC)"; \
			cd splatoonio/server && gunicorn --bind "localhost:8000" src.app.app:app; \
		else \
			echo "$(RED)gunicorn not found. Install with: pip install gunicorn$(NC)"; \
		fi \
	elif [ "$(TARGET)" = "android" ]; then \
		echo "$(CYAN)Android Build Instructions:$(NC)"; \
		echo "$(YELLOW)Prerequisites:$(NC)"; \
		echo "  1. Android SDK installed"; \
		echo "  2. ANDROID_HOME environment variable set"; \
		echo "  3. Gradle or Gradle wrapper"; \
		echo ""; \
		echo "$(YELLOW)To build:$(NC)"; \
		echo "  cd splatoonio/android && ./gradlew build"; \
		echo ""; \
		echo "$(YELLOW)To install on device:$(NC)"; \
		echo "  cd splatoonio/android && ./gradlew installDebug"; \
	else \
		echo "$(RED)Error: Unknown target '$(TARGET)'$(NC)"; \
		exit 1; \
	fi
else
	@echo "$(YELLOW)Available targets:$(NC)"
	@for target in $(TARGETS); do \
		echo "  $$target"; \
	done
	@echo ""
	@echo "$(YELLOW)Usage: make run TARGET=<target>$(NC)"
endif

# Autorun - same as run for this project
autorun:
ifdef TARGET
	@$(MAKE) --no-print-directory run TARGET=$(TARGET)
else
	@echo "$(YELLOW)Splatoonio Project:$(NC)"
	@echo "This is a client-server application."
	@echo "Use 'make run TARGET=server' for server instructions."
	@echo "Use 'make run TARGET=android' for Android build instructions."
endif

# ==============================================================================
# Clean Target
# ==============================================================================

clean:
	@echo "$(YELLOW)Cleaning Python cache files...$(NC)"
	@find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	@find . -type f -name "*.pyc" -delete 2>/dev/null || true
	@echo "$(GREEN)Clean complete.$(NC)"
	@echo "$(YELLOW)Note: To clean Android build, run: cd splatoonio/android && ./gradlew clean$(NC)"
