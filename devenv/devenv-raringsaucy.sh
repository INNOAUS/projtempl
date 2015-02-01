#! /bin/sh

sudo apt-get -y install wget

wget http://www.zeroc.com/download/RPM-GPG-KEY-zeroc-release
sudo apt-key add RPM-GPG-KEY-zeroc-release

cd /etc/apt/sources.list.d
sudo wget http://www.zeroc.com/download/Ice/3.5/ubuntu/ice3.5-raring.list
sudo apt-get update
sudo apt-get -y install ice icebox icegrid
sudo apt-get -y install ice-dev
sudo apt-get -y install db5.3-util
#apt-get source ice3.5

sudo apt-get -y install make
sudo apt-get -y install g++

sudo apt-get -y install vim ssh unzip bzip2 htop ufw

sudo apt-get -y install libcrypto++-dev sqlite3 libsqlite3-dev libboost-all-dev libpq-dev libace-dev libssl-dev libnet1-dev libpcap-dev libqrencode-dev libpam0g-dev libxerces-c-dev libxerces-c-doc subversion openssl nodejs-dev npm node-node-uuid node-gyp nodejs-legacy rlwrap

sudo apt-get -y libopencv-dev

sudo apt-get -y install openjdk-6-jdk

sudo apt-get -y install unixODBC unixodbc-dev freetds-dev sqsh tdsodbc

sudo apt-get -y mono-complete

# run on a shell
# npm install -g packages.json
# npm install -g pg
# npm install -g colors
# npm install -g express

sudo apt-get -y install python-software-properties
sudo apt-get update
