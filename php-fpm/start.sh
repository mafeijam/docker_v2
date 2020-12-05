#!/bin/bash

set -e

cron=${CRON:-N}
queue=${QUEUE:-N}

if [ "$cron" = "Y" ]; then

    crontab /etc/cron.d/crontab
    echo "cron starting..." && cron

fi

if [ "$queue" = "Y" ]; then

    echo "queue starting..." & supervisord

fi

exec "$@"