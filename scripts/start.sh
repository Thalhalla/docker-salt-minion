#!/bin/sh

if [ -n "$SALT_MASTER" ]
then
  echo "$SALT_MASTER salt" >>/etc/hosts
  echo "master: $SALT_MASTER" >/etc/salt/minion
  echo "master_port: $SALT_MASTER_PORT" >/etc/salt/minion
  salt-call state.highstate
else
  echo 'file_client: local' >/etc/salt/minion
  salt-call --local state.highstate
fi
sh -c /scripts/run.sh
