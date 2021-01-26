FROM python:3.7-alpine
MAINTAINER David Teubes

ENV PYTHONUNBUFFERED 1

# dont need this - it's already contained in docker image
#RUN python3 -m venv ./env
#CMD . ./env/bin/activate

COPY ./requirements.txt /requirements.txt
# added dependencies for postgres
RUN apk add --update --no-cache postgresql-client
# added temporary under alias (--virtual .tmp-build-deps) dependencies for postgres
# and to be able to execute the "pip install -r /requirements.txt"
RUN apk add --update --no-cache --virtual .tmp-build-deps \
        gcc libc-dev linux-headers postgresql-dev
# because we have the above, the below will execute fine
RUN pip install -r /requirements.txt
# delete the temporary dependency
RUN apk del .tmp-build-deps

RUN mkdir /app
WORKDIR /app
COPY ./app /app

# this is so that the user is not root
RUN adduser -D user
USER user