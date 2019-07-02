# React-Native Espresso Examples

The demo present in [this repository]() allows you to run automated Espresso tests (using Sauce Runner) in order to validate your Android Native Test Framework Environment, as well as your [saucelabs.com](www.saucelabs.com) account credentials

<p align="center">
<img src="assets/android-overview.gif"/>
</p>

> **For Demonstration Purposes Only**

> The code in these scripts is provided on an "AS-IS" basis without warranty of any kind, either express or implied, including without limitation any implied warranties of condition, uninterrupted use, merchantability, fitness for a particular purpose, or non-infringement. These scripts are provided for educational and demonstration purposes only, and should not be used in production. Issues regarding these scripts should be submitted through GitHub. These scripts are maintained by the Technical Services team at Sauce Labs.
 
<br />

## Prerequisites
In order to complete this exercise you must have the following installed on your machine:

* [Android Studio/SDK v3.3+](https://developer.android.com/studio)
* [JDK v1.8+](https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)
* [Gradle v5.1+](https://gradle.org/releases/)
* [Sauce Runner v0.1.1+](https://wiki.saucelabs.com/display/DOCS/Installing+Sauce+Runner+for+Virtual+Devices)
* [Watchman](https://facebook.github.io/watchman/docs/install.html)
* [NodeJS:](https://nodejs.org/en/download/)
    * [React-Native-CLI v2.0.1](https://www.npmjs.com/package/react-native-cli)
    * [React-Native v0.57.4](https://www.npmjs.com/package/react-native)

<br />

## Project Setup
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

## Bundling a React-Native App
**...or more specifically, how to bundle a `reactive-native` android app to run on Sauce Labs virtual devices and emulators**. 

In addition to mobile application testing on [Virtual Devices](https://wiki.saucelabs.com/display/DOCS/Automated+Mobile+App+Testing+on+Virtual+Devices+with+Sauce+Labs) with Appium, Sauce Labs also offers the ability to run tests with native frameworks such as:
* Espresso (Android)
* XCUITest (iOS)

Which allows you to build apps in Java/Swift and acheive app > test synchronization.

However, if you build your application with **`react-native`**, you must configure your Espresso test framework a bit differently. Furthermore, in order to test on Sauce Labs Virtual Devices, you must bundle your application in a specific way.

<br />

## Running the Demo
1. Clone [this repository]().
2. Open Android Studio and import as a **New Project** with  **`/android`** as the root-level project directory
2. Run the following command from the `./android/app` directory:
    ```
    keytool -genkey -v -keystore sLSwagLab.keystore -alias sLSwagLab -keyalg RSA -keysize 2048 -validity 10000
    ```
    Set the password as:
    ```
    sl.swag.lab
    ```
    > You can also view these details in `gradle.properties`
    
3. Ensure you've set the following in `build.gradle.signingConfigs.release`:
    ```
    if (project.hasProperty('MYAPP_RELEASE_STORE_FILE')) {
        storeFile file(MYAPP_RELEASE_STORE_FILE)
        storePassword MYAPP_RELEASE_STORE_PASSWORD
        keyAlias MYAPP_RELEASE_KEY_ALIAS
        keyPassword MYAPP_RELEASE_KEY_PASSWORD
    }
    ```
4. Ensure you've set the following in `build.gradle.buildTypes.release`:
    ```
    signingConfig signingConfigs.release
    ```
5. Export your [Sauce Labs Credentials as Environment Variables](https://wiki.saucelabs.com/display/DOCS/Best+Practice%3A+Use+Environment+Variables+for+Authentication+Credentials)
6. Navigate to the directory where you downloaded the Sauce Runner and create a `runner.sh` script:
    > In our example they exist in: **./android/app/build/outputs/apk**
    
    ```
    ./sauce-runner-virtual-0.1.1-osx/bin/sauce-runner-virtual \
   -u $SAUCE_USERNAME \
   -k $SAUCE_ACCESS_KEY \
   -f espresso \
   -a <your android-release.apk location> \
   -t <your androidTest-debug.apk location> \
   -d 'deviceName=Samsung Galaxy S8 HD GoogleAPI Emulator,platformVersion=7.0' \
   -d 'deviceName=Google Pixel GoogleAPI Emulator,platformVersion=7.1'
    ```
7. Run the following command:
    ```
    ./runner.sh
    ```