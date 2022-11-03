#!/bin/sh
exec podman run -it --rm \
  -v $PWD/data:/data \
  -p 8000:80 \
  -e AWS_ACCESS_KEY_ID=minioadmin \
  -e AWS_SECRET_ACCESS_KEY=minioadmin \
  django-cms-quickstart "$@"
