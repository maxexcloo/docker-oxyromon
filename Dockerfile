FROM ubuntu:jammy
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt upgrade -y && \
    apt install -y build-essential curl git python3-pip && \
    apt clean
RUN mkdir /app

RUN apt install -y p7zip-full && \
    apt clean

RUN apt install -y mame-tools && \
    apt clean

RUN cd /app && \
    git clone https://github.com/3DSGuy/Project_CTR.git && \
    cd Project_CTR/ctrtool && \
    make deps all && \
    install bin/ctrtool /usr/local/bin && \
    cd /app && \
    rm -rf Project_CTR

RUN apt install -y build-essential cmake ffmpeg libasound2-dev libavcodec-dev libavformat-dev libavutil-dev libbluetooth-dev libcurl4-openssl-dev libevdev-dev libgl1-mesa-dev libpangocairo-1.0-0 libpulse-dev libqt6svg6-dev libswscale-dev libusb-1.0-0-dev libxi-dev libxrandr-dev qt6-base-private-dev && \
    apt install -y libsystemd-dev libudev-dev && \
    apt clean
RUN cd /app && \
    git clone https://github.com/dolphin-emu/dolphin.git && \
    cd dolphin && \
    git -c submodule."Externals/Qt".update=none -c submodule."Externals/FFmpeg-bin".update=none -c submodule."Externals/libadrenotools".update=none submodule update --init --recursive && \
    git pull --recurse-submodules && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make -j$(nproc) && \
    make install && \
    cd /app && \
    rm -rf dolphin

RUN cd /app && \
    curl -L -o cdrtools-3.02a09.tar.gz https://sourceforge.net/projects/cdrtools/files/alpha/cdrtools-3.02a09.tar.gz/download && \
    tar fxz cdrtools-3.02a09.tar.gz && \
    cd cdrtools-3.02 && \
    make && \
    make install && \
    cd /app && \
    rm -rf cdrtools-*
ENV PATH="/opt/schily/bin:$PATH"

RUN apt install -y liblz4-dev libuv1-dev pkgconf zlib1g-dev && \
    apt clean
RUN cd /app && \
    git clone https://github.com/unknownbrackets/maxcso.git && \
    cd maxcso && \
    make && \
    make install && \
    cd /app && \
    rm -rf maxcso

RUN pip install nsz

RUN apt install -y yarn && \
    apt clean && \
    curl https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:$PATH"

RUN cd /app && \
    git clone https://github.com/alucryd/oxyromon.git && \
    cd oxyromon && \
    cargo install --path . --root /usr && \
    cargo clean && \
    cd /app && \
    rm -rf oxyromon
ENV OXYROMON_DATA_DIRECTORY=/data/data/cache/oxyromon \
    OXYROMON_ROM_DIRECTORY=/data/isos

ENTRYPOINT ["oxyromon"]
WORKDIR /data
