set quiet 

# rsync to dotfiles
to-dot:
        #!/usr/bin/env bash
        if command -v rsync &> /dev/null; then 
                rsync -azP $HOME/.config/hypr configs/.config/ && \
                rsync -azP $HOME/.config/alacritty configs/.config/ && \
                rsync -azP $HOME/.config/bspwm configs/.config/ && \
                rsync -azP $HOME/.config/fish configs/.config/ && \
                rsync -azP $HOME/.config/nvim configs/.config/ && \
                rsync -azP $HOME/.config/polybar configs/.config/ && \
                rsync -azP $HOME/.config/rofi configs/.config/ && \
                rsync -azP $HOME/.config/sxhkd configs/.config/ && \
                rsync -azP $HOME/.config/hypr configs/.config/ && \
                rsync -azP $HOME/.config/waybar configs/.config/ && \
                rsync -azP $HOME/.config/swappy configs/.config/ && \
                rsync -azP $HOME/.config/dunst configs/.config/ && \
                rsync -azP $HOME/.config/yazi configs/.config/ && \
                rsync -azP $HOME/.config/gtk-3.0 configs/.config/ && \
                rsync -azP $HOME/.config/gtk-4.0 configs/.config/ && \
                rsync -azP $HOME/.config/bottom configs/.config/ && \
                rsync -azP $HOME/.config/bat configs/.config/ && \
                # theme
                rsync -azP $HOME/.themes configs/ && \
                # icons
                rsync -azP $HOME/.local/share/icons/Pop configs/icons/ && \
                rsync -azP $HOME/.local/share/icons/Materia-Manjaro-2 configs/icons/ && \
                rsync -azP $HOME/.local/share/icons/breeze_cursors configs/icons/ && \
                # tmux
                rsync -azP $HOME/.tmux.conf configs/tmux/.tmux.conf && \
                # gitconfig
                rsync -azP $HOME/.gitconfig configs/gitconfig/ && \

                # !need sudo,doas
                # sddm
                rsync -azP /usr/share/sddm/themes/sddm-astronaut-theme configs/sddm/ && \
                rsync -azP /usr/lib/sddm/sddm.conf.d configs/sddm/ 
        else
                echo "rsync command not found!"
        fi

# rsync install dotfiles
to-host:
        #!/usr/bin/env bash
        # clone base16shell color
        if [[ ! -d "$HOME/.config/base16-shell" ]]; then
                git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell 
        fi

        if command -v rsync &> /dev/null; then
                rsync -azP configs/.config/alacritty $HOME/.config/ && \
                rsync -azP configs/.config/bspwm $HOME/.config/ && \
                rsync -azP configs/.config/fish $HOME/.config/ && \
                rsync -azP configs/.config/nvim $HOME/.config/ && \
                rsync -azP configs/.config/polybar $HOME/.config/ && \
                rsync -azP configs/.config/rofi $HOME/.config/ && \
                rsync -azP configs/.config/sxhkd $HOME/.config/ && \
                rsync -azP configs/.config/waybar $HOME/.config/ && \
                rsync -azP configs/.config/hypr $HOME/.config/ && \
                rsync -azP configs/.config/swappy $HOME/.config/ && \
                rsync -azP configs/.config/dunst $HOME/.config/ && \
                rsync -azP configs/.config/yazi $HOME/.config/ && \
                rsync -azP configs/.config/gtk-3.0 $HOME/.config/ && \
                rsync -azP configs/.config/gtk-4.0 $HOME/.config/ && \
                rsync -azP configs/.config/bottom $HOME/.config/ && \
                rsync -azP configs/.config/bat $HOME/.config/ && \
                # theme
                rsync -azP configs/.themes $HOME/ && \
                # icon
                # rsync -azP configs/icons/Pop $HOME/.local/share/icons && \
                # rsync -azP configs/icons/breeze_cursors $HOME/.local/share/icons && \
                # rsync -azP configs/icons/Materia-Manjaro-2 $HOME/.local/share/icons && \
                rsync -azP configs/tmux/.tmux.conf $HOME/ 

                # !need sudo,doas
                # sddm look
                # sudo rsync -azP configs/sddm/sddm-astronaut-theme /usr/share/sddm/themes/
                # sudo rsync -azP configs/sddm/sddm.conf.d/ /usr/lib/sddm/sddm.conf.d/
        fi

# rsync install dotfiles for freebsd
to-host-freebsd:
        #!/usr/bin/env bash
        if [[ ! -d "$HOME/.config/base16-shell" ]]; then
                git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell && \
        fi

        if command -v rsync &> /dev/null; then
                # clone base16shell color

                rsync -azP configs/freebsd/.config/fish $HOME/.config/ && \
                rsync -azP configs/freebsd/.config/nvim $HOME/.config/ && \
                rsync -azP configs/.config/bottom $HOME/.config/ && \
                rsync -azP configs/.config/bat $HOME/.config/ && \
                rsync -azP configs/tmux/.tmux.conf $HOME/
        else 
                echo "rsync command not found!"
        fi
# rsync fish config to host manual
to-host-fish $user:
        #!/usr/bin/env bash
        if [[ ! -d "$HOME/.config/base16-shell" ]]; then
                git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
        fi
        if command -v rsync &> /dev/null; then
                if [ "{{user}}" == "root" ]; then
                        sudo rsync -azP configs/.config/fish /root/.config/
                else
                        rsync -azP configs/.config/fish $HOME/.config/
                fi
        else
                echo "rsync command not found!"
        fi
# rsync nvim config to host manual
to-host-nvim $user:
        #!/usr/bin/env bash
        if command -v rsync &> /dev/null; then
                if [ "{{user}}" == "root" ]; then
                        sudo rsync -azP configs/.config/nvim /root/.config/
                else
                        rsync -azP configs/.config/fish $HOME/.config/
                fi
        else
                echo "rsync command not found!"
        fi
# Stow
to-host-stow:
        #!/usr/bin/env bash
        if [[ ! -d "$HOME/.config/base16-shell" ]]; then
                git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell 
        fi
        if command -v stow &> /dev/null; then
                stow -Sv -t ~/.config -d configs/.config/ .
                stow -Sv -t ~/ -d configs/tmux/ .
        fi
# Stow UnLink
to-host-stow-unlink:
        #!/usr/bin/env bash
        if command -v stow &> /dev/null; then
                stow -Dv -t ~/.config -d configs/.config/ .
                stow -Dv -t ~/ -d configs/tmux/ .
        fi
# Stow ReLink
to-host-stow-relink:
        #!/usr/bin/env bash
        if command -v stow &> /dev/null; then
                stow -Rv -t ~/.config -d configs/.config/ .
                stow -Rv -t ~/ -d configs/tmux/ .
        fi
