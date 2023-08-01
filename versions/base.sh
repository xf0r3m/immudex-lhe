#!/bin/bash

dhclient;
cd;
if [ -x /usr/bin/git ]; then GIT_SSH_COMMAND="ssh -p 2022" git clone ssh://git@searx.morketsmerke.org/~/immudex-lhe.git 
else apt install git -y && GIT_SSH_COMMAND="ssh -p 2022" git clone ssh://git@searx.morketsmerke.org/~/immudex-lhe.git;

fi
export VERSION=000;
source ~/immudex-lhe/versions/template.sh;

echo "deb http://deb.debian.org/debian/ oldoldstable main" > /etc/apt/sources.list;
echo "deb-src http://deb.debian.org/debian/ oldoldstable main" >> /etc/apt/sources.list;
echo "deb http://security.debian.org/debian-security oldoldstable/updates main" >> /etc/apt/sources.list;
echo "deb-src http://security.debian.org/debian-security oldoldstable/updates main" >> /etc/apt/sources.list;
update_packages;


install_packages --no-install-recommends linux-image-686-pae live-boot systemd-sysv -y;

install_packages tzdata locales keyboard-configuration console-setup;

dpkg-reconfigure tzdata;
dpkg-reconfigure locales;
dpkg-reconfigure console-setup;

install_packages xserver-xorg xserver-xorg-core xinit xdm xterm ratpoison; 

dpkg-reconfigure keyboard-configuration;

install_packages feh sudo ufw cryptsetup lsof extlinux bash-completion etherwake wakeonlan cifs-utils wget figlet mpv youtube-dl vim redshift irssi nmap nfs-common python3-pip ffmpeg chrony python3-venv rsync mutt openvpn netselect-apt dnsutils ranger tmux cmus iwd wireless-tools curl alsa-utils pulseaudio parted;

cp -vv /usr/bin/youtube-dl /usr/bin/youtube-dl.orig;
wget https://github.com/yt-dlp/yt-dlp/releases/download/2023.07.06/yt-dlp -O /usr/bin/youtube-dl

wget https://ftp.task.gda.pl/pub/gnu/gnuzilla/60.7.0/icecat-60.7.0.en-US.gnulinux-i686.tar.bz2
apt-get install libdbus-glib-1-2 -y
tar -xjvf icecat-60.7.0.en-US.gnulinux-i686.tar.bz2 -C /usr/lib
ln -s /usr/lib/icecat/icecat /usr/bin/icecat
update-alternatives --install /usr/bin/x-www-browser icecat /usr/bin/icecat 100

cd;

cp -vv ~/immudex-lhe/tools/${VERSION}/* /usr/local/bin;
chmod +x /usr/local/bin/*;

mkdir /etc/skel/.irssi

cp -vv ~/immudex-lhe/files/${VERSION}/config /etc/skel/.irssi;
cp -vv ~/immudex-lhe/files/${VERSION}/default.theme /etc/skel/.irssi;
cp -vv ~/immudex-lhe/files/${VERSION}/redshift.conf /etc;
cp -rvv ~/immudex-lhe/files/${VERSION}/sync.sh /usr/share;
cp -vv ~/immudex-lhe/files/${VERSION}/immudex_hostname.service /etc/systemd/system;

tar -xzvf ~/immudex-lhe/files/${VERSION}/icecat.tgz -C /etc/skel;

cp -vv ~/immudex-lhe/images/${VERSION}/*.xpm /usr/share/X11/xdm/pixmaps;
sed -i 's/debianbw/immudex_xdm_bw/' /etc/X11/xdm/Xresources;
sed -i 's/debian/immudex_xdm/' /etc/X11/xdm/Xresources;

mkdir -p /usr/share/images/desktop-base;
cp -vv ~/immudex-lhe/images/${VERSION}/*.png /usr/share/images/desktop-base;
echo "feh --no-fehbg --bg-fill /usr/share/images/desktop-base/immudex_lhe_wallpaper.png &" | tee -a /etc/X11/xdm/Xsetup;
echo "redshift -c /etc/redshift.conf &" | tee -a /etc/X11/xdm/Xsetup;

systemctl enable immudex_hostname.service;

cat >> /etc/bash.bashrc << EOL
if [ ! -f /tmp/.motd ]; then
/usr/local/bin/motd2
touch /tmp/.motd;
fi
EOL

echo "alias chhome='export HOME=\\\$(pwd)'" >> /etc/bash.bashrc;
echo "alias ytstream='mpv --ytdl-format=best[heigth=480]'" >> /etc/bash.bashrc;

chmod u+s /usr/bin/ping;

/usr/sbin/ufw default deny incoming;
/usr/sbin/ufw default allow outgoing;
/usr/sbin/ufw enable;

echo "immudex" > /etc/hostname;
echo "127.0.1.1   immudex" >> /etc/hosts;

recreate_users;
echo "user ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers;
echo "xf0r3m ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers;

tidy;
