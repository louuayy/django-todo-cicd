#!/bin/bash
echo "Running migrations..."
python manage.py migrate --noinput
echo "Starting Gunicorn..."
exec gunicorn --bind 0.0.0.0:8000 todo_list.wsgi