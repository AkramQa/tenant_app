#!/bin/bash
echo ':: flutter clean ::'
flutter clean

echo ':: flutter pub get ::'
flutter pub get

./scripts/generate.sh
