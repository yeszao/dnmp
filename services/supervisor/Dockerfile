ARG ALPINE_VERSION
FROM ${ALPINE_VERSION}
ARG TZ
ARG CONTAINER_PACKAGE_URL


RUN if [ "${CONTAINER_PACKAGE_URL}" != "" ] ; then sed -i "s/dl-cdn.alpinelinux.org/${CONTAINER_PACKAGE_URL}/g" /etc/apk/repositories ; fi

RUN apk update \
	&& apk upgrade \
	&& apk add supervisor \
	&& apk --no-cache add tzdata \
    && cp "/usr/share/zoneinfo/$TZ" /etc/localtime \
    && echo "$TZ" > /etc/timezone \
	&& rm -rf /var/cache/apk/*


WORKDIR /www