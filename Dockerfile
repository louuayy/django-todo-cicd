FROM python:3.11-slim-buster

WORKDIR /app/Django-To-Do-list-with-user-authentication-master

# Install build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends gcc python3-dev libssl-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Collect static files
RUN python manage.py collectstatic --noinput
# Set environment variables
ENV PYTHONUNBUFFERED=1
ENV DJANGO_SETTINGS_MODULE=todo_list.settings

EXPOSE 8000

CMD ["sh", "-c", "python manage.py migrate --noinput && gunicorn --bind 0.0.0.0:8000 Django-To-Do-list-with-user-authentication-master.wsgi"]
