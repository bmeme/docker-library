#!/bin/bash

# Load environment variables
source /root/environment.sh

# Start supervisord and services
exec /usr/bin/supervisord -n -c /etc/supervisord.conf