ROOTFS_DIR="$(pwd)/out/pmos-rootfs"
mkdir -p "$ROOTFS_DIR"
wget https://dl-cdn.alpinelinux.org/alpine/edge/main/x86_64/apk-tools-static-3.0.6-r0.apk
tar -xzf apk-tools-static-3.0.6-r0.apksbin/apk.static
rm apk-tools-static-3.0.6-r0.apk
sudo ./sbin/apk.static --repository https://dl-cdn.alpinelinux.org/alpine/edge/testing --repository https://dl-cdn.alpinelinux.org/alpine/edge/community --repository https://dl-cdn.alpinelinux.org/alpine/edge/main --update-cache --allow-untrusted --root "$ROOTFS_DIR" --initdb add alpine-base
rm -rf sbin
