FROM spidybhai/mleech:latest

WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    aria2 curl zstd git libmagic-dev \
    locales mediainfo neofetch p7zip-full \
    p7zip-rar tzdata wget autoconf automake \
    build-essential cmake g++ gcc gettext \
    gpg-agent intltool libtool make unzip zip \
    libcurl4-openssl-dev libsodium-dev libssl-dev \
    libcrypto++-dev libc-ares-dev libsqlite3-dev \
    libfreeimage-dev swig libboost-all-dev \
    && rm -rf /var/lib/apt/lists/*

# Create a bin directory inside /usr/local/bin for renamed binaries
RUN mkdir -p /usr/local/bin

# Install and rename qbittorrent-nox
RUN ARCH=$(uname -m) && \
    if [ "$ARCH" = "x86_64" ]; then \
        wget -qO /usr/local/bin/xnox https://github.com/userdocs/qbittorrent-nox-static/releases/latest/download/x86_64-qbittorrent-nox; \
    elif [ "$ARCH" = "aarch64" ]; then \
        wget -qO /usr/local/bin/xnox https://github.com/userdocs/qbittorrent-nox-static/releases/latest/download/aarch64-qbittorrent-nox; \
    else \
        echo "Unsupported architecture"; exit 1; \
    fi && chmod +x /usr/local/bin/xnox

# Install and rename FFmpeg
RUN ARCH=$(uname -m) && \
    mkdir -p /Temp && cd /Temp && \
    if [ "$ARCH" = "x86_64" ]; then \
        wget -qO ffmpeg.tar.xz https://github.com/5hojib/FFmpeg-Builds/releases/download/latest/ffmpeg-n7.1-latest-linux64-gpl-7.1.tar.xz; \
    elif [ "$ARCH" = "aarch64" ]; then \
        wget -qO ffmpeg.tar.xz https://github.com/5hojib/FFmpeg-Builds/releases/download/latest/ffmpeg-n7.1-latest-linuxarm64-gpl-7.1.tar.xz; \
    else \
        echo "Unsupported architecture"; exit 1; \
    fi && \
    tar -xvf ffmpeg.tar.xz && \
    mv ffmpeg-n7.1-latest-linux*/bin/ffmpeg /usr/local/bin/xtra && \
    chmod +x /usr/local/bin/xtra && \
    rm -rf /Temp

# Rename aria2c to xria
RUN mv /usr/bin/aria2c /usr/local/bin/xria && chmod +x /usr/local/bin/xria

# Copy project files
COPY . .

# Install Python dependencies
RUN pip3 install --no-cache-dir -r requirements.txt

CMD ["bash", "start.sh"]