#!/usr/bin/env bash

source "$(dirname -- "$(readlink -f "${BASH_SOURCE[0]}")")/base.sh"

"${SCRIPTS_DIR}/set-local-derived-data.sh" "${XCODE_PROJECT}"
