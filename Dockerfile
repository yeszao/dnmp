ARG PHP_VERSION
FROM php:${PHP_VERSION}-fpm

ARG PHP_EXTENSIONS
ARG MORE_EXTENSION_INSTALLER
ARG REPLACE_SOURCE_LIST

COPY ./sources.list /tmp/sources.list
COPY ./extensions /tmp/extensions

RUN chmod +x /tmp/extensions/install.sh \
    && bash /tmp/extensions/install.sh
