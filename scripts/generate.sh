#!/usr/bin/env bash
# Regenerates all generated code: localization (intl_utils) + freezed,
# json_serializable, auto_route and reactive_forms (build_runner).
set -euo pipefail
cd "$(dirname "$0")/.."

flutter pub get
dart run intl_utils:generate
dart run build_runner build --delete-conflicting-outputs
