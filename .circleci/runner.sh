#!/bin/bash
	./sauce-runner-virtual-0.1.1-linux/bin/sauce-runner-virtual \
   -u "$SAUCE_USERNAME" \
   -k "$SAUCE_ACCESS_KEY" \
   -f espresso \
   -a ./app-release.apk \
   -t ./app-debug-androidTest.apk \
   -d 'deviceName=Samsung Galaxy S8 HD GoogleAPI Emulator,platformVersion=8.0' \
   -d 'deviceName=Google Pixel GoogleAPI Emulator,platformVersion=8.1'
