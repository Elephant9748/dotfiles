### Disable workqueue for increased solid state drive (SSD) performance on LUKS
add parameter in `/etc/default/grub`
```
rd.luks.options=no-read-workqueue,no-write-workqueue
```

### Discard/TRIM support for solid state drives (SSD)
**avoid this if using LUKS 

add parameter in `/etc/default/grub`
```
rd.luks.options=discard
```

### check working
```
sudo dmsetup table
```
