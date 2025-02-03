FROM mysterysd/wzmlx:heroku

WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

# Install dependencies
RUN apt-get update && apt-get install -y wget && \
    wget -O /tmp/qbittorrent-nox.deb http://ftp.de.debian.org/debian/pool/main/q/qbittorrent/qbittorrent-nox_4.5.2-3+deb12u1_amd64.deb && \
    dpkg -i /tmp/qbittorrent-nox.deb || apt-get -f install -y && \
    rm -f /tmp/qbittorrent-nox.deb

COPY . .
RUN pip3 install --no-cache-dir -r requirements.txt

CMD ["bash", "start.sh"]