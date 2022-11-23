FROM docker.io/library/python:3.10

WORKDIR /app
COPY requirements.in requirements.txt LICENSE README.md manage.py /app/
COPY backend /app/backend

RUN pip install -r requirements.txt

RUN useradd -m django && \
    mkdir staticfiles_collected && \
    chown django staticfiles_collected
USER django

CMD [ "/bin/sh", "-c", "python manage.py collectstatic --noinput && python manage.py migrate && uwsgi --http=0.0.0.0:8000 --module=backend.wsgi" ]
