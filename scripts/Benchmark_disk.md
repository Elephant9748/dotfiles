## Test Write Speed
<p>run</p>
```
sync; dd if=/dev/zero of=/path/to/tempfile bs=1M count=1024; sync
```
## Test Read Speed
<p>run</p>
```
dd if=/path/to/tempfile of=/dev/null bs=1M count=1024
```
## Clear the cache and accurately measure the real READ speed directly from the disk:
```
sudo /sbin/sysctl -w vm.drop_caches=3
```
```
dd if=tempfile of=/dev/null bs=1M count=1024
```



## hdparm
```
sudo hdparm -Tt /dev/sda
```
