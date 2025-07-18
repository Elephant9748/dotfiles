## Apparmor setup
### 1. On Raspberry Pi
- Install
      
   ```
   apk add apparmor apparmor-utils
   ```
- Check security modules
      
  ```
  cat /etc/sys/kernel/security/lsm
  ```
- Add security modules on RPI, edit ``/boot/cmdline.txt``:
      
  ```
  lsm=landlock,yama,apparmor apparmor=1 security=apparmor
  ```
- Service

  ```
  rc-service apparmor start
  rc-update add apparmor boot
  ```
- Status

  ```
  aa-enables
  ```
- Profiles

  ```
  apk add apparmor-profiles
  cp /usr/share/apparmor/extra-profiles/usr.bin.chromium-browser /etc/apparmor.d/
  aa-complain /etc/apparmor.d/usr.bin.chromium-browser
  or
  aa-enforced /etc/apparmor.d/usr.bin.chromium-browser
  ```
- Create additional profiles

  ```
  apk add audit
  rc-service auditd start
  rc-update add  auditd
  aa-easyprof /path/to/binary
  aa-genprof /path/to/binary
  aa-status
  ```
- Note!

  checking log
  ```
  tail -f 25 /var/log/messages
  tail -f 25 /var/log/audit/audit.log
  tail -f 25 /var/log/audit/audit.log | rg "apparmor=\"DENIED\""
  ```



