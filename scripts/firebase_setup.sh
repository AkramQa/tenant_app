#!/bin/bash
error () {
  echo -e "\033[0;31m$1"
  exit 1
}

curl -sL https://firebase.tools | bash

firebase login

dart pub global activate flutterfire_cli 0.3.0-dev.16 --overwrite || error "can't install flutterfire_cli.."

export PATH="$PATH":"$HOME/.pub-cache/bin"

# TODO(SETUP): change firebase project name
DEV_FIREBASE_PROJECT_NAME="TODO"
STG_FIREBASE_PROJECT_NAME="TODO"
PROD_FIREBASE_PROJECT_NAME="TODO"

# TODO(SETUP): change android ,ios ids
DEV_IOS_BUNDLE_ID="com.tenantapp.tenantApp.dev"
STG_IOS_BUNDLE_ID="com.tenantapp.tenantApp.stg"
PROD_IOS_BUNDLE_ID="com.tenantapp.tenantApp"

DEV_ANDROID_PACKAGE_NAME="com.tenantapp.tenant_app.dev"
STG_ANDROID_PACKAGE_NAME="com.tenantapp.tenant_app.stg"
PROD_ANDROID_PACKAGE_NAME="com.tenantapp.tenant_app"

for ENV in dev stg prod
do
  IOS_BUNDLE_ID=""
  ANDROID_PACKAGE_NAME=""
  FIREBASE_PROJECT_NAME=""

  DART_OUT="lib/core/utils/firebase_generated/firebase_options_$ENV.dart"
  ANDROID_OUT="/android/app/src/$ENV/google-services.json"
  IOS_OUT="/ios/firebase/$ENV/GoogleService-Info.plist"

  case $ENV in
    dev)
    IOS_BUNDLE_ID=$DEV_IOS_BUNDLE_ID
    ANDROID_PACKAGE_NAME=$DEV_ANDROID_PACKAGE_NAME
    FIREBASE_PROJECT_NAME=$DEV_FIREBASE_PROJECT_NAME
    ;;

    stg)
    IOS_BUNDLE_ID=$STG_IOS_BUNDLE_ID
    ANDROID_PACKAGE_NAME=$STG_ANDROID_PACKAGE_NAME
    FIREBASE_PROJECT_NAME=$STG_FIREBASE_PROJECT_NAME
    ;;

    prod)
    IOS_BUNDLE_ID=$PROD_IOS_BUNDLE_ID
    ANDROID_PACKAGE_NAME=$PROD_ANDROID_PACKAGE_NAME
    FIREBASE_PROJECT_NAME=$PROD_FIREBASE_PROJECT_NAME
    ;;
  esac

  for PREFIX in "Debug" "Release" "Profile"; do
    flutterfire configure \
    --project=$FIREBASE_PROJECT_NAME \
    --platforms=android,ios \
    --out=$DART_OUT \
    --ios-bundle-id=$IOS_BUNDLE_ID \
    --android-package-name=$ANDROID_PACKAGE_NAME \
    --android-out=$ANDROID_OUT \
    --ios-out=$IOS_OUT \
    --debug-symbols-ios \
    --ios-build-config="$PREFIX"-"$ENV" \
    --overwrite-firebase-options \
    --yes || error "flutterfire config error"
  done

done




