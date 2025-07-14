## FDE dm-crypt BTRFS UEFI
1.  Setup device type:
    - ``cgdisk`` for GPT/UEFI, ``cfdisk`` for MBR/BIO
      ```
      cgdisk /dev/[path drive vda,sda, etc]
      ```
    - device type
      ```
      Device       Start       End   Sectors  Size Type
      /dev/vda1     2048   1128447   1126400  550M EFI System
      /dev/vda2  1128448   3225599   2097152    1G Linux filesystem
      /dev/vda3  3225600 167770111 164544512 78.5G Linux filesystem
      ```
    - formating drive for boot & EFI
      ```
      mkfs.fat -F32 /dev/vda1
      mkfs.ext4 /dev/vda2
      ```
    - LUKS on a partition 
      ```
      cryptsetup -v luksFormat /dev/vd3
      cryptsetup open /dev/vda3 lukscrypt
      ```
    - formating btrfs make **[btrfs-progs](https://archlinux.org/packages/?name=btrfs-progs)** is installed
      ```
      mkfs.btrfs -L [your label optional] /dev/mapper/lukscrypt
      ```
    - creating subvolume btrfs
      ```
      mount /dev/mapper/lukscrypt /mnt
      cd /mnt
      btrfs subvolume create @
      btrfs subvolume create @home
      btrfs subvolume create @snapshots
      btrfs subvolume create @var_log
      umount -R /mnt
      mount -o compress=zstd,subvol=@ /dev/mapper/lukscrypt /mnt
      mount --mkdir -o compress=zstd,subvol=@home /dev/mapper/lukscrypt /mnt/home
      mount --mkdir -o compress=zstd,subvol=@var_log /dev/mapper/lukscrypt /mnt/var/log
      mount --mkdir -o compress=zstd,subvol=@snapshots /dev/mapper/lukscrypt /mnt/.snapshots
      ```
    - mounting boot & EFI
      ```
      mount --mkdir /dev/vda2 /mnt/boot
      mount --mkdir /dev/vda1 /mnt/boot/EFI
      ```
2.  Setup arch linux
    - increase parallel download by edit ``/etc/pacman.conf``
      ```
      .
      .
      ParallelDownloads = 12 
      .
      .
      ```
    - install packages
      ```
      pacstrap -K /mnt base base-devel linux linux-headers linux-firmware grub efibootmgr btrfs-progs git neovim fish
      ```
    - fstab
      ```
      genfstab -U /mnt >> /mnt/etc/fstab
      ```
    - chroot
      ```
      arch-chroot /mnt
      ```
    - localization
      - ``/etc/locale.gen`` uncomment en_US.UTF-8 UTF-8 then:
        ```
        locale-gen
        ```
      - ``/etc/locale.conf``
        ```
        /etc/locale.conf
        -----------------
        LANG=en_US.UTF-8
        ```
      - ``/etc/vconsole.conf``
        ```
        /etc/vconsole.conf
        -----------------
        KEYMAP=us
        ```
      - ``/etc/hostname``
        ```
        /etc/hostname
        -----------------
        yourhostname
        ```
    - configure sudo
      - add password to root
        ```
        passwd
        ```
      - groupadd sudo
        ```
        groupadd sudo
        ```
      - edit ``/etc/sudoers`` uncoment below:
        ```
        /etc/sudoers
        -----------------
        .
        .
        %sudo ALL=(ALL:ALL) ALL
        .
        .
        ```
      - useradd
        ```
        useradd -G sudo -m [user optional] -s /bin/bash
        passwd [user optional]
        ```
    - initramfs
      ```
      mkinitcpio -P
      ```
3.  Configure bootloader & initramfs to boot on luks
    - initramfs if use dracut **[arch-btrfs-dracut](https://github.com/Elephant9748/dotfiles/blob/main/docs/arch/dracut_configure.md)**
    - configure mkinitcpio **[arch wiki](https://wiki.archlinux.org/title/Dm-crypt/Encrypting_an_entire_system#Configuring_mkinitcpio)** ``/etc/mkinitcpio.conf``
      ```
      HOOKS=(base systemd autodetect microcode modconf kms keyboard sd-vconsole block sd-encrypt filesystems fsck)
      ```
    - configure grub bootloader **[arch wiki](https://wiki.archlinux.org/title/Dm-crypt/Encrypting_an_entire_system#Configuring_the_boot_loader)** edit ``/etc/default/grub``
      ```
      .
      .
      GRUB_CMDLINE_LINUX=rd.luks.name=[device-UUID of the luks block]=lukscrypt root=/dev/mapper/lukscrypt
      GRUB_ENABLE_CRYPTODISK=y
      .
      .
      ```
    - install grub **[arch wiki](https://wiki.archlinux.org/title/GRUB)**
      ```
      grub-install --target=x86_64-efi --efi-directory=/boot/EFI --bootloader-id=arch_btrfs --recheck --removable
      ```
    - grub-mkconfig
      ```
      mkdir -p /boot/EFI/sam
      grub-mkconfig -o /boot/EFI/sam/grub.cfg && grub-mkconfig -o /boot/grub/grub.cfg
      ```
    - get services: network manager, etc
      ```
      pacman -S networkmanager
      systemctl enable NetworkManager
      ```
    - additional btrfs usage **[arch wiki](https://wiki.archlinux.org/title/Btrfs#)**
      - auto snapshots snapper,timeshift,etc for snapshots **[arch wiki](https://wiki.archlinux.org/title/Btrfs#Automatic_snapshots)**
    - finishing
      ```
      exit arch-chroot
      ................
      exit
      umount -R /mnt
      reboot
      ```

      

