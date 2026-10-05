#!/bin/bash

echo ':: flutter pub get ::'
flutter pub get

echo ':: Flavor setup: Project name, properties BundleId & Application id ::'
dart run flutter_flavorizr
