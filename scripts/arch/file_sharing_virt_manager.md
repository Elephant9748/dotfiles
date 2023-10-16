### Host

create sharing directory:
```
sudo mkdir /mnt/vfs_share
sudo chown foo:foo  /mnt/vfs_share
```

virt manager qemu :
1. show virt manager detail
2. add hardware filesystem
3. driver: `virstiofs`, source path: `/mnt/vfs_share', target path: `share`

### Guest

create sharing folder
```
mkdir ~/share
```

mount directory
```
sudo mount -t virtiofs share /mnt/share
```

mount to fstab:
```
share   /home/foo/share       virtiofs        defaults        0       0
```
