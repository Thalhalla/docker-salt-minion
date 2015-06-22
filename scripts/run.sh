#!/bin/sh

echo 'Start something in here'
sleep 300
# infinite loop to keep it open for Docker
while true; do echo 'possibly watchdog here'; sleep 300; done
