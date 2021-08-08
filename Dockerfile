FROM python:3.8-alpine

ENV PYTHONUNBUFFERED=1

COPY ./code/requirements.txt .
RUN apk add --update --no-cache postgresql-client
RUN apk add --update --no-cache --virtual .tmp-build-deps \
    gcc libc-dev linux-headers postgresql-dev
RUN pip install -r requirements.txt
RUN apk del .tmp-build-deps

RUN mkdir /code
WORKDIR /code
COPY ./code /code

RUN adduser -D docker-user
RUN chown -R docker-user:docker-user /code
USER docker-user