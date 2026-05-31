#!/bin/sh
apk update
apk upgrade
tee /etc/apk/repositories <<EOF
http://mirror.postmarketos.org/postmarketos/main
http://mirror.postmarketos.org/postmarketos/extra-repos/systemd/main
http://dl-cdn.alpinelinux.org/alpine/edge/main
http://dl-cdn.alpinelinux.org/alpine/edge/community
http://dl-cdn.alpinelinux.org/alpine/edge/testing
EOF
apk add -u --allow-untrusted postmarketos-keys
apk add postmarketos-base postmarketos-base-systemd
apk update
apk upgrade
