FROM ubuntu:22.04

# Install base tools
RUN apt-get update && apt-get install -y \
    build-essential \
    make \
    cmake \
    git \
    mono-complete \
    python3 \
    python3-pip \
    wget && \
    apt-get clean

# Install ARM toolchain
RUN wget https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2 && \
    tar -xjf gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2 -C /usr/local && \
    rm gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2 && \
    ln -s /usr/local/gcc-arm-none-eabi-10.3-2021.10/bin/* /usr/bin/

# Install Renode
RUN pip3 install renode

# Verify installation
RUN renode --version
