# #!/bin/bash

# # Heroku dynamically assigns a port, use it if needed
# export PORT=${PORT:-5000}

# # Ensure all dependencies are installed
# pip3 install --no-cache-dir -r requirements.txt

# # Run update script (if needed)
# python3 update.py

# # Start the bot
# exec python3 -m bot
python3 update.py && python3 -m bot
