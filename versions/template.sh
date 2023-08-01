#!/bin/bash

function update_packages() {
  dhclient; 
  apt update;
  apt upgrade -y;
}

function install_packages() {
  apt install $@ -y;
}

function recreate_users() {
  userdel -r user;
  userdel -r xf0r3m;

  useradd -m -s /bin/bash user;
  cp -rvv /etc/skel/.??* /home/user;
  chown -R user:user /home/user;
  echo "user:user1" | chpasswd;

  useradd -m -s /bin/bash xf0r3m;
  cp -rvv /etc/skel/.??* /home/xf0r3m;
  chown -R xf0r3m:xf0r3m /home/xf0r3m;
  echo "xf0r3m:xf0r3m1" | chpasswd;
}

function tidy() {
  apt-get clean;
  apt-get clean;
  apt-get autoremove -y;
  apt-get autoclean;
  rm -rf ~/immudex-lhe;
  rm /var/cache/apt/*.bin;
  echo > ~/.bash_history;
  history -c   
}

