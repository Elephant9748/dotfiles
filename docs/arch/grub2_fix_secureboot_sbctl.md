### secure boot
#### need root (#)
<b>install sbctl</b>
```
paru -S sbctl
```
<b>SecureBoot status</b>
``
sbctl status
``
<b>SecureBoot custom keys</b>
```
sbctl create-keys
```
<b> Enroll your keys with Microsoft keys </b>
```
sbctl enroll-keys -m
```
<b>Signing</b>
```
sbctl verify

sbctl sign -s /esp/vmlinuz-linux
sbctl sign -s /esp/BOOTX64.EFI
```
result verify
```
Verifying file database and EFI images in /boot...
✓ /boot/EFI/cosmicarch/grubx64.efi is signed
✓ /boot/vmlinuz-linux is signed
✗ /boot/grub/x86_64-efi/core.efi is not signed
✗ /boot/grub/x86_64-efi/grub.efi is not signed
```

<b>THE BAD FIX</b>
```
#!/bin/bash

MODS=$(for i in $(awk '/insmod/ {print $2}' /boot/grub/grub.cfg | sort -u); do
  test -f /boot/grub/x86_64-efi/$i.mod && echo $i; done)
grub-install --target=x86_64-efi --efi-directory=/boot \
  --bootloader-id=[Your Bootloader Id] \
  --modules="$MODS" \
  --disable-shim-lock \
  --recheck
# =--------------------------------------------------------------------------=
# THIS is the fix:
sed -i 's/SecureBoot/SecureB00t/' /boot/EFI/[Your Bootloader Id]/grubx64.efi
# =--------------------------------------------------------------------------=
#cp /boot/EFI/[Your Bootloader Id]/grubx64.efi /boot/EFI/[Your Bootloader Id]/bootx64.efi
rm /boot/grub/grubenv

# thanks to --> https://wejn.org/2021/09/fixing-grub-verification-requested-nobody-cares/
```
