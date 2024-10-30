FROM python:3.13-slim

RUN /usr/sbin/useradd --create-home --shell /bin/bash --user-group python

USER python
RUN /usr/local/bin/python -m venv /home/python/venv

COPY --chown=python:python requirements.txt /home/python/four-oh-four/requirements.txt
RUN /home/python/venv/bin/pip install --no-cache-dir --requirement /home/python/four-oh-four/requirements.txt

ENV APP_VERSION="2024.1" \
    PATH="/home/python/venv/bin:${PATH}" \
    PYTHONDONTWRITEBYTECODE="1" \
    PYTHONUNBUFFERED="1" \
    TZ="Etc/UTC"

LABEL org.opencontainers.image.authors="William Jackson <william@subtlecoolness.com>" \
      org.opencontainers.image.source="https://github.com/williamjacksn/four-oh-four" \
      org.opencontainers.image.version="${APP_VERSION}"

ENTRYPOINT ["/usr/local/bin/python", "/four-oh-four/run.py"]

COPY --chown=python:python four_oh_four /home/python/four-oh-four/four_oh_four
COPY --chown=python:python run.py  /home/python/four-oh-four/run.py
