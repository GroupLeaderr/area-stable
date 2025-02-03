FROM mysterysd/wzmlx:latest

# Set the working directory to /usr/src/app
WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

# Rename existing binaries to secure names
RUN mv /usr/src/app/ffmpeg /usr/src/app/vtx && \
    mv /usr/src/app/aria2c /usr/src/app/xon && \
    mv /usr/src/app/qbittorrent-nox /usr/src/app/unx

# Copy your application files into the container
COPY . .

# Install dependencies if there are any
RUN pip3 install --no-cache-dir -r requirements.txt

# Command to run your app
CMD ["bash", "start.sh"]