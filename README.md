### manage configs

> using rsync
prerequisites `paru -S rsync`
restore
```
./restore_dotfiles_arch
```
backup
```
./bins/rsync-move-to-dotfiles-arch
```

> using stow
prerequisites `paru -S stow`
Link
```
stow -Sv -t ~/ -d configs/arch .

stow -Sv -t ~/ -d tmux .
```
Unlink
```
stow -Dv -t ~/ -d configs/arch .
stow -Dv -t ~/ -d tmux .
```
Relink
```
stow -Rv -t ~/ -d configs/arch .
stow -Rv -t ~/ -d tmux .
```
