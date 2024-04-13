### Step 21: disable Bluetooth and Wi-Fi

> Heads-up: step will take effect after reboot.

#### Disable Bluetooth

```shell
echo "dtoverlay=disable-bt" >> /boot/config.txt
```

#### Disable Wi-Fi (if using ethernet)

```shell
echo "dtoverlay=disable-wifi" >> /boot/config.txt
```

### Step 22: configure sysctl (if network is IPv4-only)

> Heads-up: only run following if network is IPv4-only.

```shell
cp /etc/sysctl.conf /etc/sysctl.conf.backup
cat << "EOF" >> /etc/sysctl.conf
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
EOF
sysctl -p
```
