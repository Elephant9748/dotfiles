### Arch ZFS Dracut

install Dracut
```
paru -S dracut
```

edit ``/etc/dracut.conf.d/[optional].conf``
```
hostonly="yes"
force="yes"
early_microcode="yes"
compress="zstd"
# nofsck="yes"
add_dracutmodules+=" btrfs "
omit_dracutmodules+=" brltty "
```

additional kernel parameter dracut [wiki](https://wiki.archlinux.org/title/Dracut#Kernel_command_line_options)
> [!INFO]
> LUKS on a partition already configure at ``/etc/default/grub`` doesnt need ``etc/dracut.conf.d/cmdline.conf``
> LUKS on LVM used below:
```
etc/dracut.conf.d/cmdline.conf
...............................
kernel_cmdline="rd.luks.uuid=luks-f6c738f3-ee64-4633-b6b0-eceddb1bb010 rd.lvm.lv=arch/root rd.lvm.lv=arch/swap root=/dev/arch/root rootfstype=ext4 rootflags=rw,relatime"
```

dracut script

``/usr/local/bin/dracut-install.sh``
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
``/usr/local/bin/dracut-remove.sh``
```
#!/usr/bin/env bash

while read -r line; do
        if [[ "$line" == 'usr/lib/modules/'+([^/])'/pkgbase' ]]; then
                read -r pkgbase < "/${line}"
                rm -f "/boot/vmlinuz-${pkgbase}" "/boot/initramfs-${pkgbase}.img" "/boot/initramfs-${pkgbase}-fallback.img"
        fi
done
```

make executable
```
sudo chmod +x /usr/local/bin/dracut-install.sh
sudo chmod +x /usr/local/bin/dracut-remove.sh
```

creating pacman hooks

dracut hook for dracut-install ``/etc/pacman.d/hooks/90-dracut-install.hook``
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
dracut hook for dracut-remove ``/etc/pacman.d/hooks/60-dracut-remove.hook``
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

dracut hook for zfs-linux ``/etc/pacman.d/hooks/zfslinux.hook``
```
[Trigger]
Operation=Install
Operation=Upgrade
Operation=Remove
Type=Package
# Uncomment the installed NVIDIA package
Target=zfs-linux
#Target=nvidia-open
#Target=nvidia-lts
# If running a different kernel, modify below to match
Target=zfs-linux

[Action]
Description=Updating zfs-linux (dracut)!
Depends=dracut
When=PostTransaction
NeedsTargets
#Exec=/bin/sh -c 'while read -r trg; do case $trg in linux*) exit 0; esac; done; /usr/bin/dracut --no-hostonly /boot/initramfs-linux-fallback.img && /usr/bin/dracut /boot/initramfs-linux.img'
Exec=/bin/sh -c '/usr/bin/dracut --no-hostonly /boot/initramfs-linux-fallback.img && /usr/bin/dracut /boot/initramfs-linux.img'
```

preventing mkinitcpio from creating initramfs 
```
sudo ln -sf /dev/null /etc/pacman.d/hooks/90-mkinitcpio-install.hook
sudo ln -sf /dev/null /etc/pacman.d/hooks/60-mkinitcpio-remove.hook
```
