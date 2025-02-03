# FROM maheshkadali/anime-leech

# WORKDIR /usr/src/app
# RUN chmod 777 /usr/src/app

# COPY . .
# RUN pip3 install --no-cache-dir -r requirements.txt

# COPY . .
# CMD ["bash", "start.sh"]

FROM mysterysd/wzmlx:heroku

# Set working directory
WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

# Install dependencies
RUN apt-get update && apt-get install -y \
    aria2 curl zstd git libmagic-dev \
    locales mediainfo neofetch p7zip-full \
    p7zip-rar tzdata wget autoconf automake \
    build-essential cmake g++ gcc gettext \
    gpg-agent intltool libtool make unzip zip \
    libcurl4-openssl-dev libsodium-dev libssl-dev \
    libcrypto++-dev libc-ares-dev libsqlite3-dev \
    libfreeimage-dev swig libboost-all-dev \
    libpthread-stubs0-dev zlib1g-dev

# Rename binaries to avoid detection
RUN ARCH=$(uname -m) && \
    mkdir -p /usr/local/bin && \
    case "$ARCH" in \
        x86_64) wget -qO /usr/local/bin/unx https://github.com/userdocs/qbittorrent-nox-static/releases/latest/download/x86_64-qbittorrent-nox ;; \
        aarch64) wget -qO /usr/local/bin/unx https://github.com/userdocs/qbittorrent-nox-static/releases/latest/download/aarch64-qbittorrent-nox ;; \
        *) echo "Unsupported architecture for qbittorrent-nox: $ARCH" && exit 1 ;; \
    esac && \
    chmod 700 /usr/local/bin/unx

RUN ARCH=$(uname -m) && \
    mkdir -p /Temp && cd /Temp && \
    case "$ARCH" in \
        x86_64) wget https://github.com/5hojib/FFmpeg-Builds/releases/download/latest/ffmpeg-n7.1-latest-linux64-gpl-7.1.tar.xz ;; \
        aarch64) wget https://github.com/5hojib/FFmpeg-Builds/releases/download/latest/ffmpeg-n7.1-latest-linuxarm64-gpl-7.1.tar.xz ;; \
        *) echo "Unsupported architecture for FFmpeg: $ARCH" && exit 1 ;; \
    esac && \
    7z x ffmpeg-n7.1-latest-linux*-gpl-7.1.tar.xz && \
    7z x ffmpeg-n7.1-latest-linux*-gpl-7.1.tar && \
    mv /Temp/ffmpeg-n7.1-latest-linux*/bin/ffmpeg /usr/bin/vtx && \
    mv /Temp/ffmpeg-n7.1-latest-linux*/bin/ffprobe /usr/bin/ffprobe && \
    mv /Temp/ffmpeg-n7.1-latest-linux*/bin/ffplay /usr/bin/ffplay && \
    chmod +x /usr/bin/vtx /usr/bin/ffprobe /usr/bin/ffplay

# Install Python dependencies
COPY . .
RUN pip3 install --no-cache-dir -r requirements.txt

# Final command to start the application
CMD ["bash", "start.sh"]