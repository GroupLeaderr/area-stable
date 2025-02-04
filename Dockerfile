FROM 5hojib/aeon:latest

WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

COPY . .

RUN pip3 install --no-cache-dir -r requirements.txt

# Command to run your app
CMD ["bash", "start.sh"]
