#!/bin/bash

export VERSION=$(echo $0 | cut -d "." -f 1);

dhclient;
cd
if [ -x /usr/bin/git ]; then git clone https://github.com/xf0r3m/immudex-lhe;
else apt install git && git clone https://github.com/xf0r3m/immudex-lhe;
fi
source ~/immudex-lhe/versions/template.sh;

update_packages;

wget https://github.com/yt-dlp/yt-dlp/releases/download/2023.10.07/yt-dlp -O /usr/bin/youtube-dl;

install_packages firejail;
cp -vv ~/immudex-lhe/files/${VERSION}/firejail.config /etc/firejail;

wget https://ftp.morketsmerke.org/immudex/testing/software/librewolf/librewolf-118.0.1-1.en-US.linux-i686.tar.bz2;
tar -xf librewolf-118.0.1-1.en-US.linux-i686.tar.bz2 -C /usr/lib;
rm librewolf-118.0.1-1.en-US.linux-i686.tar.bz2;
ln -s /usr/lib/librewolf/librewolf /usr/bin/librewolf;
update-alternatives --remove icecat /usr/bin/icecat;
update-alternatives --install /usr/bin/x-www-browser librewolf /usr/bin/librewolf 100;
rm -v /usr/bin/icecat;
rm -rfv /usr/lib/icecat;
tar -xf ~/immudex-lhe/files/${VERSION}/librewolf.tgz -C /etc/skel;


cp -vv ~/immudex-lhe/tools/${VERSION}/idle-clic /usr/local/bin;
cp -vv ~/immudex-lhe/tools/${VERSION}/pl /usr/local/bin;
cp -vv ~/immudex-lhe/tools/${VERSION}/secured-firefox /usr/local/bin;
cp -vv ~/immudex-lhe/tools/${VERSION}/library.sh /usr/local/bin;
cp -vv ~/immudex-lhe/tools/${VERSION}/motd2 /usr/local/bin;
cp -vv ~/immudex-lhe/tools/${VERSION}/newsfeed /usr/local/bin;
cp -vv ~/immudex-lhe/tools/${VERSION}/sync.sh /usr/local/bin;

chmod +x /usr/local/bin/*;

cp -rvv ~/immudex-lhe/files/${VERSION}/sync.sh /usr/share;

recreate_users;

tidy;

