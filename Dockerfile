FROM python:3.9

WORKDIR /app
COPY requirements.in requirements.txt LICENSE README.md manage.py /app/
COPY backend /app/backend

RUN pip install -r requirements.txt

# https://github.com/etianen/django-s3-storage
# TODO: Add to requirements.in and pin
RUN pip install django-s3-storage

RUN python manage.py collectstatic --noinput

# ENV DATABASE_URL=sqlite:////home/django/sqlite.sqlite
# ENV DEFAULT_STORAGE_DSN=file:///home/django/media/?url=%2Fmedia%2F
# ENV AWS_ACCESS_KEY_ID=
# ENV AWS_SECRET_ACCESS_KEY=

RUN useradd -m django
USER django

CMD [ "/bin/sh", "-c", "python manage.py migrate && uwsgi --http=0.0.0.0:8000 --module=backend.wsgi" ]
