# CS3100 Software Engineering I - Build System
# This course contains the "Camelot" team project - a Python chat server/client.
# Python projects don't require compilation.
#
# Available targets:
#   make build              - Verify Python files exist (no compilation needed)
#   make run TARGET=X       - Run server or client
#   make list               - List available targets
#   make clean              - Remove Python cache files
#   make help               - Display this help message
#
# Note: This is a network server/client application.
#       Run the server first, then connect with clients.

# ==============================================================================
# Configuration
# ==============================================================================

# Directories
PROJECT_DIR = camelot/database

# Color output for better readability
RED = \033[0;31m
GREEN = \033[0;32m
YELLOW = \033[1;33m
CYAN = \033[1;36m
NC = \033[0m

# Available run targets
TARGETS = server client

# ==============================================================================
# Main Targets
# ==============================================================================

.PHONY: all help build run autorun list clean

# Default target
all: help

# Help target - displays available commands
help:
	@echo "$(CYAN)CS3100 Software Engineering I - Build System$(NC)"
	@echo "$(CYAN)Project: Camelot (Chat Server/Client)$(NC)"
	@echo ""
	@echo "$(YELLOW)Usage:$(NC)"
	@echo "  make build              - Verify Python files (no compilation needed)"
	@echo "  make run TARGET=server  - Start the chat server"
	@echo "  make run TARGET=client  - Start a chat client"
	@echo "  make list               - List available targets"
	@echo "  make clean              - Remove Python cache files"
	@echo ""
	@echo "$(YELLOW)Available Targets:$(NC)"
	@echo "  server  - Camelot chat server (run first)"
	@echo "  client  - Camelot chat client (connect to server)"
	@echo ""
	@echo "$(YELLOW)Note:$(NC) Start the server before connecting clients."

# List available targets
list:
	@echo "$(CYAN)Available targets:$(NC)"
	@echo "  server  - Camelot chat server"
	@echo "  client  - Camelot chat client"

# ==============================================================================
# Build Target (Python - no compilation needed)
# ==============================================================================

.PHONY: build

build:
	@echo "$(CYAN)CS3100 Software Engineering I: Camelot Project$(NC)"
	@echo "$(YELLOW)Python project - no compilation needed$(NC)"
	@echo "Verifying Python files exist..."
	@if [ -f "$(PROJECT_DIR)/camelot_server.py" ] && [ -f "$(PROJECT_DIR)/camelot_client.py" ]; then \
		echo "$(GREEN)✓ Server: $(PROJECT_DIR)/camelot_server.py$(NC)"; \
		echo "$(GREEN)✓ Client: $(PROJECT_DIR)/camelot_client.py$(NC)"; \
		echo "$(GREEN)✓ All project files verified$(NC)"; \
	else \
		echo "$(RED)Error: Project files not found$(NC)"; \
		exit 1; \
	fi

# ==============================================================================
# Run Targets
# ==============================================================================

.PHONY: run autorun

run:
ifdef TARGET
	@if [ "$(TARGET)" = "server" ]; then \
		echo "$(CYAN)Starting Camelot server...$(NC)"; \
		echo "$(YELLOW)Press Ctrl+C to stop the server$(NC)"; \
		cd "$(PROJECT_DIR)" && python3 camelot_server.py; \
	elif [ "$(TARGET)" = "client" ]; then \
		echo "$(CYAN)Starting Camelot client...$(NC)"; \
		cd "$(PROJECT_DIR)" && python3 camelot_client.py; \
	else \
		echo "$(RED)Error: Unknown target '$(TARGET)'$(NC)"; \
		echo "Available targets: server, client"; \
		exit 1; \
	fi
else
	@echo "$(YELLOW)Available targets:$(NC)"
	@echo "  server  - Start the chat server"
	@echo "  client  - Start a chat client"
	@echo ""
	@echo "$(YELLOW)Usage: make run TARGET=<target>$(NC)"
	@echo "$(YELLOW)Note:$(NC) Start the server before connecting clients."
endif

# Autorun - not applicable for network server/client
autorun:
	@echo "$(YELLOW)CS3100 Camelot: Autorun not applicable$(NC)"
	@echo "This is a network server/client application."
	@echo "Use 'make run TARGET=server' to start the server."
	@echo "Use 'make run TARGET=client' to start a client."

# ==============================================================================
# Clean Target
# ==============================================================================

clean:
	@echo "$(YELLOW)Cleaning Python cache files...$(NC)"
	@find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	@find . -type f -name "*.pyc" -delete 2>/dev/null || true
	@find . -type f -name "*.pyo" -delete 2>/dev/null || true
	@echo "$(GREEN)Clean complete.$(NC)"
