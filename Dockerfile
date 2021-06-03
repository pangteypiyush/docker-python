ARG PYTHON_VERSION=3.5

FROM python:${PYTHON_VERSION}-alpine

RUN apk add --no-cache libressl-dev make \
  && if [[ "$PYTHON_VERSION" != "3.5" ]]; then \
    apk add --no-cache --virtual .build-deps gcc musl-dev libffi-dev rust cargo ; \
  else \
    apk add --no-cache --virtual .build-deps gcc musl-dev libffi-dev ; \
  fi \
  && pip install flake8 wheel setuptools pytz cryptography requests cython \
  && apk del .build-deps \
  && rm -rf /root/.cache /root/.cargo