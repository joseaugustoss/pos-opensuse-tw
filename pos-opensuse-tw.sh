#!/usr/bin/env bash

APP_GOOGLE_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm"
APP_GITDESKTOP="https://github.com/shiftkey/desktop/releases/download/release-2.5.0-linux2/GitHubDesktop-linux-2.5.0-linux2.rpm"

DOWNLOADS_APP="$HOME/Downloads/App"

git tmux dropbox qbittorrent apache2 yast2-http-server mariadb  mariadb-tools docker docker-compose nodejs10


mkdir "$DOWNLOADS_APP"
wget -c "$APP_GOOGLE_CHROME" -P "$DOWNLOADS_APP"
wget -c "$APP_GITDESKTOP" -P "$DOWNLOADS_APP"

sudo zypper dup -y

# Instalando repositório pós instalação
sudo zypper ar -cfp 90 http://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/ packman
sudo zypper ar -cfp 90 http://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/Essentials packman-essentials
sudo zypper addrepo --refresh https://download.opensuse.org/repositories/system:/snappy/openSUSE_Tumbleweed snappy

sudo zypper --gpg-auto-import-keys refresh

sudo zypper refresh
sudo zypper dup --from snappy



# Alterando o pacote do sistema
sudo zypper dup --from packman --allow-vendor-change
sudo zypper dup --from packman-essentials --allow-vendor-change


sudo zypper in $DOWNLOADS_APP/*.rpm


# Instalações iniciais
sudo zypper in -y git tmux dropbox qbittorrent apache2 yast2-http-server mariadb  mariadb-tools docker docker-compose nodejs10


# Instalação de codecs e comunicação
sudo zypper in -y libxine2-codecs ffmpeg lame dvdauthor07 gstreamer-plugins-base gstreamer-plugins-bad gstreamer-plugins-bad-orig-addon gstreamer-plugins-good gstreamer-plugins-ugly gstreamer-plugins-ugly-orig-addon gstreamer-plugins-good-extra h264enc x264 x265 gstreamer-plugins-libav ffmpeg-4 discord


sudo zypper dup --from packman
rm /home/$USER/.cache/gstreamer-1.0/*
 
# programas de vídeo e audio
sudo zypper in --from packman vlc vlc-codecs
sudo zypper in -y --from packman vlc vlc-codecs

sudo zypper in -y smplayer smplayer-lang smplayer-skins smplayer-themes audacious audacious-lang audacious-plugins audacious-plugins-lang audacious-plugins-extra

# extração e criação de arquivos compactados
sudo zypper in -y bzip2 cabextract lhasa lzip p7zip rar unrar unzip zip

# Iniciando o servidor apache 
sudo systemctl start apache2
sudo systemctl enable apache2

sudo chmod 777 -R /srv/www/htdocs
echo "<html><body><h1>Welcome to my web site!</h1><h2>Servidor OpenSuse</h2></body></html>" > /srv/www/htdocs/index.html
echo "<?php phpinfo();" > /srv/www/htdocs/info.php
# Pacote PHP
sudo zypper in -y php7 php7-mysql apache2-mod_php7 php-xdebug

sudo a2enmod php7

sudo systemctl restart apache2

# Configurando o Mysql
sudo systemctl start mysql
sudo systemctl enable mysql
sudo mysql_secure_installation

# Iniciando o Docker
sudo systemctl enable docker
sudo usermod -G docker -a $USER
sudo systemctl restart docker

#phpMyAdmin
sudo zypper in -y phpMyAdmin


# Ferramentas de desenvolvimento
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo zypper ar https://packages.microsoft.com/yumrepos/vscode vscode
sudo zypper refresh
sudo zypper in -y code

# Instalando o snap
sudo zypper in -y snapd
sudo systemctl enable snapd
sudo systemctl start snapd
sudo systemctl enable snapd.apparmor
sudo systemctl start snapd.apparmor


# aplicativos extra
sudo snap install obs-studio
sudo snap install spotify
sudo snap install telegram-desktop
sudo snap install slack --classic
sudo snap install beekeeper-studio
sudo snap install postman
sudo snap install phpstorm --classic
sudo snap install android-studio --classic

sudo zypper dup -y