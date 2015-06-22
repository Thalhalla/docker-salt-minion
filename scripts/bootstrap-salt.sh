#!/bin/bash
#
# Simple script to bootstrap salt minions and master.
#

add_salt_repo () {
    # add repo
    echo "deb http://debian.saltstack.com/debian wheezy-saltstack main" > /etc/apt/sources.list.d/saltstack.list
    
    # add repo key
    wget -q -O- "http://debian.saltstack.com/debian-salt-team-joehealy.gpg.key" | apt-key add -
    
    # update and install minion
    apt-get update
}

bootstrap_minion () {
    apt-get install salt-minion --yes --force-yes
    
    # configure minion's master
    echo -n "Enter salt master IP/hostname:"
    read salt_master
    sed -i "s/#master: salt/master: ${salt_master}/" /etc/salt/minion
    
    # start minion service
    service salt-minion start
}

bootstrap_master () {
    apt-get install salt-master --yes --force-yes
    # start master service
    service salt-master start
}

case "$1" in
    master)
        add_salt_repo
        bootstrap_master
        ;;

    minion)
        add_salt_repo
        bootstrap_minion
        ;;

    *)
        echo $"Usage: $0 {master|minion}"
        exit 1

esac

