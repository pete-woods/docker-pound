FROM alpine:3.7

RUN addgroup -S pound \
	&& adduser -D -S -h /var/cache/pound -s /sbin/nologin -G pound pound \
	&& apk add --no-cache \
        pound

COPY docker-entrypoint.sh /opt/

ENV REWRITE_LOCATION '0'

ENV SERVER_ADDRESS '0.0.0.0'
ENV SERVER_PORT '8000'
ENV SERVER_XHTTP: '1'
ENV LOG_LEVEL '4'

ENV LOGIN_FILTER "login.*"
ENV LOGIN_ADDRESS '127.0.0.1 127.0.0.2'
ENV LOGIN_PORT '8080'

ENV BACKEND_FILTER '^/(api)'
ENV BACKEND_ADDRESS '127.0.0.3 127.0.0.4'
ENV BACKEND_PORT '8080'

ENV FRONTEND_ADDRESS '127.0.0.5 127.0.0.6'
ENV FRONTEND_PORT '5000'

ENTRYPOINT [ "/opt/docker-entrypoint.sh" ]