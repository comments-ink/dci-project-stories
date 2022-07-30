#!/bin/bash

set -e  # If a query exits while having a non-zero status, exit immediately.
set -u  # Consider unset variables as error and exit immediately.

python -m compileall project_stories
export DJANGO_SETTINGS_MODULE=project_stories.settings
python manage.py collectstatic --no-input
gunicorn --bind :8000 --workers 1 project_stories.wsgi