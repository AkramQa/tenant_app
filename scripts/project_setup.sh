#!/usr/bin/env bash
# First-time setup: creates the iOS/Android host projects, applies the
# platform configuration the app needs, then generates code.
set -euo pipefail
cd "$(dirname "$0")/.."

if [ ! -d ios ] || [ ! -d android ]; then
  echo "▶ Creating iOS & Android platform folders"
  flutter create . --platforms=ios,android --org com.tenantapp --project-name tenant_app
  # `flutter create` adds a counter-app smoke test that doesn't apply here.
  rm -f test/widget_test.dart
fi

# ---------- iOS: camera/photo permissions + Arabic localization ----------
PLIST="ios/Runner/Info.plist"
if [ -x /usr/libexec/PlistBuddy ]; then
  echo "▶ Configuring $PLIST"
  pb() { /usr/libexec/PlistBuddy -c "$1" "$PLIST" >/dev/null 2>&1 || true; }
  pb "Add :NSCameraUsageDescription string Take a photo of the issue to attach it to your service request."
  pb "Add :NSPhotoLibraryUsageDescription string Choose a photo of the issue to attach it to your service request."
  pb "Add :CFBundleLocalizations array"
  pb "Add :CFBundleLocalizations:0 string en"
  pb "Add :CFBundleLocalizations:1 string ar"
else
  echo "⚠ PlistBuddy not found (not macOS). Add NSCameraUsageDescription and NSPhotoLibraryUsageDescription to $PLIST manually."
fi

# ---------- Android: INTERNET permission (release builds) + minSdk ----------
MANIFEST="android/app/src/main/AndroidManifest.xml"
if ! grep -q "android.permission.INTERNET" "$MANIFEST"; then
  echo "▶ Adding INTERNET permission to $MANIFEST"
  perl -0pi -e 's#<application#<uses-permission android:name="android.permission.INTERNET" />\n    <application#' "$MANIFEST"
fi

for GRADLE in android/app/build.gradle.kts android/app/build.gradle; do
  if [ -f "$GRADLE" ]; then
    echo "▶ Setting minSdk 24 in $GRADLE (required by flutter_secure_storage)"
    perl -pi -e 's/minSdk\s*=\s*flutter\.minSdkVersion/minSdk = 24/; s/minSdkVersion\s+flutter\.minSdkVersion/minSdkVersion 24/' "$GRADLE"
  fi
done

./scripts/generate.sh
echo "✅ Done. Run: flutter run"
