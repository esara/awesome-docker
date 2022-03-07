FROM alpine:latest
MAINTAINER Endre Sara <endresara@gmail.com>
ARG TARGETARCH

ENV DEBUG="false" \
    SERVERPATH="//192.168.1.1/example" \
    MOUNTPOINT="/var/lib/nginx/html" \
    MOUNTOPTIONS="vers=2.0,uid=1000,gid=1000,rw,user=user,pass=example" \
    UMOUNTOPTIONS="-a -t cifs -l"

RUN apk --no-cache upgrade \
    && apk add --no-cache --update cifs-utils bash tar curl ca-certificates grep nginx xz \
    && sed -i 's/return 404;//g' /etc/nginx/http.d/default.conf \
    && rm -rf /tmp/* /var/cache/apk/* /var/lib/apk/lists/*

# add local files
COPY rootfs/ /

ENTRYPOINT ["/start.sh"]
EXPOSE 80

# HEALTHCHECK --interval=5s --timeout=2s --retries=20 CMD /healthcheck.sh || exit 1
# Use this args in docker run
# --cap-add SYS_ADMIN --cap-add DAC_READ_SEARCH --security-opt apparmor:unconfined
