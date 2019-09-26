ARG NGINX_VERSION
FROM nginx:${NGINX_VERSION}

ARG TZ
ARG NGINX_VERSION
ARG ALPINE_REPOSITORIES
ARG NGINX_INSTALL_APPS

ENV INSTALL_APPS=",${NGINX_INSTALL_APPS},"

RUN if [ "${ALPINE_REPOSITORIES}" != "" ]; then \
        sed -i "s/dl-cdn.alpinelinux.org/${ALPINE_REPOSITORIES}/g" /etc/apk/repositories; \
    fi

RUN if [ -z "${INSTALL_APPS##*,certbot,*}" ]; then \
        echo "---------- Install certbot ----------"; \
        apk add --no-cache certbot; \
    fi

WORKDIR /www
