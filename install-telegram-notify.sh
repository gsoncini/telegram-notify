#!/bin/bash

# By GSoncini
# Install packages telegram-notify
apt-get install curl

# retrieve configuration file and main script
wget -O /etc/telegram-notify.conf https://raw.githubusercontent.com/gsoncini/Telegram-Notify/main/telegram-notify.conf
wget -O /usr/local/sbin/telegram-notify https://raw.githubusercontent.com/gsoncini/Telegram-Notify/main/telegram-notify
chmod +x /usr/local/sbin/telegram-notify
