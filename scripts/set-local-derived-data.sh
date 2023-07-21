#!/usr/bin/env bash

# This script sets the user-specific Derived Data location setting
# for the given Xcode project or workspace to be "project-relative"
# and next to the project or workspace.

source "$(dirname -- "$(readlink -f "${BASH_SOURCE[0]}")")/base.sh"

help() {
	echo "Usage: $0 <path/to/project[.xcodeproj | .xcworkspace]>"
}

main() {
	if [[ $# -ne 1 ]]; then
		help
		exit 1
	fi

	local -r project_file="$1"

	case "$project_file" in
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

	set_local_derived_data "$project_file"
}

set_local_derived_data() {
	# Absolute path to the `.xcodeproj` or `.xcworkspace` file
	local -r project_file=$1

	if [[ ! -d "$project_file" ]]; then
		echo "Error: $project_file does not exist or is not a directory"
		exit 1
	fi

	# Absolute path to the current user's `xcuserdatad` directory
	current_user=$(whoami)
	local -r current_user
	local xcuserdatad_dir
	if [[ "$project_file" == *".xcodeproj" ]]; then
		xcuserdatad_dir="${project_file}/project.xcworkspace/xcuserdata/${current_user}.xcuserdatad"
	elif [[ "$project_file" == *".xcworkspace" ]]; then
		xcuserdatad_dir="${project_file}/xcuserdata/${current_user}.xcuserdatad"
	fi

	# Create the `xcuserdatad` directory if it doesn't exist
	mkdir -p "$xcuserdatad_dir"

	local -r workspace_settings_plist_path="${xcuserdatad_dir}/WorkspaceSettings.xcsettings"

	# Create the `WorkspaceSettings.xcsettings` file if it doesn't exist
	if [[ ! -f "$workspace_settings_plist_path" ]]; then
		plutil -create xml1 "$workspace_settings_plist_path"
	fi

	# Set the Derived Data settings
	plutil -replace BuildLocationStyle -string UseAppPreferences "$workspace_settings_plist_path"
	plutil -replace CustomBuildLocationType -string RelativeToDerivedData "$workspace_settings_plist_path"
	plutil -replace DerivedDataCustomLocation -string DerivedData "$workspace_settings_plist_path"
	plutil -replace DerivedDataLocationStyle -string WorkspaceRelativePath "$workspace_settings_plist_path"

	# Validate the `WorkspaceSettings.xcsettings` file
	plutil -lint "$workspace_settings_plist_path"
}

main "$@"
