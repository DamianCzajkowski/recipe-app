FROM python:3

ENV PYTHONUNBUFFERED=1

COPY ./code/requirements.txt .
RUN pip install -r requirements.txt

RUN mkdir /code
WORKDIR /code
COPY ./code /code

RUN useradd -ms /bin/bash docker-user
RUN chown -R docker-user:docker-user /code
USER docker-user