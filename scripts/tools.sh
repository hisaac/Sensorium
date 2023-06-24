#!/usr/bin/env bash

source "$(dirname -- "$(readlink -f "${BASH_SOURCE[0]}")")/base.sh"

info "Setting up tools..."

# Checking for just
if ! command -v just &> /dev/null; then
	warn "This project uses just (https://just.systems) for running commands."
	warn "Please install it by running the following command:"
	warn ""
	warn "    brew install just"
	warn ""
	warn "For more information and other installation options, see https://just.systems/man/en/chapter_4.html"
fi

# Install Tuist
if ! command -v tuist &> /dev/null; then
	info "Installing Tuist..."
	curl -Ls https://install.tuist.io | bash
fi
