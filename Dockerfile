# Use an existing image as the base
FROM mysterysd/wzmlx:heroku

# Set the working directory
WORKDIR /usr/src/app

# Make the app directory writable (if required)
RUN chmod 777 /usr/src/app

# Copy all files from the current directory to the container
COPY . .

# Rename the binaries and create wrapper scripts (alternative 1)
RUN mv /usr/bin/ffmpeg /usr/bin/safe_ffmpeg && \
    mv /usr/bin/aria2c /usr/bin/safe_aria2c && \
    # mv /usr/bin/qbittorrent-nox /usr/bin/safe_qbittorrent
    mv /usr/bin/qbittorrent /usr/bin/safe_qbittorrent

# Create wrapper scripts that call the renamed binaries (alternative 1)
RUN echo '#!/bin/bash\nexec /usr/bin/safe_ffmpeg "$@"' > /usr/bin/ffmpeg && chmod +x /usr/bin/ffmpeg
RUN echo '#!/bin/bash\nexec /usr/bin/safe_aria2c "$@"' > /usr/bin/aria2c && chmod +x /usr/bin/aria2c
RUN echo '#!/bin/bash\nexec /usr/bin/safe_qbittorrent "$@"' > /usr/bin/qbittorrent && chmod +x /usr/bin/qbittorrent


# Install dependencies as usual
RUN pip3 install -r requirements.txt

# Set the default command to run the start script
CMD ["bash", "start.sh"]

