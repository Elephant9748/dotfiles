## Apparmor profiles for manpage 
Edit ``/etc/apparmor.d/usr.bin.man``
```
# Last Modified: Mon Dec  1 22:15:18 2014

# ------------------------------------------------------------------
#
#    Copyright (C) 2002-2005 Novell/SUSE
#
#    This program is free software; you can redistribute it and/or
#    modify it under the terms of version 2 of the GNU General Public
#    License published by the Free Software Foundation.
#
# ------------------------------------------------------------------
# vim:syntax=apparmor
#

abi <abi/3.0>,

include <tunables/global>

/usr/bin/man {
  include <abstractions/base>
  include <abstractions/nameservice>
  include <abstractions/user-manpages>
  include <abstractions/bash>

  capability setgid,
  capability setuid,

  /bin/less rix,
  /usr/bin/less rix,
  /etc/man_db.conf r,
  /home/*/.lesshst rw,
  /opt/java/jre/man/ r,
  /opt/java/jre/man/* rk,
  /opt/java/man/ r,
  /opt/java/man/* rk,
  /opt/java/man/*/ r,
  /opt/kde/man/ r,
  /opt/kde/man/*/ r,
  /opt/qt/man/ r,
  /opt/qt/man/* rk,
  /opt/qt/man/*/ r,
  /root/.lesshst rw,
  /usr/bin/groff rix,
  /usr/bin/locale rix,
  /usr/bin/nroff rix,
  /usr/bin/troff rix,
  /usr/bin/grotty rix,
  /usr/bin/preconv rix,
  /usr/bin/tbl rix,
  /usr/lib/man-db/man Px,
  /usr/local/man/ r,
  /usr/man/ r,
  /usr/share/** r,
  /var/cache/man/** rk,

  # Site-specific additions and overrides. See local/README for details.
  include if exists <local/usr.bin.man>
}

```
### Enable apparmor profiles
```bash
sudo-rs apparmor_parser /etc/apparmor.d/usr.bin.man
```
### Disabled apparmor profiles
```bash
sudo-rs apparmor_parser -R /etc/apparmor.d/usr.bin.man
```
### Reload apparmor profiles
```bash
sudo-rs apparmor_parser -r /etc/apparmor.d/usr.bin.man
```
