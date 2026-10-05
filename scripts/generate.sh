#!/bin/bash
# ./scripts/generate_localizations.sh

echo ':: dart run build_runner build --delete-conflicting-outputs ::'
dart run build_runner build --delete-conflicting-outputs
