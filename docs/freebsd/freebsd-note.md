## Packages need install
``make`` replace ``gmake`` theres no make
```
pkg install bash ripggrep bat fd fish cmake gmake wget gettext curl sudo git pcutils bottom
```
## Installing the Ports Collections
need ``git`` packagegs
```
# git clone --depth 1 https://git.FreeBSD.org/ports.git -b 2023Q1 /usr/ports
```
update
```
# git -C /usr/ports pull
```
install any ports collections
to ``/usr/ports/sysutils/lsof`` pick any ports then
```
make install
```
During installation, a working subdirectory is created which contains all the temporary files used during compilation. Removing this directory saves disk space and minimizes the chance of problems later when upgrading to the newer version of the port:
```
# make clean
===>  Cleaning for lsof-88.d,8
#
```
## Removing Installed Ports
```
# cd /usr/ports/sysutils/lsof
# make deinstall
===>  Deinstalling for sysutils/lsof
===>   Deinstalling
Deinstallation has been requested for the following 1 packages:

	lsof-4.88.d,8

The deinstallation will free 229 kB
[1/1] Deleting lsof-4.88.d,8... done
```

more on **[freebsd handbook](https://docs.freebsd.org/en/books/handbook/ports/)**

## mouse not moving on kvm qemu 
```
pkg install utouch-kmod xf86-input-evdev
```
edit ``/boot/loader.conf`` add:
```
utouch_load="YES"
```
