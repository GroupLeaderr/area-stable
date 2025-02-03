FROM mysterysd/wzmlx:heroku

WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

COPY . .
RUN apt-get update && apt-get install -y qbittorrent-nox
RUN pip3 install --no-cache-dir -r requirements.txt

CMD ["bash", "start.sh"]

