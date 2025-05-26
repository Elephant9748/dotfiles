#### solved multiple ip captive portal
check ip
```
ip a
or
ip addr show wlan0 | rg -i "inet"
```
by delete ip addresses
```
ip addr del [ip address]/[subnet] dev wlan0
```

then relogin with single ip
