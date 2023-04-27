#!/usr/bin/env bash

set -o errexit  # Exit on error
set -o nounset  # Exit on unset variable
set -o pipefail # Exit on pipe failure

# Output extra debug logging if `TRACE` is set to `true`
if [[ "${TRACE:-false}" == true ]]; then
	set -o xtrace # Trace the execution of the script (debug)
fi

# Absolute path to the Xcode project file
# TODO: Add support for .xcworkspace
XCODEPROJ=$1

XCUSERDATA_DIR="${XCODEPROJ}/project.xcworkspace/xcuserdata/$(whoami).xcuserdatad"
mkdir -p "$XCUSERDATA_DIR"

WORKSPACE_SETTINGS_PLIST_PATH="${XCUSERDATA_DIR}/WorkspaceSettings.xcsettings"
if [[ ! -f "$WORKSPACE_SETTINGS_PLIST_PATH" ]]; then
	plutil -create xml1 "$WORKSPACE_SETTINGS_PLIST_PATH"
fi

plutil -replace BuildLocationStyle -string UseAppPreferences "$WORKSPACE_SETTINGS_PLIST_PATH"
plutil -replace CustomBuildLocationType -string RelativeToDerivedData "$WORKSPACE_SETTINGS_PLIST_PATH"
plutil -replace DerivedDataCustomLocation -string DerivedData "$WORKSPACE_SETTINGS_PLIST_PATH"
plutil -replace DerivedDataLocationStyle -string WorkspaceRelativePath "$WORKSPACE_SETTINGS_PLIST_PATH"

plutil -lint "$WORKSPACE_SETTINGS_PLIST_PATH"
