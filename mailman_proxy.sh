#!/bin/bash

USER="mailan"
GROUP="mailman"
MAILMAN='/usr/local/bin/mailman'



stop ()
{
    $MAILMAN stop
    rm "$MAILMAN_HOME/logs/mailman.log"
    exit 0
}

start ()
{
    touch "$MAILMAN_HOME/logs/mailman.log"
    $MAILMAN start --force
    tail -f -n 100 "$MAILMAN_HOME/logs/mailman.log"
}

trap stop SIGINT SIGKILL SIGTERM

start

