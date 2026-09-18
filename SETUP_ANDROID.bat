@echo off
setlocal
where flutter >nul 2>nul
if errorlevel 1 (
  echo Flutter is not installed or not in PATH.
  echo Install Flutter SDK, then run this file again.
  pause
  exit /b 1
)
echo Creating/repairing the Flutter Android project...
flutter create .
if errorlevel 1 exit /b 1
if not exist android\app\google-services.json (
  echo ERROR: google-services.json is missing from android\app\
  exit /b 1
)
echo Getting packages...
flutter pub get
if errorlevel 1 exit /b 1
echo.
echo Setup complete. To build APK, run:
echo flutter build apk --release
pause
