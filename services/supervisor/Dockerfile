ARG ALPINE_VERSION
FROM ${ALPINE_VERSION}
ARG TZ

RUN apk update \
	&& apk upgrade \
	&& apk add supervisor \
	&& apk --no-cache add tzdata \
    && cp "/usr/share/zoneinfo/$TZ" /etc/localtime \
    && echo "$TZ" > /etc/timezone \
	&& rm -rf /var/cache/apk/*


WORKDIR /www