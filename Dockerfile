ARG PHP_VERSION
FROM php:${PHP_VERSION}-fpm-alpine

ARG TZ
ARG PHP_EXTENSIONS
ARG MORE_EXTENSION_INSTALLER
ARG ALPINE_REPOSITORIES

RUN if [ "${ALPINE_REPOSITORIES}" != "" ]; then \
        sed -i "s/dl-cdn.alpinelinux.org/${ALPINE_REPOSITORIES}/g" /etc/apk/repositories; \
    fi


RUN apk --no-cache add tzdata \
    && cp "/usr/share/zoneinfo/$TZ" /etc/localtime \
    && echo "$TZ" > /etc/timezone


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

ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php

WORKDIR /var/www/html
