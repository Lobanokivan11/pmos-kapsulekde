export ROOTFS_DIR="out/pmos-rootfs"
cp setup-rootfs.sh "$ROOTFS_DIR/"
sudo chroot "$ROOTFS_DIR" /bin/sh /setup-rootfs.sh
sudo rm "$ROOTFS_DIR/setup-rootfs.sh"
