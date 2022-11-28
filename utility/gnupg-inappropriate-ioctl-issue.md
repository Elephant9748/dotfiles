### first
```
export GPG_TTY=$(tty)
```

### second
add this to ~/.gnupg/gpg.conf
```
use-agent 
pinentry-mode loopback
```
the add this to ~/.gnupg/gpg-agent.conf
```
allow-loopback-pinentry
```

### third
add the first one to .zprofile or .profile
