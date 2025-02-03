# Use the mysterysd/wzmlx:heroku image as the base
FROM mysterysd/wzmlx:heroku

# Install dependencies needed to download and install qbittorrent-nox
RUN apt-get update && apt-get install -y \
    curl \
    python3 \
    python3-pip \
    libtorrent-rasterbar-dev \
    build-essential \
    && apt-get clean

# Install qbittorrent-nox using the official Dockerfile steps
RUN curl -L https://github.com/qbittorrent/docker-qbittorrent-nox/releases/download/latest/qbittorrent-nox.tar.gz \
    | tar -xz -C /usr/local/bin

# Set working directory
WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

# Copy application files
COPY . .

# Install Python dependencies
RUN pip3 install --no-cache-dir -r requirements.txt

# Start the application
CMD ["bash", "start.sh"]