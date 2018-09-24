#!/bin/bash -l

set -e

echo "Installing Yeti repo key ..."
apt-key adv --keyserver keys.gnupg.net --recv-key 9CEBFFC569A832B6

echo "Adding Yeti repo to /etc/apt ..."
echo 'deb http://pkg.yeti-switch.org/debian/stretch 1.7 main' >> /etc/apt/sources.list

echo "Installing essentials ..."
apt-get update -qq
apt-get install -yqq \
    postgresql-10-prefix \
    postgresql-10-pgq3 \
    postgresql-10-pgq-ext \
    postgresql-10-yeti \
    locales 


sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

export LANG=en_US.UTF-8 
#echo -n "en_US.UTF-8 UTF-8" >> /etc/locale.gen
#echo -n `LANG="en_US.UTF-8"` >> /etc/default/locale
#exec /usr/sbin/locale-gen
#dpkg-reconfigure locales
#exec /usr/sbin/locale-gen
#locale-gen en_US.UTF-8
#update-locale


rm -r -- "$0"
