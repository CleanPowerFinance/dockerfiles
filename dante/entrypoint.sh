#!/bin/bash

echo "Creating user..."
useradd -ms /bin/bash ${PROXY_USER}
echo "${PROXY_USER}:${PROXY_PASSWORD}" | chpasswd
echo "Complete"

sockd -f $CFGFILE -p $PIDFILE -N $WORKERS

