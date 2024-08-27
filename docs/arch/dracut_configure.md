### dracut config lvm on luks

/etc/dracut.conf.d/[optional].conf
```
kernel_cmdline="rd.luks.uuid=luks-UUID_THE_DRIVE rd.lvm.lv=MyVg/MyLv root=/dev/mapper/MyVg/MyLv rootfstype=ext4 rootflags=rw,relatime rd.vconsole.keymap=us rd.locale.LANG=en_US.UTF-8"
```
/etc/dracut.conf.d/cmdline.conf
```
hostonly="yes"
force="yes"
early_microcode="yes"
compress="zstd"
add_dracutmodules+=" crypt lvm udev-rules "
force_drivers+=" nvidia nvidia_modeset nvidia_uvm nvidia_drm "
omit_dracutmodules+=" brltty "
```

<b>dracut script</b>
/usr/local/bin/dracut-install.sh
```
#!/usr/bin/env bash

args=('--force' '--no-hostonly-cmdline')

while read -r line; do
        if [[ "$line" == 'usr/lib/modules/'+([^/])'/pkgbase' ]]; then
                read -r pkgbase < "/${line}"
                kver="${line#'usr/lib/modules/'}"
                kver="${kver%'/pkgbase'}"

                install -Dm0644 "/${line%'/pkgbase'}/vmlinuz" "/boot/vmlinuz-${pkgbase}"
                dracut "${args[@]}" --hostonly "/boot/initramfs-${pkgbase}.img" --kver "$kver"
                dracut "${args[@]}" --no-hostonly "/boot/initramfs-${pkgbase}-fallback.img" --kver "$kver"
        fi
done
```
/usr/local/bin/dracut-remove.sh
```
#!/usr/bin/env bash

while read -r line; do
        if [[ "$line" == 'usr/lib/modules/'+([^/])'/pkgbase' ]]; then
                read -r pkgbase < "/${line}"
                rm -f "/boot/vmlinuz-${pkgbase}" "/boot/initramfs-${pkgbase}.img" "/boot/initramfs-${pkgbase}-fallback.img"
        fi
done
```

root (#)!
```
chmod +x /usr/local/bin/dracut-install.sh
chmod +x /usr/local/bin/dracut-remove.sh
```

<b>pacman hooks</b>
etc/pacman.d/hooks/nvidia.hooks
```
[Trigger]
Operation=Install
Operation=Upgrade
Operation=Remove
Type=Package
# Uncomment the installed NVIDIA package
Target=nvidia
#Target=nvidia-open
#Target=nvidia-lts
# If running a different kernel, modify below to match
Target=linux

[Action]
Description=Updating NVIDIA module in initcpio (dracut)!
Depends=dracut
When=PostTransaction
NeedsTargets
#Exec=/bin/sh -c 'while read -r trg; do case $trg in linux*) exit 0; esac; done; /usr/bin/dracut --no-hostonly /boot/initramfs-linux-fallback.img && /usr/bin/dracut /boot/initramfs-linux.img'
Exec=/bin/sh -c '/usr/bin/dracut --no-hostonly /boot/initramfs-linux-fallback.img && /usr/bin/dracut /boot/initramfs-linux.img'
```
/etc/pacman.d/hooks/60-dracut-remove.hook
```
[Trigger]
Type = Path
Operation = Remove
Target = usr/lib/modules/*/pkgbase

[Action]
Description = Removing linux initcpios...
When = PreTransaction
Exec = /usr/local/bin/dracut-remove.sh
NeedsTargets
```
/etc/pacman.d/hooks/90-dracut-install.hook
```
[Trigger]
Type = Path
Operation = Install
Operation = Upgrade
Target = usr/lib/modules/*/pkgbase

[Action]
Description = Updating linux initcpios (with dracut!)...
When = PostTransaction
Exec = /usr/local/bin/dracut-install.sh
Depends = dracut
NeedsTargets
```

