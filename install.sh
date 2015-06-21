#!/bin/sh
cd /
apt-get update; apt-get install -y wget
./bootstrap-salt.sh minion
rm -rf /var/lib/apt/lists/*
apt-get clean
