#!/bin/bash -l

set -e

# Use local cache proxy if it can be reached, else nothing.
eval $(detect-proxy enable)

log::m-info "Installing Yeti repo key ..."
apt-key adv --keyserver keys.gnupg.net --recv-key 9CEBFFC569A832B6

log::m-info "Adding Yeti repo to /etc/apt ..."
echo 'deb http://pkg.yeti-switch.org/debian/jessie stable main ext' >> /etc/apt/sources.list

log::m-info "Installing essentials ..."
apt-get update -qq
apt-get install -yqq \
    ca-certificates \
    postgresql-contrib-9.4 \
    postgresql-9.4-prefix \
    postgresql-9.4-pgq3 \
    postgresql-9.4-yeti \
    locales \
	iputils-ping

log::m-info "Installing locales ..."

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

log::m-info "Removing jq and git ..."
apt-get purge -y --auto-remove git

log::m-info "Cleaning up ..."
apt-clean --aggressive

# if applicable, clean up after detect-proxy enable
eval $(detect-proxy disable)

rm -r -- "$0"
