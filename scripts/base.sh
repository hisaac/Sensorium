#!/usr/bin/env bash
#
# This file contains all our base settings, functions, and variables used by
# all our scripts. It should be sourced at the top of all our scripts.
#
# Make sure to source it like this to ensure that it works from any directory:
#
# source "$(dirname -- "$(dirname -- "$(readlink -f "${BASH_SOURCE[0]}")")")/base.sh"
#
# Note: This assumes that the script is located in a subdirectory of the `scripts` directory.
#       If it's not, you'll need to adjust the path accordingly.

set -o errexit  # Exit on error
set -o nounset  # Exit on unset variable
set -o pipefail # Exit on pipe failure

# Output extra debug logging if `TRACE` is set to `true`
# or if `ACTIONS_STEP_DEBUG` is set to `true` (GitHub Actions)
if [[ "${TRACE:-false}" == true || "${ACTIONS_STEP_DEBUG:-false}" == true ]]; then
	set -o xtrace # Trace the execution of the script (debug)
fi

# Setup pretty logging

# If `TERM` is set to `dumb`, set it to `xterm`
# This is needed for the `tput` commands to work on GitHub Actions runners
if [[ "${TERM}" == dumb ]]; then
	export TERM=xterm
fi

# Only do this if `XCODE_VERSION_ACTUAL` is not set, because if it is set, we're running in
# Xcode, and Xcode can't use `tput` for pretty logging
if [[ -z "${XCODE_VERSION_ACTUAL:-}" ]]; then
	TEXT_RED=$(tput setaf 1)
	TEXT_YELLOW=$(tput setaf 3)
	TEXT_BLUE=$(tput setaf 4)
	TEXT_BOLD=$(tput bold)
	TEXT_RESET=$(tput sgr0)
fi

info() {
	echo -e "${TEXT_BLUE:-}==>${TEXT_BOLD:-} $1" "${TEXT_RESET:-}"
}

warn() {
	echo -e "${TEXT_YELLOW:-}==>${TEXT_BOLD:-} $1" "${TEXT_RESET:-}"
}

err() {
	echo -e "${TEXT_RED:-}ERROR:${TEXT_BOLD:-} $1" "${TEXT_RESET:-}" >&2
}

# Setup variables

setup_global_variables() {
	# Absolute path to the directory containing this script
	local SCRIPT_CONTAINING_DIR
	SCRIPT_CONTAINING_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

	# Absolute path to the root directory of the project
	PROJECT_ROOT="$(cd "${SCRIPT_CONTAINING_DIR}/.." && pwd)"
	export PROJECT_ROOT

	# Absolute path to the directory containing the scripts
	SCRIPTS_DIR="${PROJECT_ROOT}/scripts"
	export SCRIPTS_DIR

	# Absolute path to the directory containing the artifacts
	ARTIFACTS_DIR="${PROJECT_ROOT}/artifacts"
	export ARTIFACTS_DIR

	# Absolute path to the directory containing the build
	BUILD_DIR="${PROJECT_ROOT}/build"
	export BUILD_DIR

	# Absolute path to the Xcode project file
	XCODE_PROJECT="${PROJECT_ROOT}/Sensorium.xcodeproj"
	export XCODE_PROJECT

	# Absolute path to the DerivedData directory
	DERIVED_DATA_DIR="${PROJECT_ROOT}/derivedData"
	export DERIVED_DATA_DIR

	# Absolute path to the directory containing the tools
	TOOLS_DIR="${PROJECT_ROOT}/tools"
	export TOOLS_DIR

	# Whether or not we're running in CI
	# Can be specified by the caller,
	# or we'll default to `true` if the
	# `GITHUB_ACTIONS` environment variable is set
	IS_CI="${CI:-${GITHUB_ACTIONS:-false}}"
	export IS_CI
}

main() {
	setup_global_variables
}

main "$@"
