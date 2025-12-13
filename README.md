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
  
prerequisites `paru -S rsync`  
restore
```
./restore_dotfiles_configs
```
backup
```
./bins/rsync-move-to-dotfiles
```
