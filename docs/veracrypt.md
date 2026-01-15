## Veracrypt 

### Create outer volume
```
veracrypt -t -c
```
### Create hidden volume
```
veracrypt -t -c [FILE_BIN or /dev/..] --encryption [ALGO for cascade alog: "AES-Twofish"] --filesystem [FILESYSTEM] --hash [HASH ALGO] --random-source /dev/urandom --volume-type hidden
 --size [Hidden size from outer volume]
```
### Mount only prompt password
```
veracrypt -t -k "" --pim=0 --protect-hidden=no [FILE BIN or /dev/..] [MOUNT POINT]
```
### Mount only prompt password with --protect-hidden
```
veracrypt -t -k "" --pim=0 --protect-hidden=yes [FILE BIN or /dev/..] [MOUNT POINT]
```
### Umount 
```
veracrypt -d /dev/..
or
veracrypt -d [MOUNT POINT]
```
