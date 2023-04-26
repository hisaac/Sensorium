#!/usr/bin/env bash

source "$(dirname -- "$(readlink -f "${BASH_SOURCE[0]}")")/base.sh"

XCUSERDATAD_DIR=$(find "${XCODE_PROJECT}/project.xcworkspace/xcuserdata" -type d -name "*.xcuserdatad")
if [[ -z "${XCUSERDATAD_DIR}" ]]; then
	err "Could not find xcuserdatad directory"
	exit 1
fi

cp "${SCRIPTS_DIR}/WorkspaceSettings.xcsettings" "${XCUSERDATAD_DIR}"
