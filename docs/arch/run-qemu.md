#### run qemu 

display packages:
```
paru qemu-ui
or
paru qemu-ui-sdl
```

1. use UEFI boot
uefi located: `/usr/share/edk2-ovmf/x64/OVMF.4m.fd`
virtual disk: `use qcow2`
```
qemu-system-x86_64 -bios [UEFI located] -cdrom [iso file] -m 4G --boot d -drive file=[virtual_disk],format=qcow2 -display sdl
```

2. use BIOS legacy
```
qemu-system-x86_64 -cdrom [iso file] -m 4G --boot d -drive file=[virtual_disk],format=qcow2 -display sdl
```
