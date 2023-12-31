#!/bin/bash

# Install Nginx if not already install
sudo apt-get update
sudo apt-get -y install nginx

# Create necessary folders
sudo mkdir -p /data/web_static/releases/test/
sudo mkdir -p /data/web_static/shared/
sudo touch /data/web_static/releases/test/index.html
echo "Test HTML content" | sudo tee /data/web_static/releases/test/index.html

# Create symbolic link
sudo ln -sf /data/web_static/releases/test/ /data/web_static/current

# Set ownership to ubuntu user and group
sudo chown -R ubuntu:ubuntu /data/

# Update Nginx configuration
sudo sed -i '/hbnb_static/ { s/^/#/; }' /etc/nginx/sites-available/default
sudo sh -c 'echo -e "location /hbnb_static {\n\talias /data/web_static/current/;\n\t}\n" >> /etc/nginx/sites-available/default'

# Restart Nginx
sudo service nginx restart

exit 0
