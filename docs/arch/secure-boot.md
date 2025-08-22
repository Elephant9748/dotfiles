## Secure Boot
1.  Systemd-boot ``Only able to read boot images on EFI supported filesystems (FAT, FAT16, FAT32)``
    - example struture partition
      ```
      Device       Start       End   Sectors Size Type
      /dev/vda1     2048   2099199   2097152   1G EFI System
      /dev/vda2  2099200 167770111 165670912  79G Linux LVM
      ```
    - using ``sbctl`` enrolth microsoft keys
      ```
      paru -S sbctl

      sbctl status
      sbctl create-keys
      sbctl enroll-keys -m
      sbctl status
      sbctl verify

      ```
    - sign kernel & EFI
      ```
      sbctl sign -s /boot/vmlinuz-linux
      sbctl sign -s /boot/EFI/BOOT/BOOTX64.EFI
      ```
