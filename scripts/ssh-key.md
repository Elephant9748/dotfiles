### create ssh key
#### !important note try open ssh for server while editing this
```
ssh-keygen -t ed25519 -C "<comment>"
```

### checking key before copying
```
ssh-keygen -l -f <path of key located>
```

### copying ssh pub key
```
ssh-copy-id -i <pub key want to copy> -p <port> <user>@<host>
```


### using local SSH config file
```
Host <name to call>
        HostName <host>
        User <user>
        port <port>
        IdentityFile <located file private key>
```
