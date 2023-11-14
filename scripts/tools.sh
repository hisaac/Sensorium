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

if ! command -v xcodes &> /dev/null; then
	warn "This project uses xcodes (https://github.com/XcodesOrg/xcodes) for managing Xcode versions."
	warn "Please install it by running the following command:"
	warn ""
	warn "    brew install xcodes"
fi
