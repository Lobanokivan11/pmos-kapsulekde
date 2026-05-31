#!/bin/bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ $# -ne 1 ]; then
    echo "Usage: sudo $0 <output-dir>" >&2
    echo "Example: sudo $0 out/" >&2
    exit 1
fi

OUTPUT_BASE="$1"
IMAGE_NAME="pmos"
ROOTFS_DIR="$SCRIPT_DIR/pmos-rootfs"
echo "Building postmarketOS image with mkosi ..."
mkdir -p "$ROOTFS_DIR"
wget https://dl-cdn.alpinelinux.org/alpine/edge/main/x86_64/apk-tools-static-3.0.6-r0.apk
tar -xzf apk-tools-static-3.0.6-r0.apk sbin/apk.static
rm apk-tools-static-3.0.6-r0.apk
sudo ./sbin/apk.static --repository https://dl-cdn.alpinelinux.org/alpine/edge/testing --repository https://dl-cdn.alpinelinux.org/alpine/edge/community --repository https://dl-cdn.alpinelinux.org/alpine/edge/main --update-cache --allow-untrusted --root "$ROOTFS_DIR" --initdb add alpine-base
rm -rf sbin
cp "$SCRIPT_DIR/setup-rootfs.sh" "$ROOTFS_DIR/"
cp /etc/resolv.conf "$ROOTFS_DIR/etc/resolv.conf"
chroot "$ROOTFS_DIR" /bin/sh /setup-rootfs.sh
rm -f "$ROOTFS_DIR/setup-rootfs.sh" "$ROOTFS_DIR/etc/resolv.conf"
mkosi --directory="$SCRIPT_DIR" --image="$IMAGE_NAME" build


if [ ! -d "$ROOTFS_DIR" ]; then
    echo "Error: no output for $IMAGE_NAME at $ROOTFS_DIR" >&2
    exit 1
fi

KAPSULE_YAML="$SCRIPT_DIR/$IMAGE_NAME/kapsule.yaml"

echo "Packaging $IMAGE_NAME for Incus ..."
"$SCRIPT_DIR/package-incus.sh" "$ROOTFS_DIR" "$OUTPUT_BASE/$IMAGE_NAME" "$KAPSULE_YAML"

echo "Image $IMAGE_NAME built and packaged successfully."
