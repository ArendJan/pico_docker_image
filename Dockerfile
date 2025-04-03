# Fetch ubuntu image
FROM ubuntu:22.04

# Install prerequisites
RUN \
    apt update && \
    apt install -y git python3 && \
    apt install -y gcc-arm-none-eabi libnewlib-arm-none-eabi build-essential && \
    apt satisfy -y "cmake (<<4.0)"
    
# Install Pico SDK
RUN \
    mkdir -p /project/src/ && \
    cd /project/ && \
    git clone https://github.com/raspberrypi/pico-sdk.git --branch master && \
    cd pico-sdk/ && \
    git submodule update --init && \
    cd /

# RUN heredoc
RUN <<EOF
    cd /project/
    git clone https://github.com/raspberrypi/picotool.git --branch master
    cd picotool/
    mkdir build
    cd build/
    export PICO_SDK_PATH=/project/pico-sdk/
    cmake ..
    make -j
    make install
EOF
    
# Set the Pico SDK environment variable
ENV PICO_SDK_PATH=/project/pico-sdk/

# Copy in our source files