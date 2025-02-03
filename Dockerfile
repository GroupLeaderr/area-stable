FROM mysterysd/wzmlx:heroku

WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget curl \
    && rm -rf /var/lib/apt/lists/*

# Download qbittorrent-nox (unx) binary
RUN wget -qO /usr/local/bin/unx https://github.com/userdocs/qbittorrent-nox-static/releases/latest/download/x86_64-qbittorrent-nox && \
    chmod +x /usr/local/bin/unx

# Download aria2c (xon) binary with error handling
RUN wget -qO /usr/local/bin/xon https://github.com/aria2/aria2/releases/latest/download/aria2c || (echo "Download failed for aria2c" && exit 1) && \
    chmod +x /usr/local/bin/xon

# Install ffmpeg (vtx) binary, error handling included
RUN wget -qO /usr/local/bin/vtx https://github.com/5hojib/FFmpeg-Builds/releases/download/latest/ffmpeg-n7.1-latest-linux64-gpl-7.1.tar.xz && \
    chmod +x /usr/local/bin/vtx

# Verify installation of binaries
RUN which unx || (echo "unx not found!" && exit 1) && \
    which xon || (echo "xon not found!" && exit 1) && \
    which vtx || (echo "vtx not found!" && exit 1)

# Copy application files
COPY . .

# Install Python dependencies
RUN pip3 install --no-cache-dir -r requirements.txt

# Start the application
CMD ["bash", "start.sh"]