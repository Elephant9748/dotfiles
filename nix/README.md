
## Flake on fresh install

> [!NOTE]
> - change uuid `/boot`, matched lvm_vol!
> - force upgrade packages: `rm -rf flake.lock` then Flake rebuild 
> - if sometime stuck Flake rebuild / Flake install: comment `#python312` packages

user/host:
```
tracy #qemu vm
```
### Create device block & mount them. ``LVM on Luks`` [Dm-crypt](https://wiki.archlinux.org/title/Dm-crypt/Encrypting_an_entire_system)
```bash 
cgdisk /dev/[your disk]
```
result
```
Part. #     Size        Partition Type            Partition Name
----------------------------------------------------------------
            1007.0 KiB  free space
   1        550.0 MiB   EFI system partition      EFI
   2        1024.0 MiB  Linux filesystem          BOOT
   3        78.5 GiB    Linux LUKS                LUKS
            1007.5 KiB  free space
```
filesystems
```
NAME                  MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINTS
loop0                   7:0    0  1.4G  1 loop  /nix/.ro-store
sr0                    11:0    1  1.5G  0 rom   /iso
vda                   253:0    0   80G  0 disk
├─vda1                253:1    0  550M  0 part  /mnt/boot/EFI
├─vda2                253:2    0    1G  0 part  /mnt/boot
└─vda3                253:3    0 78.5G  0 part
  └─Nix-Luks-ca8d59c4 254:0    0 78.4G  0 crypt
    └─vg_nix-nix_root 254:1    0 78.4G  0 lvm   /mnt 
```
### Generate nixos config
```
nixos-generate-config --root /mnt
```
then adjust configurations at ``hosts/<user>`` directory

### Instruction first install
```bash
sudo -i
nix-env -iA nixos.git
git clone <repo url>
nixos-install --flake .#<user/host> --verbose
reboot
```


### Flake rebuild
> !Make sure UUID device 
```
$ sudo nixos-rebuild switch --flake .#<user/host>
```

### Flake update
```
$ nix flake update
```
### To Enter Chroot
```
nixos-enter
```

#### Other command
```
nix-collect-garbage -d
home-manager generations
nixos-rebuild list-generations
```

