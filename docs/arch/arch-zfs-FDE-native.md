## FDE Native ZFS

1.  create the encrypted zpool
    **[by justin.smithies](https://justine.smithies.me.uk/2024/01/03/installing-void-linux-with-encrypted-root-on-zfs/)**
```
zpool create -f -o ashift=12 \
 -O compression=lz4 \
 -O acltype=posixacl \
 -O xattr=sa \
 -O relatime=on \
 -O encryption=aes-256-gcm \
 -O keylocation=file:///etc/zfs/zroot.key \
 -O keyformat=passphrase \
 -o autotrim=on \
 -m none zroot "/dev/disk/by-id/wwn-0x5000c500deadbeef-part3"
```

create zpool

```
zpool create -f -o ashift=12    \
         -O acltype=posixacl    \
         -O xattr=sa            \
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

2.  create encrypted datasets without keyfile
```
zfs create -o encryption=on -o keyformat=passphrase <nameofzpool>/<nameofdataset>
```
```
zfs create -o mountpoint=none -o encryption=on -o keyformat=passphrase rpool/ROOT
zfs create -o mountpoint=none -o encryption=on -o keyformat=passphrase rpool/data
```

3.  create datasets
```
zfs create -o mountpoint=/ -o canmount=noauto rpool/ROOT/zfs_root
zfs create -o mountpoint=/home rpool/data/home
zfs create -o mountpoint=/var/log  rpool/ROOT/var_log
```

4.  unmount zfs, before pacstrap
```
zfs umount -a
```

5.  zfs pool export
```
zpool export [name of the pool in this case 'rpool']
```

6.  zfs pool import
```
zpool import -d /dev/disk/by-partuuid/[UUID insert here] -R /mnt rpool -N
```

7.  zfs load-key
```
zfs load-key -a
```

8.  mount zfs datasets
```
zfs mount rpool/ROOT/zfs_root
zfs mount -a
```

9.  mount EFI & Boot partition
```
mount --mkdir /dev/vda2 /mnt/boot
mount --mkdir /dev/vda1 /mnt/boot/EFI
```
10. set bootfs, cachefile ZFS 
```
zpool set bootfs=rpool/ROOT/zfs_root rpool
zgenhostid $(hostid)
zpool set cachefile=/etc/zfs/zfs-list.cache rpool
```

zpool get bootfs
```
zpool get bootfs
```

11. populate zfs-list cache
```
mkdir -p /mnt/etc/zfs/
cp -r /etc/zfs/zfs-list.cache /mnt/etc/zfs/
```

12. next pacstrap follow **[arch-zfs.md](https://github.com/Elephant9748/dotfiles/blob/main/docs/arch/arch-zfs.md)**

13. in arch-chroot 
    ```
    arch-chroot /mnt/
    ```
    *   Unlock/Mount at boot time: systemd 
        * unlocking the rpool/data/home datasets using Custom script
        ```
        zfs list -o name,mountpoint,canmount,encryption
        ...............................................
        NAME                 MOUNTPOINT  CANMOUNT  ENCRYPTION
        rpool                none        off       off
        rpool/ROOT           none        on        aes-256-gcm
        rpool/ROOT/var_log   /var/log    on        aes-256-gcm
        rpool/ROOT/zfs_root  /           noauto    aes-256-gcm
        rpool/data           none        on        aes-256-gcm
        rpool/data/home      legacy      noauto    aes-256-gcm
        ```
        * set the mountpoint to legacy to avoid having it mounted by zfs mount -a
        ```
         zfs set mountpoint=legacy rpool/data/home
        ```
        * Ensure that it is in ``/etc/fstab``
        ```
        /etc/fstab
        ...............
        rpool/home         /home           zfs             rw,xattr,posixacl,noauto        0 0
        ```
        * alternatively, you can keep using ZFS mounts if you use both
        ```
        zfs set canmount=noauto rpool/home
        zfs set org.openzfs.systemd:ignore=on rpool/home
        ```
        * create ``/usr/local/bin/mount-zfs-homedir`` dont forget ``chmod +x /usr/local/bin/mount-zfs-homedir``
        ```
        #!/bin/bash
        set -eu
        
        # $PAM_USER will be the username of the user, you can use it for per-user home volumes.
        HOME_VOLUME="rpool/home" 
        
        if [ "$(zfs get keystatus "${HOME_VOLUME}" -Ho value)" != "available" ]; then
          PASSWORD=$(cat -)
          zfs load-key "${HOME_VOLUME}" <<< "$PASSWORD" || continue
        fi
        
        # This will also mount any child datasets, unless they use a different key.
        echo "$(zfs list -rHo name,keystatus,mounted "${HOME_VOLUME}")" | while IFS=$'\t' read -r NAME KEYSTATUS MOUNTED; do
          if [ "${MOUNTED}" != "yes" ] && [ "${KEYSTATUS}" == "available" ]; then
            zfs mount "${NAME}" || true
          fi
        done
        ```
        * add the following line to ``/etc/pam.d/system-auth``
        ```
        /etc/pam.d/system-auth
        ........................
        auth       optional                    pam_exec.so          expose_authtok /usr/local/bin/mount-zfs-homedir
        ```

14. finishing the rest of step follow **[arch-zfs.md](https://github.com/Elephant9748/dotfiles/blob/main/docs/arch/arch-zfs.md)**
