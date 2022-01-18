# Telegram-Notify

#### Install: <br>

  wget https://raw.githubusercontent.com/gsoncini/Telegram-Notify/main/install-telegram-notify.sh <br>
  chmod +x install-telegram-notify.sh <br>
  ./install-telegram-notify.sh <br>


#### Configure your bot token and user-id: <br>

  /etc/telegram-notify.conf


#### Send telegram message: <br>

  /usr/local/sbin/telegram-notify --error --text "*PROBLEM* -- NODE01 Down"
