#!/usr/bin/env bash

set -e  # If a query exits while having a non-zero status, exit immediately.
set -u  # Consider unset variables as error and exit immediately.

groupadd --gid 1001 gunicorn
useradd gunicorn --uid 1001 --gid 1001
[ ! -d "/dci-project-stories/static" ] && mkdir -p /dci-project-stories/static
chown -R gunicorn:gunicorn /dci-project-stories
