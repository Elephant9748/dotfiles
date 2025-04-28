### kernel hardening
```
GRUB_CMDLINE_LINUX_DEFAULT="lsm=landlock,lockdown,yama,integrity,apparmor,bpf randomize_kstack_offset=on vsyscall=none loglevel=3 quiet"
```
