### linux-hardened
```
paru linux-hardened
```
<p> pick all linux-hardened including docs <p>

### remove previous linux kernel
```
paru -R linux
```
<p>check if listed on /boot </p>
```
exa -la /boot
```

### update grub config
```
grub-mkconfig -o /boot/grub/grub.cfg
```

### reboot
