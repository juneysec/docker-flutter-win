FROM ubuntu:24.04
 
RUN apt-get -qq update \
 && apt-get -qqy --no-install-recommends install apt-utils \
 && apt-get -qqy --no-install-recommends install build-essential \
    openjdk-17-jdk \
    openjdk-17-jre-headless \
    software-properties-common \
    libssl-dev \
    libffi-dev \
    python3-dev \
    cargo \
    pkg-config\  
    libstdc++6 \
    libpulse0 \
    libglu1-mesa \
    openssh-server \
    libc6 \
    libbz2-1.0 \
    zip \
    unzip \
    sudo \
    curl \
    lldb \
    vim \
    qtbase5-dev qtchooser qt5-qmake qtbase5-dev-tools \
    libxkbfile1 \
    language-pack-ja-base \
    language-pack-ja ibus-mozc \
    wget \
    git > /dev/null \
 && add-apt-repository "deb http://archive.ubuntu.com/ubuntu/ jammy main universe" \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
 && useradd -ms /bin/bash developer \
 && adduser developer root \
 && echo "developer ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
 
ENV LANG=ja_JP.UTF-8
ENV LANGUAGE="ja_JP:ja"
ENV TZ="Asia/Tokyo"
ENV DISPLAY=host.docker.internal:0.0

USER developer
# Install Android SDK
WORKDIR /home/developer
RUN mkdir -p /home/developer/Android/SDK/cmdline-tools \
 && wget https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip?hl=ja -O latest.zip \
 && unzip latest.zip \
 && mv cmdline-tools /home/developer/Android/SDK/cmdline-tools/latest \
 && rm -rf latest.zip \
 && export ANDROID_HOME=/home/developer/Android/SDK \
 && export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin \
 && printf "\nexport ANDROID_HOME=\$HOME/Android/SDK\nexport PATH=\$PATH:\$ANDROID_HOME/cmdline-tools/latest/bin\n" >> ~/.bashrc \
 && yes | sdkmanager --install "platform-tools" \
 && export PATH=$PATH:$ANDROID_HOME/platform-tools \
 && printf "export PATH=\$PATH:\$ANDROID_HOME/platform-tools\n" >> ~/.bashrc \
 && yes | sdkmanager --licenses \
 && sdkmanager --install "system-images;android-35;google_apis;x86_64" "platforms;android-35" "build-tools;35.0.0" "build-tools;33.0.1" "platforms;android-34" emulator \
 && export PATH=$PATH:$ANDROID_HOME/emulator \
 && printf "export PATH=\$PATH:\$ANDROID_HOME/emulator\n" >> ~/.bashrc
 
RUN echo no | /home/developer/Android/SDK/cmdline-tools/latest/bin/avdmanager create avd -n android35 -k "system-images;android-35;google_apis;x86_64" \
 && echo emulator -avd android35 > run_emulator.sh \
 && chmod 755 run_emulator.sh
 
# Install Flutter
RUN wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.24.3-stable.tar.xz -O flutter.tar.xz \
 && tar xf flutter.tar.xz \
 && rm -rf flutter.tar.xz \
 && mv flutter .flutter-sdk \
 && export FLUTTER_ROOT=/home/developer/.flutter-sdk \
 && export PATH=$PATH:$FLUTTER_ROOT/bin \
 && printf "\nexport FLUTTER_ROOT=\$HOME/.flutter-sdk/\nexport PATH=\$PATH:\$FLUTTER_ROOT/bin\n" >> ~/.bashrc \
 && flutter doctor \
 && flutter doctor --android-licenses \
 && echo "sudo chgrp root /dev/kvm" >> ~/.bashrc
 
#USER 0

