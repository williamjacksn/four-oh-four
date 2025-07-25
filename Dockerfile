FROM ghcr.io/astral-sh/uv:0.8.3-bookworm-slim

RUN /usr/sbin/useradd --create-home --shell /bin/bash --user-group python
USER python

WORKDIR /app
COPY --chown=python:python .python-version pyproject.toml uv.lock ./
RUN /usr/local/bin/uv sync --frozen

ENV APP_VERSION="2024.1" \
    PYTHONDONTWRITEBYTECODE="1" \
    PYTHONUNBUFFERED="1" \
    TZ="Etc/UTC"

LABEL org.opencontainers.image.authors="William Jackson <william@subtlecoolness.com>" \
      org.opencontainers.image.source="https://github.com/williamjacksn/four-oh-four" \
      org.opencontainers.image.version="${APP_VERSION}"

COPY --chown=python:python run.py  ./
COPY --chown=python:python four_oh_four ./four_oh_four

ENTRYPOINT ["/usr/local/bin/uv", "run", "run.py"]
