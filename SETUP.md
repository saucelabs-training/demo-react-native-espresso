# Prerequisite Setup

1. Install homebrew: https://brew.sh/
2. `brew install node`
3. `brew install watchman`
4. `npm install -g react-native-cli`
5. Install [JDK8](https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)
6. Install and configure [Android Studio](https://developer.android.com/studio/#downloads)
    * Choose a "Custom" setup when prompted to select an installation type. Make sure the boxes next to all of the following are checked:
      - Android SDK
      - Android SDK Platform
      - Performance (Intel ® HAXM)
      - Android Virtual Device
    * Open the SDK Manager (SDK Platforms section) and choose to install "Android 8.1 (Oreo)" - check the box that says "Show package details" and choose:
      - Android SDK platform 27
      - Google APIs Intel x86 Atom System Image
      - DO NOT CLICK 'APPLY' YET!
    * Also go to the SDK Manager's SDK Tools section - check the box that says "Show package details" and choose:
      - "27.0.3" under the Android SDK Build-Tools tree
      - Now click 'Apply' to pull down and install all the new dependencies
    * Add the following lines to your $HOME/.bash_profile config file:
```
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
```
7. Open `./sample-app-ios/android` as a project in Android Studio
8. Under the **Tools** menu, choose **AVD Manager**
9. Click the **Create Virtual Device** button
10. Choose a device definition (e.g. Pixel 2) and click **Next**
11. Choose **Oreo** with **API 27** and click **Next**
    > you may need to select **Download** beside **Oreo 27** to enable the **Next** button
12. Click **Finish** to create the emulated device
13. Launch the virtual device in the Android Emulator by clicking on the green triangle icon. 
14. Navigate to the root directory `demo-react-native-espresso`, open a shell and run: `react-native run-android`

> **WARNING**: if you don't manually launch the emulator, `run-android` returns:

```
FAILURE: Build failed with an exception.
    
* What went wrong:
Execution failed for task ':app:installDebug'.
    > com.android.builder.testing.api.DeviceException: No connected devices!

* Try:
Run with --stacktrace option to get the stack trace. Run with --info or --debug option to get more log output. Run with --scan to get full insights.

* Get more help at https://help.gradle.org

BUILD FAILED in 3m 35s
45 actionable tasks: 24 executed, 21 up-to-date
Could not install the app on the device, read the error above for details.
Make sure you have an Android emulator running or a device connected and have
set up your Android development environment:
https://facebook.github.io/react-native/docs/getting-started.html
```

<br />