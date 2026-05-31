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

echo "Building postmarketOS image with mkosi ..."
mkosi --directory="$SCRIPT_DIR" --image="$IMAGE_NAME" build

ROOTFS_DIR="$SCRIPT_DIR/mkosi.output/$IMAGE_NAME"

if [ ! -d "$ROOTFS_DIR" ]; then
    echo "Error: no output for $IMAGE_NAME at $ROOTFS_DIR" >&2
    exit 1
fi

KAPSULE_YAML="$SCRIPT_DIR/$IMAGE_NAME/kapsule.yaml"

echo "Packaging $IMAGE_NAME for Incus ..."
"$SCRIPT_DIR/package-incus.sh" "$ROOTFS_DIR" "$OUTPUT_BASE/$IMAGE_NAME" "$KAPSULE_YAML"

echo "Image $IMAGE_NAME built and packaged successfully."
