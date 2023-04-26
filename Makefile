# Prints help text for the Makefile
# Any target that has a comment next to it with 2 #'s will be printed in the help text
help: ## Show this help
	@echo "\nSpecify a command. The choices are:\n"
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[0;36m%-12s\033[m %s\n", $$1, $$2}'
.PHONY: help

# Grabs the current directory and the path to this file for use in other scripts
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
mkfile_dir := $(dir $(mkfile_path))
project_root_dir := $(mkfile_dir)
scripts_dir := $(project_root_dir)scripts/


### Setup ###

.PHONY: up
up:
	@echo "Setting up project"
	@./scripts/setup.sh


### Development ###

.PHONY: dev
dev:
	@echo "Not currently implemented"

.PHONY: build
build:
	@echo "Not currently implemented"


### Utility ###

.PHONY: reset
reset: clean

.PHONY: clean
clean: ## Cleans local caches
	@echo
	@echo "🧹 Cleaning…"
	rm -rf DerivedData

.PHONY: clobber
clobber:
	@echo
	@echo "🔨 Clobbering…"
	@echo "Not currently implemented"

.PHONY: nuke
nuke: clean clobber ## Nukes local and global caches
	@echo
	@echo "☢️  Nuking…"
	rm -rf $$HOME/Library/Developer/Xcode/DerivedData
	rm -rf $$HOME/Library/Caches/org.swift.swiftpm
	rm -rf $$HOME/Library/org.swift.swiftpm
	@echo
	@echo "🔥🔥🔥"
