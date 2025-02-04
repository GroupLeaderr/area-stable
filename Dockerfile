FROM admin44449999/ffmpeg

WORKDIR /usr/src/app

RUN apt-get update \
    && apt-get install -y --no-install-recommends git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY . .

RUN chmod +x start.sh  
RUN pip3 install --no-cache-dir -r requirements.txt

CMD ["bash", "start.sh"]

