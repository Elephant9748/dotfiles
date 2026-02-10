### ZFS on arch

create custom archiso include zfs-dkms, zfs-utils

* install
```
paru archiso
or 
paru archiso-git
paru pacman-contrib
```
* build an modified profile
```
mkdir ~/archlive
cp -r /usr/share/archiso/configs/releng/* ~/archlive
cd archlive
```

* Using self-built ZFS packages from the AUR include the built packages into  ``packages.x86_64``

get *.zst (zfs-dkms,zfs-utils) file then repo add 

some packages build have expired pgp so use ``makepkg --skippgpcheck`` to skip pgp check
```
mkdir zfsrepo
cd zfsrepo
```
* Build individual packages, example:
```
git clone https://aur.archlinux.org/paru-bin.git
cd paru-bin
updpkgsums
makepkg --skippgpcheck
cp *.zst ../
```
```
git clone https://aur.archlinux.org/zfs-dkms-staging-git.git
cd zfs-dkms-staging-git
updpkgsums
makepkg --skippgpcheck
cp *.zst ../
```
```
git clone https://aur.archlinux.org/zfs-utils-staging-git.git
cd zfs-utils-staging-git
updpkgsums
makepkg --skippgpcheck
cp *.zst ../
```
* Repo add

to zfsrepo directory ``~/archlive/zfsrepo``
```
repo-add zfsrepo.db.tar.zst *.zst
```
* Add packages
```
archlive/packages.x86_64
........................


# ZFS With Linux not LTS
# ----------------------

linux-headers
libunwind
zfs-utils-staging-git
zfs-dkms-staging-git

# Other
# -----
paru-bin
pacman
git-delta
```

* add custom local repo ``pacman.conf``
```
archlive/pacman.conf 
.....................
[customrepo]
SigLevel = Optional TrustAll
Server = file:///full/path/to/customrepo
```

* create working directory & output iso directory
```
mkdir ~/archlive/{work,isoout}
```

* add file to image
```
sudo cp /etc/paru.conf archlive/airootfs/etc/
sudo cp /etc/pacman.conf archlive/airootfs/etc/
```

* build custom iso

> [!NOTE]
> **if keep failed build custom repo**: just remove ``work`` directory
```
mkarchiso -v -w /path/to/work_dir -o /path/to/out_dir /path/to/profile/
```

* boot into iso & config ZFS pool, vdev

modprobe
```
modprobe zfs
lsmod | grep -i "zfs"
zpool status
```

disk structure
```
Device       Start       End   Sectors  Size Type
/dev/vda1     2048   1128447   1126400  550M EFI System
/dev/vda2  1128448   3225599   2097152    1G Linux filesystem
/dev/vda3  3225600 167770111 164544512 78.5G Solaris root
```
```
mkfs.fat -F32 /dev/vda1
mkfs.ext4 /dev/vda2
```
> [!NOTE]
> to know sector size 
```
lsblk -td
```

to get uuid disk
```
ls -la /dev/disk/by-partuuid
```

create ZFS pool

> [!INFO]
> to destroy zpool ``zpool destroy [name of the pool or 'rpool']``
```
zpool create -f -o ashift=12    \
         -O acltype=posixacl    \
         -O relatime=on         \
         -O dnodesize=auto      \
         -O normalization=formD \
         -O compression=zstd    \
         -O mountpoint=none     \
         -O canmount=off        \
         -O devices=off         \
         -R /mnt                \
         rpool /dev/disk/by-partuuid/[UUID insert here]
```

create ZFS pool another option 

