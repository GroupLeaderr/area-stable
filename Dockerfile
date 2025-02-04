# Base image (Heroku-friendly Python environment)
FROM heroku/heroku:20

# Set working directory
WORKDIR /app

# Install required dependencies
RUN apt-get update && apt-get install -y \
    python3 python3-pip git ffmpeg && \
    apt-get clean

# Copy application files
COPY . .

# Install Python dependencies
RUN pip3 install --no-cache-dir -r requirements.txt

# Expose port (Heroku uses dynamic ports, so we use $PORT)
EXPOSE 5000

# Start the bot
CMD ["bash", "start.sh"]
