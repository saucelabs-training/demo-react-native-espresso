# React-Native Espresso Examples

The demo present in [this repository]() allows you to run automated Espresso tests (using Sauce Runner) in order to validate your Android Native Test Framework Environment, as well as your [saucelabs.com](www.saucelabs.com) account credentials

> **For Demonstration Purposes Only**

> The code in these scripts is provided on an "AS-IS" basis without warranty of any kind, either express or implied, including without limitation any implied warranties of condition, uninterrupted use, merchantability, fitness for a particular purpose, or non-infringement. These scripts are provided for educational and demonstration purposes only, and should not be used in production. Issues regarding these scripts should be submitted through GitHub. These scripts are maintained by the Technical Services team at Sauce Labs.

<br />

## Prerequisites
Detailed installation instructions located [here](https://github.com/saucelabs/sample-app-mobile#sample-app-android).

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