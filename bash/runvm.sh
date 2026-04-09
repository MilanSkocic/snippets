#!/usr/bin/env bash

PROGRAM="runvm"

# qemu-img create -f qcow2 debian.qcow2 32G
# qemu-system-x86_64 -enable-kvm -boot menu=on -m 4G -cpu host -smp 4 -vga virtio -display sdl,gl=on -drive file=debian.qcow2
# qemu-system-x86_64 -enable-kvm -boot menu=on -m 4G -cpu host -smp 4 -vga virtio -display sdl,gl=on -drive file=debian.qcow2 --cdrom debian.iso

COMMAND="$1"

help() {
    echo "Usage: $PROGRAM COMMAND [ARGS]."
    echo "$PROGRAM create NAME SIZE."
    echo "$PROGRAM run NAME [OPTIONS]."
}

if [[ -z "${COMMAND}" ]]; then
    help
    exit 0
fi

case "$COMMAND" in
    "create")
        qemu-img create -f qcow2 $2.qcow2 $3G
        exit 0
        ;;
    "run")
        qemu-system-x86_64 -enable-kvm -boot menu=on -m 4G -cpu host -smp 4 -vga virtio -display sdl,gl=on -drive file=$2.qcow2 $3 $4 $5 $6 $7 $9
        exit 0
        ;;
    *)
        help
        exit 0
        ;;
esac
