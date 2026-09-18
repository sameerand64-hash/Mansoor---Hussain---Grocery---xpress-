#!/bin/sh
set -e
command -v flutter >/dev/null 2>&1 || { echo 'Flutter is not installed or not in PATH.'; exit 1; }
flutter create .
[ -f android/app/google-services.json ] || { echo 'ERROR: android/app/google-services.json is missing.'; exit 1; }
flutter pub get
echo 'Setup complete. Build with: flutter build apk --release'
