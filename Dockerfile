ARG PHP_VERSION
FROM php:${PHP_VERSION}-fpm-alpine

ARG PHP_EXTENSIONS
ARG MORE_EXTENSION_INSTALLER
ARG ALPINE_REPOSITORIES

COPY ./extensions /tmp/extensions
WORKDIR /tmp/extensions

ENV EXTENSIONS=",${PHP_EXTENSIONS},"
ENV MC="-j$(nproc)"

RUN export MC="-j$(nproc)" \
    && chmod +x install.sh \
    && chmod +x "${MORE_EXTENSION_INSTALLER}" \
    && sh install.sh \
    && sh "${MORE_EXTENSION_INSTALLER}" \
    && rm -rf /tmp/extensions

WORKDIR /var/www/html