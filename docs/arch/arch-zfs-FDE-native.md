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
    zfs structure for this example
    ```
    NAME                 MOUNTPOINT  CANMOUNT  ENCRYPTION
    rpool                none        off       off
    rpool/ROOT           none        on        aes-256-gcm
    rpool/ROOT/var_log   /var/log    on        aes-256-gcm
    rpool/ROOT/zfs_root  /           noauto    aes-256-gcm
    rpool/data           none        on        aes-256-gcm
    rpool/data/home      /home       noauto    aes-256-gcm
    ```
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
    *   unlock mounting encrypted zfs other datasets at boot (unlocking all key), 
        create ``/etc/systemd/system/zfs-load-key.service`` or go **[arch wiki](https://wiki.archlinux.org/title/ZFS#Unlock/Mount_at_boot_time:_systemd)**
        ```
        [Unit]
        Description=Load ZFS encryption keys
        DefaultDependencies=no
        After=zfs-import.target
        Before=zfs-mount.service

        [Service]
        Type=oneshot
        RemainAfterExit=yes
        # ExecStart=/usr/sbin/zfs load-key -a
        ExecStart=/usr/bin/zfs load-key -a
        StandardInput=tty-force

        [Install]
        WantedBy=zfs-mount.service
        ```
        enable systemd zfs load-key
        ```
        systemctl enable zfs-load-key.service
        ```
        additional at ``/usr/lib/systemd/system/zfs-import-cache.service`` edit to
> [!NOTE]
> To import a pool with keys, one needs to specify the -l flag, 
> without this flag encrypted datasets will be left unavailable until the keys are loaded. See #Importing a pool created by id.
        ```
        .
        .
        ExecStart=/usr/bin/zpool import -l -c /etc/zfs/zpool.cache -aN $ZPOOL_IMPORT_OPTS
        .
        .
        ```
        if using dracut for some reason doesnt mount the correct datasets edit at ``/etc/systemd/system/zfs-load-key.service``
        ```
        .
        .
        ExecStart=/bin/sh -c '/usr/sbin/zfs load-key -a && /usr/sbin/zfs mount [zfs pool here]/[corresponding datasets to be mounted]'
        .
        .
        ```
    *   Unlock at login time:PAM **[arch wiki](https://wiki.archlinux.org/title/ZFS#Unlock_at_login_time:_PAM)**

14. finishing the rest of step follow **[arch-zfs.md](https://github.com/Elephant9748/dotfiles/blob/main/docs/arch/arch-zfs.md)**
