FROM python:3.8.2-alpine3.11

COPY requirements.txt /four-oh-four/requirements.txt

RUN /sbin/apk add --no-cache --virtual .deps gcc musl-dev postgresql-dev \
 && /sbin/apk add --no-cache libpq \
 && /usr/local/bin/pip install --no-cache-dir --requirement /four-oh-four/requirements.txt \
 && /sbin/apk del --no-cache .deps

ENV APP_VERSION="2020.0" \
    PYTHONUNBUFFERED="1"

LABEL org.opencontainers.image.authors="William Jackson <william@subtlecoolness.com>" \
      org.opencontainers.image.version="${APP_VERSION}"

ENTRYPOINT ["/usr/local/bin/python"]
CMD ["/four-oh-four/run.py"]

COPY . /four-oh-four
