### Disable workqueue for increased solid state drive (SSD) performance on LUKS
`/etc/default/grub`
```
rd.luks.options=discard,no_read_workqueue,no_write_workqueue
```
