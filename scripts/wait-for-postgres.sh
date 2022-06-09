#!/bin/bash

set -e  # If a query exits while having a non-zero status, exit immediately.
set -u  # Consider unset variables as error and exit immediately.

postgres_ready() {
    python << END
import sys
import psycopg2
try:
    psycopg2.connect(
        dbname="${DB_NAME}",
        user="${DB_USER}",
        password="${DB_PWD}",
        host="${DB_HOST}",
        port="${DB_PORT}",
    )
except psycopg2.OperationalError:
    sys.exit(-1)
sys.exit(0)
END
}

until postgres_ready; do
>&2 echo 'Waiting for PostgreSQL to become available...'
sleep 1
done
>&2 echo 'PostgreSQL is available'

exec "$@"
