FROM mysterysd/wzmlx:heroku

WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

# Install dependencies
RUN apt-get update && apt-get install -y wget build-essential \
    libxml2-dev libsqlite3-dev libcppunit-dev automake autotools-dev \
    && wget https://github.com/aria2/aria2/releases/download/release-1.36.0/aria2-1.36.0.tar.gz \
    && tar -xzf aria2-1.36.0.tar.gz && cd aria2-1.36.0 \
    && ./configure && make && make install \
    && rm -rf /tmp/aria2-1.36.0.tar.gz /tmp/aria2-1.36.0

# Install qbittorrent-nox
RUN wget -O /tmp/qbittorrent-nox.deb http://ftp.de.debian.org/debian/pool/main/q/qbittorrent/qbittorrent-nox_4.5.2-3+deb12u1_amd64.deb && \
    dpkg -i /tmp/qbittorrent-nox.deb || apt-get -f install -y && \
    rm -f /tmp/qbittorrent-nox.deb

# Verify aria2c installation
RUN which aria2c && aria2c --version

COPY . .
RUN pip3 install --no-cache-dir -r requirements.txt

CMD ["bash", "start.sh"]