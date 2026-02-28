## Manage configs

**using stow**

prerequisites `paru -S stow`  
Link

```
stow -Sv -t ~/.config/ -d configs/.config/ .
stow -Sv -t ~/ -d configs/tmux/ .
```

Unlink

```
stow -Dv -t ~/.config/ -d configs/.config/ .
stow -Dv -t ~/ -d /configs/tmux/ .
```

Relink

```
stow -Rv -t ~/.config/ -d configs/.config/ .
stow -Rv -t ~/ -d configs/tmux/ .
```

**using just**

prerequisites `paru -S just rsync`

list just recipe

```
just -l
```

restore

```
just to-host
```

backup

```
just to-dot
```
