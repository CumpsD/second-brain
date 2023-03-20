#!/bin/bash

# Stop on first error
set -e

# to skip any questions from APT
export DEBIAN_FRONTEND=noninteractive

AUTO_SIGNUP=0

while getopts "a" opt; do
	case $opt in
	a)
	    AUTO_SIGNUP=1
	    ;;
	esac
done

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

apt-get update -y
apt-get install dirmngr -y

# Import GPG key for the APT repository
KEY_ID=C969F07840C430F5
apt-key adv --recv-key --keyserver keyserver.ubuntu.com ${KEY_ID} || \
apt-key adv --recv-key --keyserver pool.sks-keyservers.net ${KEY_ID} || \
apt-key adv --recv-key --keyserver pgp.mit.edu ${KEY_ID}

# Add APT repository to the config file, removing older entries if exist
mv /etc/apt/sources.list /etc/apt/sources.list.bak
grep -v flightradar24 /etc/apt/sources.list.bak > /etc/apt/sources.list || echo OK
echo 'deb http://repo.feed.flightradar24.com flightradar24 raspberrypi-stable' >> /etc/apt/sources.list

apt-get update -y
apt-get install -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" -y fr24feed

# Stop older instances if exist
systemctl stop fr24feed || echo OK

# Run the signup wizard
if [ $AUTO_SIGNUP -eq 0 ]; then
    fr24feed --signup
    chmod a+rw /etc/fr24feed.ini

    # Restart the feeder software
    systemctl restart fr24feed
fi

echo "Installation and configuration completed!"
