# Use the mysterysd/wzmlx:heroku image as the base
FROM mysterysd/wzmlx:heroku

# Set working directory
WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

# Install dependencies needed to download and install qbittorrent-nox
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    python3 \
    python3-pip \
    libtorrent-rasterbar-dev \
    && apt-get clean

# Manually download and install qbittorrent-nox
RUN wget -qO /usr/bin/qbittorrent-nox https://github.com/qbittorrent/qBittorrent/releases/download/release-4.4.5/qbittorrent-nox_4.4.5_amd64.deb && \
    dpkg -i /usr/bin/qbittorrent-nox && \
    apt-get -f install -y && \
    chmod +x /usr/bin/qbittorrent-nox

# Copy application files
COPY . .

# Install Python dependencies
RUN pip3 install --no-cache-dir -r requirements.txt

# Start the application
CMD ["bash", "start.sh"]