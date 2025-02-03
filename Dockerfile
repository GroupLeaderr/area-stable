# Use the mysterysd/wzmlx:heroku image as the base
FROM mysterysd/wzmlx:heroku

# Set working directory
WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

# Install dependencies needed to build qbittorrent-nox
RUN apt-get update && apt-get install -y \
    curl \
    python3 \
    python3-pip \
    libtorrent-rasterbar-dev \
    git \
    build-essential \
    && apt-get clean

# Clone the official qbittorrent-docker repository
RUN git clone https://github.com/qbittorrent/docker-qbittorrent-nox.git /qbittorrent-nox

# Build qbittorrent-nox from source
WORKDIR /qbittorrent-nox
RUN ./build.sh

# Set the correct working directory for your app
WORKDIR /usr/src/app

# Copy your app files
COPY . .

# Install Python dependencies
RUN pip3 install --no-cache-dir -r requirements.txt

# Start the application
CMD ["bash", "start.sh"]