# Install Alpine Linux on a Raspberry PI
## 1. Preparing 2 sdcard
- setup first sdcard as usual using rpi-imager, dd, etc for install media
- setup second sdcard with layout partition:

  ```
  cfdisk
  ...............................................
  | Boot FAT32 256MB | System Partition - BTRFS |
  | W95 FAT32 (LBA)  | Linux                    |
  ...............................................
  ```
## 2. Boot into RPI with first sdcard
- setup interfaces (need internet to get packages)

  ```
  setup-interfaces
  setup-apkrepos
  ```
- setup interfaces (need internet to get packages)

  ```
  apk add e2fsprogs btrfs-progs dosfstools lvm2 lsblk fish neovim cfdisk
  ```
## 3. Partitioning on second sdcard for the installation drive
- asume you create layout partiton using cfdisk, now format disk:

  ```
  mkfs.fat F 32 /dev/sda1
  mkfs.btrfs -L [btrfs label] -f /dev/sda2
  ```
- create btrfs subvolume

  ```
  mount /dev/sda2 /mnt
  btrfs subvolume create /mnt/@
  btrfs subvolume create /mnt/@home
  btrfs subvolume create /mnt/@varlog
  btrfs subvolume create /mnt/@snapshots
  umount /mnt
  mount -o compress=zstd,subvol=@ /dev/sda2 /mnt
  mkdir -p /mnt/home
  mount -o compress=zstd,subvol=@home /dev/sda2 /mnt/home
  mkdir -p /mnt/var/log
  mount -o compress=zstd,subvol=@varlog /dev/sda2 /mnt/var/log
  mkdir -p /mnt/.snapshots
  mount -o compress=zstd,subvol=@snapshots /dev/sda2 /mnt/.snapshots
  mkdir -p /mnt/boot
  mount /dev/sda1 /mnt/boot
  ```
## 4. Setup alpine
      ```
      setup-disk /mnt
      ```
## 5. chroot into /mnt
- setup alpine

  ```
  setup-interfaces
  setup-apkrepos
  setup-hostname
  setup-timezone
  setup-user
  setup-sshd
  ```
- packages that i need:

  ```
  apk upgrade -U -a
  apk add fish neovim btrfs-progs lvm2 zstd e2fsprogs dosfstools util-linux procps git iproute2 lsb-release
  ```
- add modules as kernel parameter ``/boot/cmdline.conf``

  ```
  btrfs-progs
  ```

  example:

  ```
  root=UUID=[your UUID system disk] modules=sd-mod,usb-storage,dm-mod,btrfs quiet rootflags=subvol=@ rootfstype=btrfs
  ```
- add comression zstd

  ```
  apk add zstd
  ```
- enable btrfs-scan packages ``btrfs-progs``

  ```
  rc-update add btrfs-scan boot
  ```
- exit chroot

  ```
  reboot
  ```
- after REBOOT setup-ntp

  ```
  setup-ntp
  ```
## 5. extra
    - [alpine pi graphics](https://wiki.alpinelinux.org/wiki/Raspberry_Pi#Linux_Kernel_Graphics_Modes)
    - [apparmor](https://wiki.alpinelinux.org/wiki/AppArmor)
    - run script at startup using ``local`` service at ``/etc/local.d/``

      ```
      enable at boot local service
      ..............................
      rc-update add local default

      *.start extension will run will be run when the local service started
      .....................................................................

      *.stop extension will run will be stop when the local service stopped
      ....................................................................

      make executable all
      ....................................................................
      chmod +x *.start *.stop
      ```


