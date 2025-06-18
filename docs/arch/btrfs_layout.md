### layout arch-btrfs
```
subvolid=5
  |
  ├── @ -|
  |     contained directories:
  |       ├── /usr
  |       ├── /bin
  |       ├── /.snapshots
  |       ├── ...
  |
  ├── @home
  ├── @snapshots
  ├── @var_log
  └── @...
```
### layout boot-btrfs
```
subvolid=5
  |
  ├── @ -|
  |     contained directories:
  |       ├── /usr
  |       ├── /bin
  |       ├── /.snapshots
  |       ├── ...
  |
  ├── @home
```

### block layout 
```
/dev/vda    254:0    0   80G  0 disk
├─/dev/vda1 254:1    0  550M  0 part /boot/EFI
├─/dev/vda2 254:2    0    1G  0 part /boot
└─/dev/vda3 254:3    0 78.5G  0 part /var/log
                                     /home
                                     /.snapshots
                                     /
```

#### setup manual installation on archlinux
```
for gpt
---------------------------
cgdisk /dev/[block device]

EFI ef00
Linux Filesystem 8300
Linux Filesystem 8300
---------------------------

for mbr
---------------------------
cfdisk /dev/[block device]

EFI ef00
Linux Filesystem 8300
Linux Filesystem 8300
---------------------------

mount btrfs file system to /mnt 
cd /mnt
create btrfs subvolume 
umount -R /mnt

remount subvolume
-----------------
mount -o compress=zstd,subvol=[subvol] /dev/[deviceblock] /[mounted to]
```

#### for snapshot use
```
grub-btrfs
snapper
```

##### next step follo arch wiki
`...`
