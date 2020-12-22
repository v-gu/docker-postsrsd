## -*- docker-image-name: lisnaz/postsrsd -*-
#
# Dockerfile for postsrsd
#
# need init: true
# random secret file will be generated inside volume ${POSTSRSD_DIR}

FROM lisnaz/alpine:latest
MAINTAINER Vincent Gu <v@vgu.io>

ENV POSTSRSD_DIR                        "${ROOT_DIR}/postsrsd"

ENV SRS_LISTEN_ADDR                     "0.0.0.0"
ENV SRS_FORWARD_PORT                    10001
ENV SRS_REVERSE_PORT                    10002
ENV SRS_DOMAIN                          "example.com"
ENV SRS_SEPARATOR                       "="
ENV SRS_TIMEOUT                         1800
ENV SRS_PID_FILE                        ""
ENV SRS_RUN_AS                          nobody
ENV SRS_CHROOT                          ""
ENV SRS_EXCLUDE_DOMAINS                 ""
ENV SRS_HASHLENGTH                      4
ENV SRS_HASHMIN                         4

# define service ports
EXPOSE $SRS_FORWARD_PORT/tcp \
       $SRS_REVERSE_PORT/tcp

# install software stack
RUN set -ex && \
    DEP='postsrsd' && \
    apk add --update --no-cache $DEP && \
    rm -rf /var/cache/apk/*

VOLUME "${POSTSRSD_DIR}"
