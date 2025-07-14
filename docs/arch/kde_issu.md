## KDE kwin plasma issue I/O read/write
move it from disk to ram or another fast drive

symlink .cache/kwin to tmpfs
```
sudo ln -s .cache/kwin /tmp
or
sudo ln -s .cache/kwin /var/run
or
sudo ln -s .cache/kwin /var/lock
```

## kde wont startwayland ``dbus-run-sesions`` issue on ZFS filesystem
Can't mount path /run/user/1000/doc
```
dbus-run-sesions startplasma-wayland
```
