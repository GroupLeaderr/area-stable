# # Use an existing image as the base
# FROM mysterysd/wzmlx:latest

# # Set the working directory
# WORKDIR /usr/src/app

# # Make the app directory writable (if required)
# RUN chmod 777 /usr/src/app

# # Copy all files from the current directory to the container
# COPY . .

# # Rename the binaries and create wrapper scripts (alternative 1)
# RUN mv /usr/bin/ffmpeg /usr/bin/safe_ffmpeg && \
#     mv /usr/bin/aria2c /usr/bin/safe_aria2c && \
#     mv /usr/bin/qbittorrent-nox /usr/bin/safe_qbittorrent

# # Create wrapper scripts that call the renamed binaries (alternative 1)
# RUN echo '#!/bin/bash\nexec /usr/bin/safe_ffmpeg "$@"' > /usr/bin/ffmpeg && chmod +x /usr/bin/ffmpeg
# RUN echo '#!/bin/bash\nexec /usr/bin/safe_aria2c "$@"' > /usr/bin/aria2c && chmod +x /usr/bin/aria2c
# RUN echo '#!/bin/bash\nexec /usr/bin/safe_qbittorrent "$@"' > /usr/bin/qbittorrent-nox && chmod +x /usr/bin/qbittorrent-nox


# # Install dependencies as usual
# RUN pip3 install -r requirements.txt

# # Set the default command to run the start script
# CMD ["bash", "start.sh"]

FROM mysterysd/wzmlx:heroku

WORKDIR /usr/src/app

# Install wget and dependencies
RUN apt-get update && apt-get install -y wget && rm -rf /var/lib/apt/lists/*

# Download qbittorrent-nox static binary
RUN wget -O /usr/local/bin/qbittorrent-nox "https://github.com/userdocs/qbittorrent-nox-static/releases/latest/download/x86_64-qbittorrent-nox" && \
    chmod +x /usr/local/bin/qbittorrent-nox

# Create a non-root user for security
RUN useradd -m appuser && chown -R appuser /usr/src/app
USER appuser

# Copy dependencies first for better caching
COPY requirements.txt .
RUN python3 -m pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application files
COPY . .

# Ensure start.sh has execution permission
RUN chmod +x start.sh

CMD ["bash", "start.sh"]

