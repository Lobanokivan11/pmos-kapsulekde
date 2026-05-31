#!/bin/bash
set -euo pipefail


sudo cp setup-rootfs.sh "$ROOTFS_DIR/"
sudo cp /etc/resolv.conf "$ROOTFS_DIR/etc/resolv.conf"
sudo chroot "$ROOTFS_DIR" /bin/sh /setup-rootfs.sh
sudo rm -f "$ROOTFS_DIR/setup-rootfs.sh"
sudo rm -f "$ROOTFS_DIR/etc/resolv.conf"
./package.sh "$ROOTFS_DIR" "$OUTPUT_DIR" ./kapsule.yaml
