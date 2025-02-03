FROM mysterysd/wzmlx:heroku

WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

# Install necessary packages
RUN apt-get update && apt-get install -y wget curl

# Install custom binaries
RUN wget -qO /usr/local/bin/unx https://github.com/userdocs/qbittorrent-nox-static/releases/latest/download/x86_64-qbittorrent-nox && \
    chmod +x /usr/local/bin/unx

RUN wget -qO /usr/local/bin/xon https://github.com/aria2/aria2/releases/latest/download/aria2c && \
    chmod +x /usr/local/bin/xon

RUN wget -qO /usr/local/bin/vtx https://github.com/ffmpeg/ffmpeg/releases/latest/download/ffmpeg && \
    chmod +x /usr/local/bin/vtx

# Install Python dependencies
COPY . .
RUN pip3 install --no-cache-dir -r requirements.txt

CMD ["bash", "start.sh"]