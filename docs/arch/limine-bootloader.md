## Limine on UEFI
### 1. Install ``limine``
```
paru -S limine
```
```bash
mkdir -p /boot/EFI/limine
cp /usr/share/limine/BOOTX64.EFI /boot/EFI/limine/
```

### 2. Configure
#### LVM
add ``/boot/EFI/limine/limine.conf``
```
timeout: 3
wallpaper: boot():/EFI/limine/limine.png
wallpaper_style: centered
backdrop: centered 
remember_last_entry: yes

/+ Arch Linux
        // Linux
                protocol: linux
                path: boot():/vmlinuz-linux
                cmdline: rd.luks.name=DEVICE-UUID=luks-79cf1728 rd.luks.options=no-read-workqueue,no-write-workqueue root=/dev/lvm_vol_group/starfish_root rw loglevel=3 quiet 
                module_path: boot():/initramfs-linux.img
/ Grub Boot Loader
        protocol: efi
        path: boot():/EFI/grub/grubx64.efi
```
#### BTRFS
```
timeout: 3
wallpaper: boot():/EFI/limine/limine.png
wallpaper_style: centered
backdrop: centered
remember_last_entry: yes

/+ Arch Linux
        // Linux
                protocol: linux
                path: boot():/vmlinuz-linux
                cmdline: rd.luks.name=DEVICE-UUID-LUKS=LUKS_NAME root=/dev/mapper/LUKS_NAME rw rootflags=subvol=@ rootfstype=btrfs loglevel=3 quiet
                module_path: boot():/initramfs-linux.img
```

To add chainloader limine on grub ``esp/WHERE the .cfg file`` add this line:
```
menuentry 'Limine Boot Loader' {
    insmod fat
    insmod chain
    if [ x$feature_platform_search_hint = xy ]; then
      search --no-floppy --fs-uuid --set=root --hint-bios=hd1,gpt1 --hint-efi=hd1,gpt1 --hint-baremetal=ahci1,gpt1  8B95-1EF8
    else
      search --no-floppy --fs-uuid --set=root 8B95-1EF8
    fi
    chainloader /EFI/limine/BOOTX64.EFI

}
```
And put limine.conf on /boot
```bash
cp /boot/EFI/limine/limine.conf /boot/
```

### 3. Pacman Hook
add ``/etc/pacman.d/hooks/99-limine.hook``
```
[Trigger]
Operation = Install
Operation = Upgrade
Type = Package
Target = limine              

[Action]
Description = Deploying Limine after upgrade...
When = PostTransaction
Exec = /usr/bin/cp /usr/share/limine/BOOTX64.EFI /boot/EFI/limine/
```

### 4. Add an entry for the boot loader in the NVRAM
```bash
efibootmgr \
  --create \
  --disk /dev/sdX \
  --part Y \
  --label "Arch Linux Limine Boot Loader" \
  --loader '\EFI\limine\BOOTX64.EFI' \
  --unicode
```
``X`` block device name, ``Y`` partition index ESP

Anothery way to set entry for the boot loader using ``UEFI Shell``
> !Use this for some firmware doesnt show boot loader entry created by efibootmgr

``Display device handle``
```
map -t type[,hdd]
```
``To add a boot entry``
```
bcfg boot add 0 fs2:\EFI\limine\BOOTX64.EFI "Arch Linux Boot Loader"
```

