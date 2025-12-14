
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
vda                  253:0    0   80G  0 disk
├─vda1               253:1    0    1G  0 part  /mnt/boot
└─vda2               253:2    0   79G  0 part
  └─luks             254:0    0   79G  0 crypt
    └─vg_nix-lv_root 254:1    0   79G  0 lvm   /mnt
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

