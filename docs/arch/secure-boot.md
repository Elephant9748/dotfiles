## Secure Boot
1.  Systemd-boot 
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
