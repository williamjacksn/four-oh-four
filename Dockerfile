FROM python:3.11.3-alpine3.18

COPY requirements.txt /four-oh-four/requirements.txt

RUN /sbin/apk add --no-cache libpq
RUN /usr/local/bin/pip install --no-cache-dir --requirement /four-oh-four/requirements.txt

ENV APP_VERSION="2021.1" \
    PYTHONUNBUFFERED="1"

LABEL org.opencontainers.image.authors="William Jackson <william@subtlecoolness.com>" \
      org.opencontainers.image.version="${APP_VERSION}"

ENTRYPOINT ["/usr/local/bin/python"]
CMD ["/four-oh-four/run.py"]

COPY . /four-oh-four
