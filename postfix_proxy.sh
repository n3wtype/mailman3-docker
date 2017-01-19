#!/bin/bash

POSTFIX=postfix

stop ()
{
    $POSTFIX stop
    exit 0
}

start ()
{
    $POSTFIX start
    tail -f -n 1000 "/var/log/mail.log"
}

trap stop SIGINT SIGKILL SIGTERM

start

