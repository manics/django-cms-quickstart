#!/bin/sh
exec podman run -it --rm \
  -p 8000:8000 \
  -e DATABASE_URL=sqlite:////home/django/sqlite.sqlite \
  -e DEFAULT_STORAGE_DSN=file:///home/django/media/?url=%2Fmedia%2F \
  -e DEBUG=True \
  -e DOMAIN_ALIASES="localhost, 127.0.0.1" \
  -e SECURE_SSL_REDIRECT=False \
  -e AWS_ACCESS_KEY_ID=minioadmin \
  -e AWS_SECRET_ACCESS_KEY=minioadmin \
  django-cms-quickstart "$@"
  # -v $PWD/data:/home/django \
