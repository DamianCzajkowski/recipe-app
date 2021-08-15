FROM python:3.8-alpine

ENV PYTHONUNBUFFERED=1

COPY ./code/requirements.txt .
RUN apk add --update --no-cache postgresql-client jpeg-dev
RUN apk add --update --no-cache --virtual .tmp-build-deps \
    gcc libc-dev linux-headers postgresql-dev  musl-dev zlib zlib-dev
RUN pip install -r requirements.txt
RUN apk del .tmp-build-deps

RUN mkdir /code
WORKDIR /code
COPY ./code /code

RUN mkdir -p /vol/web/media
RUN mkdir -p /vol/web/static
RUN adduser -D docker-user
RUN chown -R docker-user:docker-user /code
RUN chown -R docker-user:docker-user /vol/
RUN chmod -R 755 /vol/web
USER docker-user