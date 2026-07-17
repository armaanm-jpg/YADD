#!/bin/sh
set -e
git clone --depth 1 https://github.com/zen-kernel/zen-kernel.git
cp kernel.config zen-kernel/.config
cd zen-kernel && make olddefconfig && make -j$(nproc) bzImage && cd ..

git clone https://git.busybox.net/busybox
cp busybox.config busybox/.config
cd busybox && make olddefconfig && make -j$(nproc) && make install && cd ..

mkdir -p iso/boot/grub
cp zen-kernel/arch/x86/boot/bzImage iso/boot/
cp grub/grub.cfg iso/boot/grub/
cp initramfs/init busybox/_install/init
chmod +x busybox/_install/init
(cd busybox/_install && find . | cpio -o -H newc | gzip) > iso/boot/initramfs.cpio.gz

grub-mkrescue -o zenshell.iso iso/
