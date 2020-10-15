#!/bin/bash
set -e

if [ -z "$CRON_SCHEDULE" ]; then
    echo "ERROR: \$CRON_SCHEDULE not set!"
    exit 1
fi

if [ "$ONE_OFF" = "true" ]
then
    echo "One off task should begin..."
    python3 /backup/backup.py
fi
# Write cron schedule
echo "Starting System..."

echo "$CRON_SCHEDULE python3 -u /backup/backup.py > /dev/stdout" >> /var/spool/cron/crontabs/root

echo "Idle... Waiting for cron"

exec "$@"
