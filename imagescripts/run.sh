#!/usr/bin/env bash

# init vars
POSTSRSD_DIR="${POSTSRSD_DIR:-${ROOT_DIR}/postsrsd}"

SRS_LISTEN_ADDR="${SRS_LISTEN_ADDR:-0.0.0.0}"
SRS_DOMAIN="${SRS_DOMAIN:-example.com}"
SRS_FORWARD_PORT="${SRS_FORWARD_PORT:-10001}"
SRS_REVERSE_PORT="${SRS_REVERSE_PORT:-10002}"
SRS_SEPARATOR="${SRS_SEPARATOR:-=}"
SRS_TIMEOUT="${SRS_TIMEOUT:-1800}"
SRS_SECRET="${SRS_SECRET:-${POSTSRSD_DIR}/postsrsd.secret}"
SRS_PID_FILE="${SRS_PID_FILE:-${POSTSRSD_DIR}/postsrsd.pid}"
RUN_AS="${SRS_RUN_AS}"
CHROOT="${SRS_CHROOT}"
SRS_EXCLUDE_DOMAINS="${SRS_EXCLUDE_DOMAINS}"
SRS_HASHLENGTH="${SRS_HASHLENGTH:-4}"
SRS_HASHMIN="${SRS_HASHMIN:-4}"

# prepare env vars
if [[ -n "${SRS_DOMAIN}" ]]; then export SRS_DOMAIN; else unset SRS_DOMAIN; fi
if [[ -n "${SRS_FORWARD_PORT}" ]]; then export SRS_FORWARD_PORT; else unset SRS_FORWARD_PORT; fi
if [[ -n "${SRS_REVERSE_PORT}" ]]; then export SRS_REVERSE_PORT; else unset SRS_REVERSE_PORT; fi
if [[ -n "${SRS_SEPARATOR}" ]]; then export SRS_SEPARATOR; else unset SRS_SEPARATOR; fi
if [[ -n "${SRS_TIMEOUT}" ]]; then export SRS_TIMEOUT; else unset SRS_TIMEOUT; fi
if [[ -n "${SRS_SECRET}" ]]; then export SRS_SECRET; else unset SRS_SECRET; fi
if [[ -n "${SRS_PID_FILE}" ]]; then export SRS_PID_FILE; else unset SRS_PID_FILE; fi
if [[ -n "${SRS_RUN_AS}" ]]; then export RUN_AS; fi
if [[ -n "${SRS_CHROOT}" ]]; then export CHROOT; fi
if [[ -n "${SRS_EXCLUDE_DOMAINS}" ]]; then export SRS_EXCLUDE_DOMAINS; else unset SRS_EXCLUDE_DOMAINS; fi
if [[ -n "${SRS_HASHLENGTH}" ]]; then export SRS_HASHLENGTH; else unset SRS_HASHLENGTH; fi
if [[ -n "${SRS_HASHMIN}" ]]; then export SRS_HASHMIN; else unset SRS_HASHMIN; fi

# prepare postsrsd
rm -rf /etc/postsrsd
cd "${POSTSRSD_DIR}"
echo $(cat /dev/urandom | tr -dc 'a-nA-n0-9' | fold -w 32 | head -n 1) > "${SRS_SECRET}"

exec postsrsd -e -l "${SRS_LISTEN_ADDR}"
