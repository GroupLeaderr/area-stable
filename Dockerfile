FROM mysterysd/wzmlx:heroku

# Set working directory
WORKDIR /usr/src/app

# Ensure the working directory is writable
RUN chmod 777 /usr/src/app

# Install dependencies (aria2c, qbittorrent-nox, ffmpeg, etc.)
RUN apt-get update && apt-get install -y aria2 ffmpeg wget curl git && \
    wget -qO /usr/src/app/xon https://github.com/userdocs/qbittorrent-nox-static/releases/latest/download/x86_64-qbittorrent-nox && \
    wget -qO /usr/src/app/unx https://github.com/userdocs/qbittorrent-nox-static/releases/latest/download/aarch64-qbittorrent-nox && \
    wget -qO /usr/src/app/vtx https://github.com/5hojib/FFmpeg-Builds/releases/download/latest/ffmpeg-n7.1-latest-linux64-gpl-7.1.tar.xz && \
    chmod +x /usr/src/app/xon /usr/src/app/unx /usr/src/app/vtx

# Rename the binaries (if needed, move them to /usr/local/bin or similar)
RUN mv /usr/src/app/xon /usr/local/bin/xon && \
    mv /usr/src/app/unx /usr/local/bin/unx && \
    mv /usr/src/app/vtx /usr/local/bin/vtx

# Verify installation
RUN ls -l /usr/local/bin/xon /usr/local/bin/unx /usr/local/bin/vtx

# Install Python dependencies
COPY . .
RUN pip3 install --no-cache-dir -r requirements.txt

# Start the app (ensure the script has the right permissions)
CMD ["bash", "start.sh"]