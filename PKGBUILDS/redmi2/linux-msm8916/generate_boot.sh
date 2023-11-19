#!/bin/env bash
cat /boot/Image.gz /boot/dtbs/qcom/msm8916-wingtech-wt88047.dtb > /boot/kernel-dtb.bin

root_uuid=$(findmnt --fstab -uno SOURCE /)
mkbootimg \
      --base 0x80000000 \
      --kernel_offset 0x00080000 \
      --ramdisk_offset 0x02000000 \
      --tags_offset 0x01e00000 \
      --pagesize 2048 \
      --second_offset 0x00f00000 \
      --ramdisk /boot/initramfs-linux-msm8916.img \
      --cmdline "console=tty0 root=${root_uuid} rw loglevel=3 splash"\
      --kernel /boot/kernel-dtb.bin -o /boot/boot.img

echo "/boot/boot.img is ready!"

