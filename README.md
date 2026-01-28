Manage configs
-------------
**using stow**  
  
prerequisites `paru -S stow`  
Link
```
stow -Sv -t ~/ -d configs/ .
stow -Sv -t ~/ -d tmux .
```
Unlink
```
stow -Dv -t ~/ -d configs/ .
stow -Dv -t ~/ -d tmux .
```
Relink
```
stow -Rv -t ~/ -d configs/ .
stow -Rv -t ~/ -d tmux .
```

**using rsync**  
  

Available recipes:
    install-dot         # rsync install dotfiles
    install-dot-freebsd # rsync install dotfiles for freebsd
    to-dot              # rsync to dotfiles
prerequisites `paru -S just rsync`  
restore
```
just install-dot
```
backup
```
just to-dot
```
