#!/bin/bash

/usr/local/bin/init.sh

exec /usr/bin/supervisord -n -c /etc/supervisord.conf
