## crypttab unlock luks at boot not in initramfs
1.  Edit ``/etc/crypttab``
    ```
    # Configuration for encrypted block devices.
    # See crypttab(5) for details.

    # NOTE: Do not list your root (/) partition here, it must be set up
    #       beforehand by the initramfs (/etc/mkinitcpio.conf).

    # <name>       <device>                                     <password>              <options>
    # home         UUID=b8ad5c18-f445-495d-9095-c9ec4f9d2f37    /etc/mypassword1
    # data1        /dev/sda3                                    /etc/mypassword2
    # data2        /dev/sda5                                    /etc/cryptfs.key
    # swap         /dev/sdx4                                    /dev/urandom            swap,cipher=aes-cbc-essiv:sha256,size=256
    # vol          /dev/sdb7                                    none

    luks_external_c44b9b6e  UUID=c44b9b6e-c1f2-45dd-bd83-0fc11dc01405       none noauto
    ```
2.  Generate systemd cryptsetup
    ```
    systemctl daemon-reload
    systemctl start systemd-cryptsetup@luks_external_c44b9b6e.service
    systemctl enable systemd-cryptsetup@luks_external_c44b9b6e.service
    ```
    - Tips if service doesnt want to enable
      ```
      sudo cp /run/systemd/generator/systemd-cryptsetup@luks_external_c44b9b6e.service /usr/lib/systemd/system/luks_external_c44b9b6e.service
      ```
      edit ``/usr/lib/systemd/system/luks_external_c44b9b6e.service`` add:
      ```
      [Install]
      WantedBy = multi-user.target
      ```
3.  Now you can mount in ``/etc/fstab``
    ```
    # EXternal Luks Mount
    UUID=[uuid of /dev/mapper/(luks name)] /mnt/luks-ext ext4
    ```
> [!NOTE]
> password prompt are cached in the kernel keyring by ``systemd-cryptsetup``
> crypttab uses a previously entered password

## crypttab using keyfile
1.  Create keyfile, format, & open
    ```
    dd bs=512 count=4 if=/dev/random of=[path of key file] iflag=fullblock 
    cryptsetup luksFormat /dev/vdc1 blank.key
    cryptsetup open /dev/vdc1 blank_luks --key-file [path of key file]
    mkfs.ext4 /dev/mapper/blank_luks
    ```
2.  Edit ``/etc/crypttab``
    ```
    luks_external_5098c414  UUID=5098c414-cdf5-48c8-8d66-d2bc2b558f48   /root/blank.key noauto
    ```
3.  Edit ``/etc/fstab``
    ```
    UUID=5098c414-cdf5-48c8-8d66-d2bc2b558f48 /mnt/luks-external2 ext4
    ```
4.  Generate systemd cryptsetup
    ```
    systemctl daemon-reload
    systemctl start systemd-cryptsetup@luks_external_5098c414.service
    systemctl enable systemd-cryptsetup@luks_external_5098c414.service
    ```
    - Tips if service doesnt want to enable
      ```
      sudo cp /run/systemd/generator/systemd-cryptsetup@luks_external_5098c414.service /usr/lib/systemd/system/luks_external_5098c414.service
      ```
      edit ``/usr/lib/systemd/system/luks_external_5098c414.service`` add:
      ```
      [Install]
      WantedBy = multi-user.target
      ```
    
