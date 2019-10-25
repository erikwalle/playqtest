#!/bin/bash
sudo apt-get update -y
sudo apt-get install apache2 -y
sudo systemctl enable apache2
sudo systemctl start apache2
sudo chmod 777 /var/www/html/index.html