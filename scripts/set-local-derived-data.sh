#!/usr/bin/env bash

# This script sets the user-specific Derived Data location setting
# for the given Xcode project or workspace to be "project-relative"
# and next to the project or workspace.

set -o errexit  # Exit on error
set -o nounset  # Exit on unset variable
set -o pipefail # Exit on pipe failure

# Output extra debug logging if `TRACE` is set to `true`
if [[ "${TRACE:-false}" == true ]]; then
	set -o xtrace # Trace the execution of the script (debug)
fi

help() {
	echo "Usage: $0 <path/to/project[.xcodeproj | .xcworkspace]>"
}

main() {
	if [[ $# -ne 1 ]]; then
		help
		exit 1
	fi

	case "$1" in
	*.xcodeproj) ;;
	*.xcworkspace) ;;
	-h | --help)
		help
		exit 0
		;;
	*)
		help
		exit 1
		;;
	esac

	set_local_derived_data "$1"
}

set_local_derived_data() {
	# Absolute path to the `.xcodeproj` or `.xcworkspace` file
	local PROJECT_FILE=$1

	if [[ ! -d "$PROJECT_FILE" ]]; then
		echo "Error: $PROJECT_FILE does not exist or is not a directory"
		exit 1
	fi

	# Absolute path to the current user's `xcuserdatad` directory
	local XCUSERDATAD_DIR
	if [[ "$PROJECT_FILE" == *".xcodeproj" ]]; then
		XCUSERDATAD_DIR="${PROJECT_FILE}/project.xcworkspace/xcuserdata/$(whoami).xcuserdatad"
	elif [[ "$PROJECT_FILE" == *".xcworkspace" ]]; then
		XCUSERDATAD_DIR="${PROJECT_FILE}/xcuserdata/$(whoami).xcuserdatad"
	fi

	# Create the `xcuserdatad` directory if it doesn't exist
	mkdir -p "$XCUSERDATAD_DIR"

	WORKSPACE_SETTINGS_PLIST_PATH="${XCUSERDATAD_DIR}/WorkspaceSettings.xcsettings"

	# Create the `WorkspaceSettings.xcsettings` file if it doesn't exist
	if [[ ! -f "$WORKSPACE_SETTINGS_PLIST_PATH" ]]; then
		plutil -create xml1 "$WORKSPACE_SETTINGS_PLIST_PATH"
	fi

	# Set the Derived Data settings
	plutil -replace BuildLocationStyle -string UseAppPreferences "$WORKSPACE_SETTINGS_PLIST_PATH"
	plutil -replace CustomBuildLocationType -string RelativeToDerivedData "$WORKSPACE_SETTINGS_PLIST_PATH"
	plutil -replace DerivedDataCustomLocation -string DerivedData "$WORKSPACE_SETTINGS_PLIST_PATH"
	plutil -replace DerivedDataLocationStyle -string WorkspaceRelativePath "$WORKSPACE_SETTINGS_PLIST_PATH"

	# Validate the `WorkspaceSettings.xcsettings` file
	plutil -lint "$WORKSPACE_SETTINGS_PLIST_PATH"
}

main "$@"
