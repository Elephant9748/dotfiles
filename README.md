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

**using just**  

prerequisites `paru -S just rsync`  

list just recipe
```
just -l
```
restore
```
just install-dot
```
backup
```
just to-dot
```
