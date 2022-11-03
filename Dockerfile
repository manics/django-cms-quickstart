FROM python:3.9

WORKDIR /app
COPY requirements.in requirements.txt LICENSE README.md manage.py /app/
COPY backend /app/backend

RUN pip install -r requirements.txt

# https://github.com/etianen/django-s3-storage
RUN pip install django-s3-storage

RUN python manage.py collectstatic --noinput

ENV DATABASE_URL=sqlite:////data/sqlite.sqlite
# ENV DEFAULT_STORAGE_DSN=file:///data/media/?url=%2Fmedia%2F
ENV DEBUG=True
ENV DOMAIN_ALIASES="localhost, 127.0.0.1"
ENV SECURE_SSL_REDIRECT=False

# ENV AWS_ACCESS_KEY_ID=
# ENV AWS_SECRET_ACCESS_KEY=

VOLUME [ "/data" ]

CMD [ "/bin/sh", "-c", "python manage.py migrate && uwsgi --http=0.0.0.0:80 --module=backend.wsgi" ]
