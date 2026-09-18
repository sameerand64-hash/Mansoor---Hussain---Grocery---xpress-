# Grocery Express — Android build

This package contains the Grocery Express Flutter source and Firebase Android configuration.

## On a Windows PC
1. Install Flutter SDK and Android Studio.
2. Open this folder in Android Studio/Terminal.
3. Run `SETUP_ANDROID.bat`.
4. When setup finishes, run `flutter build apk --release`.
5. APK will be generated under `build\app\outputs\flutter-apk\app-release.apk`.

## Important
- The Firebase Android config is already included at `android/app/google-services.json`.
- The Firebase project/package configuration in this file is for `com.mansoorhussain.groceryexpress`.
- This package does not include a compiled APK because Flutter SDK/Android build tools are not available in the current environment.
- Firebase services that require console-side configuration (Auth providers, Firestore rules/data, Storage, notifications) still need to be configured in Firebase.
