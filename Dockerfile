FROM python:3.6.12-alpine3.11
MAINTAINER David Teubes

ENV PYTHONUNBUFFERED 1

## dont need this - it's already contained in docker image
#RUN python3 -m venv ./env
#CMD . ./env/bin/activate

COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

RUN mkdir /app
WORKDIR /app
COPY ./app /app

# this is so that the user is not root
RUN adduser -D user
USER user