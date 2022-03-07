FROM alpine:latest
MAINTAINER Endre Sara <endresara@gmail.com>
ARG TARGETARCH

ENV DEBUG="false" \
    RemotePath="mediaefs:" \
    MountPoint="/var/lib/nginx/html" \
    ConfigDir="/config" \
    ConfigName=".rclone.conf" \
    MountCommands="--allow-other --allow-non-empty" \
    UnmountCommands="-u -z"

RUN apk --no-cache upgrade \
    && apk add --no-cache --update ca-certificates fuse fuse-dev curl bash unzip nginx \
    && curl https://rclone.org/install.sh | bash \
    && sed -i 's/return 404;//g' /etc/nginx/http.d/default.conf \
    && rm -rf /tmp/* /var/cache/apk/* /var/lib/apk/lists/*

COPY rootfs/ /

ENTRYPOINT ["/start.sh"]
EXPOSE 80

# Use this docker Options in run
# --cap-add SYS_ADMIN --device /dev/fuse --security-opt apparmor:unconfined
# -v /path/to/config/.rclone.conf:/config/.rclone.conf
# -v /mnt/mediaefs:/mnt/mediaefs:shared
