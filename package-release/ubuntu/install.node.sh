#!/bin/sh

node=$1
sudo update-rc.d $node defaults 80
sudo /etc/init.d/$node start
