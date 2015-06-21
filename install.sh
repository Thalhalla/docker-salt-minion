#!/bin/sh
cd /
./bootstrap-salt.sh minion
rm -rf /var/lib/apt/lists/*
apt-get clean
