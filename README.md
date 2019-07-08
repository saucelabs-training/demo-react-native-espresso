# React-Native Espresso Demo

[![CircleCI](https://circleci.com/gh/saucelabs-training/demo-react-native-espresso.svg?style=svg)](https://circleci.com/gh/saucelabs-training/demo-react-native-espresso)

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

Detailed installation instructions located [here](SETUP.md)
<br />

## Running the Demo
1. Clone [this repository]().
2. Open Android Studio and import as a **New Project** with  **`/android`** as the project directory
3. In the root directory (`demo-react-native-espresso`), run the following command:
```
$ cd ../
$ npm install
```
4. In Android Studio select **Build > Make Project** to build the application and install dependencies
5. Export your [Sauce Labs Credentials as Environment Variables](https://wiki.saucelabs.com/display/DOCS/Best+Practice%3A+Use+Environment+Variables+for+Authentication+Credentials)
6. In the `android` directory, run the following commands to build the relevant `.apk` files:
```
$ cd android/
$ ./gradlew assembleRelease
$ ./gradlew assembleAndroidTest
```
    > Make sure you've set **$JAVA_HOME** correctly, and that you're using JDK 8.
    > If you have multiple versions of Java, you may need to reset it with the following:
    ```
    $ export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
    ```
7. Navigate to the directory where you downloaded the Sauce Runner and create a `runner.sh` script:
    > In our example they exist in: **./android/app/build/outputs/apk**
    
    ```
    ./sauce-runner-virtual-0.1.1-osx/bin/sauce-runner-virtual \
   -u $SAUCE_USERNAME \
   -k $SAUCE_ACCESS_KEY \
   -f espresso \
   -a ./release/app-release.apk \
   -t ./androidTest/debug/app-debug-androidTest.apk \
   -d 'deviceName=Samsung Galaxy S8 HD GoogleAPI Emulator,platformVersion=8.0' \
   -d 'deviceName=Google Pixel GoogleAPI Emulator,platformVersion=8.1'
    ```
8. Run the following command(s):
    ```
    $ cd android/app/build/outputs/apk/ && ./runner.sh
    ```
    The console output should read like so:
```
2019-07-03 11:14:33 - [INFO] Using sauce-runner v0.1.1
2019-07-03 11:14:33 - [INFO] Selected framework: espresso
2019-07-03 11:14:33 - [INFO] Using user: $SAUCE_USERNAME
2019-07-03 11:14:33 - [INFO] Using apikey: $SAUCE_ACCESS_KEY
2019-07-03 11:14:33 - [INFO] Using local App: ./release/app-release.apk
2019-07-03 11:14:33 - [INFO] Using local Test App: ./androidTest/debug/app-debug-androidTest.apk
2019-07-03 11:14:33 - [INFO] No include-tests filters specified
2019-07-03 11:14:33 - [INFO] No exclude-tests filters specified
2019-07-03 11:14:33 - [INFO] Set device: Samsung Galaxy S8 HD GoogleAPI Emulator - 8.0
2019-07-03 11:14:33 - [INFO] Set device: Google Pixel GoogleAPI Emulator - 8.1
2019-07-03 11:14:33 - [INFO] Trying to upload file ./release/app-release.apk to sauce-storage
2019-07-03 11:14:35 - [INFO] File uploaded: app-release.apk($SAUCE_STORAGE_ID) - Size:10915077
2019-07-03 11:14:35 - [INFO] Trying to upload file ./androidTest/debug/app-debug-androidTest.apk to sauce-storage
2019-07-03 11:14:36 - [INFO] File uploaded: app-debug-androidTest.apk($SAUCE_STORAGE_ID) - Size:3205179
2019-07-03 11:14:36 - [INFO] JUnit reports will be saved locally at the end of the tests
2019-07-03 11:14:36 - [INFO] Jobs created
2019-07-03 11:14:36 - [INFO] Jobs created
2019-07-03 11:14:41 - [INFO] Getting job status
2019-07-03 11:14:41 - [INFO] Job status: In progress
2019-07-03 11:14:41 - [INFO] Samsung Galaxy S8 HD GoogleAPI Emulator - 8.0 - Status: test queued
2019-07-03 11:14:41 - [INFO] Google Pixel GoogleAPI Emulator - 8.1 - Status: test queued
2019-07-03 11:14:56 - [INFO] Getting job status
2019-07-03 11:14:57 - [INFO] Job status: In progress
2019-07-03 11:14:57 - [INFO] Samsung Galaxy S8 HD GoogleAPI Emulator - 8.0 - Status: test queued
2019-07-03 11:14:57 - [INFO] Google Pixel GoogleAPI Emulator - 8.1 - Status: test queued
2019-07-03 11:15:12 - [INFO] Getting job status
2019-07-03 11:15:12 - [INFO] Job status: In progress
2019-07-03 11:15:12 - [INFO] Samsung Galaxy S8 HD GoogleAPI Emulator - 8.0 - Status: test session in progress
2019-07-03 11:15:12 - [INFO] https://saucelabs.com/beta/tests/$JOB_ID/watch
2019-07-03 11:15:12 - [INFO] Google Pixel GoogleAPI Emulator - 8.1 - Status: test session in progress
2019-07-03 11:15:12 - [INFO] https://saucelabs.com/beta/tests/$JOB_ID/watch
2019-07-03 11:15:27 - [INFO] Getting job status
2019-07-03 11:15:27 - [INFO] Job status: Complete
2019-07-03 11:15:27 - [INFO] Samsung Galaxy S8 HD GoogleAPI Emulator - 8.0 - Status: test complete
2019-07-03 11:15:27 - [INFO] Google Pixel GoogleAPI Emulator - 8.1 - Status: test complete
2019-07-03 11:15:42 - [INFO] Tests results for Samsung Galaxy S8 HD GoogleAPI Emulator - 8.0
2019-07-03 11:15:42 - [INFO] com.swaglabsmobileapp.MainActivityTest.successfulLogin...pass
2019-07-03 11:15:42 - [INFO] Total time: 9.611
2019-07-03 11:15:42 - [INFO] Tests passed: 1
2019-07-03 11:15:42 - [INFO] Tests failed: 0
2019-07-03 11:15:42 - [INFO] Getting JUnit report for Samsung Galaxy S8 HD GoogleAPI Emulator - 8.0
2019-07-03 11:15:42 - [INFO] Tests results for Google Pixel GoogleAPI Emulator - 8.1
2019-07-03 11:15:42 - [INFO] com.swaglabsmobileapp.MainActivityTest.successfulLogin...pass
2019-07-03 11:15:42 - [INFO] Total time: 14.576
2019-07-03 11:15:42 - [INFO] Tests passed: 1
2019-07-03 11:15:42 - [INFO] Tests failed: 0
2019-07-03 11:15:42 - [INFO] Getting JUnit report for Google Pixel GoogleAPI Emulator - 8.1

    ```