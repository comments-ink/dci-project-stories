#!/bin/bash

set -e  # If a query exits while having a non-zero status, exit immediately.
set -u  # Consider unset variables as error and exit immediately.

python manage.py migrate
python manage.py loaddata ../fixtures/sites.json
python manage.py loaddata ../fixtures/users.json
python manage.py loaddata ../fixtures/stories.json
python manage.py loaddata ../fixtures/comments.json
