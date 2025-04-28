### Disable workqueue for increased solid state drive (SSD) performance on LUKS
`/etc/default/grub`
```
rd.luks.option=discard,no_read_workqueue,no_write_workqueue
```
