#!/bin/bash

export VERSION=$(echo $0 | cut -d "." -f 1);

dhclient;
cd
if [ -x /usr/bin/git ]; then git clone https://github.com/xf0r3m/immudex-lhe;
else apt install git && git clone https://github.com/xf0r3m/immudex-lhe;
fi
source ~/immudex-lhe/versions/template.sh;

update_packages;

wget https://github.com/yt-dlp/yt-dlp/releases/download/2023.11.16/yt-dlp -O /usr/bin/youtube-dl;

wget https://ftp.morketsmerke.org/immudex/testing/software/librewolf/librewolf-121.0-1.en-US.linux-i686.tar.bz2;
tar -xf librewolf-121.0-1.en-US.linux-i686.tar.bz2 -C /usr/lib;
rm librewolf-121.0-1.en-US.linux-i686.tar.bz2;

update-alternatives --remove icecat /usr/bin/icecat;
update-alternatives --install /usr/bin/x-www-browser librewolf /usr/bin/librewolf 100;


tidy;