> [!INFO]
> from jthanio **[YT](https://www.youtube.com/watch?v=kPNcRSSaYQo&t=128s)**
```
zpool create -f -o ashift=12    \
         -O acltype=posixacl    \
         -O relatime=on         \
         -O xattr=sa         \
         -O dnodesize=legacy    \
         -O normalization=formD \
         -O compression=zstd    \
         -O mountpoint=none     \
         -O canmount=off        \
         -O devices=off         \
         -R /mnt                \
         rpool /dev/disk/by-partuuid/[UUID insert here]
```

FDE on ZFS
1.  FDE ZFS **[Native encryption arch wiki](https://wiki.archlinux.org/title/ZFS#Native_encryption)**
    * go to **[arch-zfs-FDE](https://github.com/Elephant9748/dotfiles/blob/main/docs/arch/arch-zfs-FDE-native.md)**
2.  FDE ZFS **[using dm-crypt](https://wiki.archlinux.org/title/ZFS#Encryption_in_ZFS_using_dm-crypt)**

checking zfs 
```
zpool list
zpool status
```

create datasets
```
zfs create -o mountpoint=none rpool/data
zfs create -o mountpoint=none rpool/ROOT
zfs create -o mountpoint=/ -o canmount=noauto rpool/ROOT/genesis_zfs_root
zfs create -o mountpoint=/home rpool/data/home
zfs create -o mountpoint=/var -o canmount=off rpool/var
zfs create rpool/var/log
```

check zfs datasets 
```
zfs list
```

checking mounted zfs
```
zfs get mounted rpool/data/home
```

unmount zfs, simillar to btrfs umount before pacstrap
```
zfs umount -a
```

export zfs pool
```
zpool export [name of the pool in this case 'rpool']
```

remove /mnt/{mount mount}
```
sudo rm -rf /mnt/home
sudo rm -rf /mnt/var
```

import zfs pool
```
zpool import -d /dev/disk/by-partuuid/[UUID insert here] -R /mnt rpool -N
```

mounting zfs datasets
```
zfs mount rpool/ROOT/genesis_zfs_root
zfs mount -a
```

mount EFI & Boot partition
```
mount --mkdir /dev/vda2 /mnt/boot
mount --mkdir /dev/vda1 /mnt/boot/EFI
```

list mountpoint
```
df -hT
```

set bootfs, cachefile ZFS
```
zpool set bootfs=rpool/ROOT/genesis_zfs_root rpool
zgenhostid $(hostid)
zpool set cachefile=/etc/zfs/zfs-list.cache rpool
```

get list bootfs
```
zpool get bootfs
```

populate zfs-list cache
```
mkdir -p /mnt/etc/zfs/
cp -r /etc/zfs/zfs-list.cache /mnt/etc/zfs/
```

* setup arch linux on zfs 

pacstrap

> [!INFO]
> ignore if theres an error fix later
```
pacstrap -K /mnt base base-devel linux linux-headers linux-firmware neovim git openssh networkmanager intel-ucode fish
```

generate fstab
```
genfstab -U -p /mnt >> /mnt/etc/fstab
```

edit fstab uncomment zfs rpool, because zfs recognize it self where it mounted
/mnt/etc/fstab
```
# Static information about the filesystems.
# See fstab(5) for details.

# <file system> <dir> <type> <options> <dump> <pass>
# rpool/ROOT/genesis_zfs_root
# rpool/ROOT/genesis_zfs_root   /               zfs             rw,nodev,xattr,posixacl,casesensitive   0 0

# rpool/data/home
# rpool/data/home       /home           zfs             rw,nodev,xattr,posixacl,casesensitive   0 0

# rpool/var/log
# rpool/var/log         /var/log        zfs             rw,nodev,xattr,posixacl,casesensitive   0 0

# /dev/vda2
UUID=46461e9c-1b9c-4ae0-bdcb-6473c16da41d       /boot           ext4            rw,relatime     0 2

# /dev/vda1
UUID=B046-82D5          /boot/EFI       vfat            rw,relatime,fmask=0022,dmask=0022,codepage=437,iocharset=ascii,shortname=mixed,utf8,errors=remount-ro  0 2
```

* arch-chroot
```
arch-chroot /mnt
```

configure Time 
```
ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
hwclock --systohc
```

configure locale  

edit ``/etc/locale.gen`` and uncomment en_US.UTF-8 UTF-8 
```
locale-gen
```
edit ``/etc/locale.conf``
```
.........................
LANG=en_US.UTF-8
```
edit ``/etc/vconsole.conf``
```
KEYMAP=us
```

configure network 
``/etc/hostname``
```
..................
yourhostname
```
enable service networkmanager
```
systemctl enable NetworkManager
```

configure mirror list ``/etc/pacman.d/zfs_mirrorlist``
```
# Origin Server - Finland
Server = http://archzfs.com/$repo/$arch
# Mirror - Germany
Server = http://mirror.sum7.eu/archlinux/archzfs/$repo/$arch
# Mirror - Germany
Server = http://mirror.sunred.org/archzfs/$repo/$arch
# Mirror - Germany
Server = https://mirror.biocrafting.net/archlinux/archzfs/$repo/$arch
# Mirror - India
Server = https://mirror.in.themindsmaze.com/archzfs/$repo/$arch
# Mirror - Italy
Server = https://mirror.emanuelebertolucci.com/$repo/$arch
# Mirror - US
Server = https://zxcvfdsa.com/archzfs/$repo/$arch
```
configure pacman.conf add ..
```
.
.
.
[archzfs]
Include = /etc/pacman.d/zfs_mirrorlist
.
.
.

```

configure pacman-key

get the key **[Key-ID](https://wiki.archlinux.org/title/Unofficial_user_repositories#archzfs)**
```
wget https://archzfs.com/archzfs.gpg
pacman-key -a archzfs.gpg
```
sign pacman-key
```
pacman-key --lsign-key DDF7DB817396A49B2A2723F7403BD972F75D9D76
pacman -Syy (check if theres a problem)
```

get zfs-linux
```
pacman -S zfs-linux
```

if zfs-linux behind get from AUR **[Binary Kernel Module](https://wiki.archlinux.org/title/ZFS#Binary_kernel_module)**
```
paru zfs-dkms-staging-git 
or
paru zfs-dkms
or
paru zfs-linux
```

configure zfs hook  ``/etc/mkinitcpio.conf`` **[Wiki](https://wiki.archlinux.org/title/Install_Arch_Linux_on_ZFS#zfs_hook)**

add zfs before filesystems hook
```
HOOKS=(base udev autodetect microcode modconf keyboard keymap block zfs filesystems fsck)
```

configure **[zfs dracut](https://github.com/Elephant9748/dotfiles/blob/main/docs/arch/arch-zfs-dracut.md)**

generate mkinitcpio 
```
mkinitcpio -P
```

configure grub 

install
```
paru -S grub efibootmgr
```

edit ``/etc/default/grub`` **[Wiki](https://wiki.archlinux.org/title/Install_Arch_Linux_on_ZFS#zfs_hook)**
```
GRUB_CMDLINE_LINUX="root=ZFS=rpool/ROOT/genesis_zfs_root"
```

grub-install
```
grub-install --target=x86_64-efi --efi-directory=/boot/EFI --bootloader-id=ZFSArch --recheck --removable
```

grub-mkconfig 
```
grub-mkconfig -o /boot/EFI/grub.cfg && grub-mkconfig -o /boot/grub/grub.cfg
```

enable zfs service at boot
```
minimum
---------
systemctl enable zfs.target
systemctl enable zfs-import-cache
systemctl enable zfs-mount
systemctl enable zfs-import.target
---------

systemctl enable zfs-import-cache
systemctl enable zfs-import-scan
systemctl enable zfs-import.target
systemctl enable zfs-mount
systemctl enable zfs-share
systemctl enable zfs-zed
systemctl enable zfs.target
```

* exit arch-chroot
```
umount /mnt/boot/EFI
umount /mnt/boot
zfs umount -a 
zpool export rpool 
reboot
```

* basic simple snapshots

list snapshots
```
zfs list -t snapshot
```
list options
```
zfs list -o name,mountpoint,canmount,encryption
```
create snapshot
```
sudo zfs snapshot rpool/ROOT/genesis_zfs_root@fish_install
```
rollback snapshot
```
sudo zfs rollback rpool/ROOT/genesis_zfs_root@fish_install
```
