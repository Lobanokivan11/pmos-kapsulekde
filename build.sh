#!/bin/bash
set -euo pipefail

ROOTFS_DIR="out/pmos-rootfs"
OUTPUT_DIR="out/postmarketos-kapsule"
mkdir -p "$ROOTFS_DIR"
wget https://dl-cdn.alpinelinux.org/alpine/edge/main/x86_64/apk-tools-static-3.0.6-r0.apk
tar -xzf apk-tools-static-3.0.6-r0.apksbin/apk.static
rm apk-tools-static-3.0.6-r0.apk
sudo ./sbin/apk.static --repository https://dl-cdn.alpinelinux.org/alpine/edge/testing --repository https://dl-cdn.alpinelinux.org/alpine/edge/community --repository https://dl-cdn.alpinelinux.org/alpine/edge/main --update-cache --allow-untrusted --root "$ROOTFS_DIR" --initdb add alpine-base
rm -rf sbin
sudo cp setup-rootfs.sh "$ROOTFS_DIR/"
sudo cp /etc/resolv.conf "$ROOTFS_DIR/etc/resolv.conf"
sudo chroot "$ROOTFS_DIR" /bin/sh /setup-rootfs.sh
sudo rm -f "$ROOTFS_DIR/setup-rootfs.sh"
sudo rm -f "$ROOTFS_DIR/etc/resolv.conf"
./package.sh "$ROOTFS_DIR" "$OUTPUT_DIR" ./kapsule.yaml
