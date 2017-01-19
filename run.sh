#!/bin/bash

USER="mailan"
GROUP="mailman"
MAILMAN='/usr/local/bin/mailman'



stop ()
{
    $MAILMAN stop
    exit 0
}

start ()
{
    mkdir -p ${MAILMAN_HOME}
    /usr/local/bin/generate_mailman_conf.py
    chown -R mailman:mailman ${MAILMAN_HOME}
    su -c   /usr/local/bin/mailman_proxy.sh  mailman
}

trap stop SIGINT SIGKILL SIGTERM

start

