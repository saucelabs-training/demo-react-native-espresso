FROM openjdk:8-jdk-slim
LABEL maintainer="spider@saucelabs.com"
ENV DEBIAN_FRONTEND=noninteractive
COPY . /home/

# Install  apt- utilities
#-------------------------------------------------------------
RUN apt-get update -qqy && apt-get install -y \
        #python-dev \
        #python-setuptools \
        apt-transport-https \
        apt-utils \
        #python-pip \
        curl \
        wget \
        unzip \
        vim \
        lsb-release && \
    rm -rf /var/lib/apt/lists/*
# RUN apt-get update && apt-get install gcc-multilib -y && \
#     rm -rf /var/lib/apt/lists/* && \
#     # easy_install -U pip && \
#     pip uninstall crcmod && \
#     pip install --no-cache -U crcmod
# RUN export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
#     echo "deb https://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
#     curl https://packages.cloud.google.com/apt/doc/apt-key.gpg |  apt-key add -
# RUN apt-get update && apt-get install -y google-cloud-sdk && \
#     rm -rf /var/lib/apt/lists/* && \
#     gcloud config set core/disable_usage_reporting true && \
#     gcloud config set component_manager/disable_update_check true
ARG sdk_version=sdk-tools-linux-3859397.zip
ARG android_home=/opt/android/sdk
RUN apt-get update && \
    apt-get install --yes \
        xvfb lib32z1 lib32stdc++6 build-essential \
        libcurl4-openssl-dev libglu1-mesa libxi-dev libxmu-dev \
        libglu1-mesa-dev && \
    rm -rf /var/lib/apt/lists/*

# Download and install Android SDK
#---------------------------------------------------------------
RUN mkdir -p ${android_home} && \
    curl --silent --show-error --location --fail --retry 3 --output /tmp/${sdk_version} https://dl.google.com/android/repository/${sdk_version} && \
    unzip -q /tmp/${sdk_version} -d ${android_home} && \
    rm /tmp/${sdk_version}

# Set environmental variables
#---------------------------------------------------------------
ENV ANDROID_HOME ${android_home}
ENV ADB_INSTALL_TIMEOUT 120
ENV PATH=${ANDROID_HOME}/emulator:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools:${PATH}
RUN mkdir ~/.android && echo '### User Sources for Android SDK Manager' > ~/.android/repositories.cfg
RUN yes | sdkmanager --licenses && yes | sdkmanager --update

# Update SDK manager and install system image, platform and build tools
#----------------------------------------------------------------------------
RUN sdkmanager \
  "tools" \
  "platform-tools" \
  "emulator"
RUN sdkmanager \
  "build-tools;25.0.0" \
  "build-tools;25.0.1" \
  "build-tools;25.0.2" \
  "build-tools;25.0.3" \
  "build-tools;26.0.1" \
  "build-tools;26.0.2" \
  "build-tools;27.0.0" \
  "build-tools;27.0.1" \
  "build-tools;27.0.2" \
  "build-tools;27.0.3" \
  "build-tools;28.0.0" \
  "build-tools;28.0.1" \
  "build-tools;28.0.2" \
  "build-tools;28.0.3" \
  "build-tools;29.0.0"

# API_LEVEL string gets replaced by m4
RUN sdkmanager "platforms;android-29"

# Install Node
#------------------------------------------------------------------------
RUN groupadd --gid 1000 node \
  && useradd --uid 1000 --gid node --shell /bin/bash --create-home node
ENV NODE_VERSION 10.16.0
RUN ARCH= && dpkgArch="$(dpkg --print-architecture)" \
  && case "${dpkgArch##*-}" in \
    amd64) ARCH='x64';; \
    ppc64el) ARCH='ppc64le';; \
    s390x) ARCH='s390x';; \
    arm64) ARCH='arm64';; \
    armhf) ARCH='armv7l';; \
    i386) ARCH='x86';; \
    *) echo "unsupported architecture"; exit 1 ;; \
  esac \
  # gpg keys listed at https://github.com/nodejs/node#release-keys
  && set -ex \
  && for key in \
    94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
    FD3A5288F042B6850C66B31F09FE44734EB7990E \
    71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
    DD8F2338BAE7501E3DD5AC78C273792F7D83545D \
    C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8 \
    B9AE9905FFD7803F25714661B63B535A4C206CA9 \
    77984A986EBC2AA786BC0F66B01FBB92821C587A \
    8FCCA13FEF1D0C2E91008E09770F7A9A5AE15600 \
    4ED778F539E3634C779C87C6D7062848A1AB005C \
    A48C2BEE680E841632CD4E44F07496B3EB3C1762 \
    B9E2F5981AA6E0CD28160D9FF13993A75599653C \
  ; do \
    gpg --batch --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys "$key" || \
    gpg --batch --keyserver hkp://ipv4.pool.sks-keyservers.net --recv-keys "$key" || \
    gpg --batch --keyserver hkp://pgp.mit.edu:80 --recv-keys "$key" ; \
  done \
  && curl -fsSLO --compressed "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-$ARCH.tar.xz" \
  && curl -fsSLO --compressed "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
  && gpg --batch --decrypt --output SHASUMS256.txt SHASUMS256.txt.asc \
  && grep " node-v$NODE_VERSION-linux-$ARCH.tar.xz\$" SHASUMS256.txt | sha256sum -c - \
  && tar -xJf "node-v$NODE_VERSION-linux-$ARCH.tar.xz" -C /usr/local --strip-components=1 --no-same-owner \
  && rm "node-v$NODE_VERSION-linux-$ARCH.tar.xz" SHASUMS256.txt.asc SHASUMS256.txt \
  && ln -s /usr/local/bin/node /usr/local/bin/nodejs

# Install Yarn
#------------------------------------------------------------------------------------------------------------
# ENV YARN_VERSION 1.16.0
# RUN set -ex \
#   && for key in \
#     6A010C5166006599AA17F08146C2130DFD2497F5 \
#   ; do \
#     gpg --batch --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys "$key" || \
#     gpg --batch --keyserver hkp://ipv4.pool.sks-keyservers.net --recv-keys "$key" || \
#     gpg --batch --keyserver hkp://pgp.mit.edu:80 --recv-keys "$key" ; \
#   done \
#   && curl -fsSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz" \
#   && curl -fsSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz.asc" \
#   && gpg --batch --verify yarn-v$YARN_VERSION.tar.gz.asc yarn-v$YARN_VERSION.tar.gz \
#   && mkdir -p /opt \
#   && tar -xzf yarn-v$YARN_VERSION.tar.gz -C /opt/ \
#   && ln -s /opt/yarn-v$YARN_VERSION/bin/yarn /usr/local/bin/yarn \
#   && ln -s /opt/yarn-v$YARN_VERSION/bin/yarnpkg /usr/local/bin/yarnpkg \
#   && rm yarn-v$YARN_VERSION.tar.gz.asc yarn-v$YARN_VERSION.tar.gz

# Basic smoke test
#----------------------------------------------------------------------------------------------------------
RUN node --version

# Download Sauce Runner
#----------------------------------------------------------------------------------------------------------
RUN curl https://saucelabs.com/downloads/sauce-runner-virtual-0.1.1-linux.zip -o /home/sauce-runner.zip \
  && unzip /home/sauce-runner.zip -d /home/

# Download Sauce Connect
#--------------------------------------------------------------------------------------------------------
RUN curl https://saucelabs.com/downloads/sc-4.4.12-linux.tar.gz -o /home/saucelabs.tar.gz \
  && tar -xzf /home/saucelabs.tar.gz -C /home/
# Set Working Directory
#--------------------------------------------------------------------------
WORKDIR /home/
# Install Node Dependencies
#--------------------------------------------------------------------------
RUN npm install
# Assemble apk and testapk
#--------------------------------------------------------------------------
RUN chmod +x runner.sh \
  && cd android/ \
  && ./gradlew assembleRelease \
  && ./gradlew assembleAndroidTest
CMD [""]