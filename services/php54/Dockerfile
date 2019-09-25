ARG PHP_VERSION
FROM ${PHP_VERSION}

ARG TZ
ARG PHP_EXTENSIONS
ARG CONTAINER_PACKAGE_URL


COPY ./extensions /tmp/extensions
WORKDIR /tmp/extensions

RUN chmod +x install.sh \
    && sh install.sh \
    && rm -rf /tmp/extensions

WORKDIR /www
