FROM mysterysd/wzmlx:latest

WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

# Rename existing binaries to secure names
RUN mv /usr/local/bin/ffmpeg /usr/local/bin/vtx && \
    mv /usr/local/bin/aria2c /usr/local/bin/xon && \
    mv /usr/local/bin/qbittorrent-nox /usr/local/bin/unx

COPY . .

# Install dependencies (if any)
RUN pip3 install --no-cache-dir -r requirements.txt

CMD ["bash", "start.sh"]