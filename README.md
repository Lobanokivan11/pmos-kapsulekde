# pmos-kapsulekde

PMOS image for use on Kde Immutable linux 2026 (alpha) via kapsule container engine

## install

```
mkdir -p "/var/lib/kapsule/imports/pmos"
mkdir tmp
cd tmp
wget "https://github.com/Lobanokivan11/pmos-kapsulekde/releases/download/build/version"
wget "https://github.com/Lobanokivan11/pmos-kapsulekde/releases/download/build/rootfs.squashfs"
wget "https://github.com/Lobanokivan11/pmos-kapsulekde/releases/download/build/incus.tar.xz"
sudo cp version /var/lib/kapsule/imports/pmos/version
sudo cp rootfs.squashfs /var/lib/kapsule/imports/pmos/rootfs.squashfs
sudo cp incus.tar.xz /var/lib/kapsule/imports/pmos/incus.tar.xz
cd ~
rm -r tmp
kapsule image import /var/lib/kapsule/imports/pmos/ --alias pmos
kapsule create pmos -i local:pmos
```
