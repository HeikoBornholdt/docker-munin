#!/bin/bash

/usr/sbin/cron
/usr/sbin/apache2ctl start

tail -F /var/log/munin/munin-update.log /var/log/apache2/access.log /var/log/apache2/error.log & pid=$!
echo "tail -F running in $pid"

sleep 1

trap "echo 'stopping processes' ; kill $pid $(cat /var/run/crond.pid) $(cat  /var/run/apache2/apache2.pid)" SIGTERM SIGINT

echo "Waiting for signal SIGINT/SIGTERM"
wait
