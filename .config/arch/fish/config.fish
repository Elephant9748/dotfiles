abbr -a yr 'cal -y'
abbr -a c cargo
abbr -a e nvim
abbr -a m make
abbr -a o xdg-open
abbr -a g git
abbr -a gc 'git checkout'
abbr -a ga 'git add -p'
abbr -a vimdiff 'nvim -d'
abbr -a ct 'cargo t'

abbr -a vi 'nvim'
abbr -a vim 'nvim'
abbr -a cle 'clear'
abbr -a cl 'clear'
abbr -a .lua 'cd $HOME/.config/nvim/lua/bigort/'
abbr -a .packer 'nvim $HOME/.config/nvim/lua/bigort/packer.lua'
abbr -a .after 'nvim $HOME/.config/nvim/after/plugin/bigort/init.lua'
abbr -a .bspwm 'nvim $HOME/.config/bspwm/bspwmrc'
abbr -a .sxhkd 'nvim $HOME/.config/sxhkd/sxhkdrc'
abbr -a .fish 'nvim $HOME/.config/fish/config.fish'
abbr -a .alacritty 'nvim $HOME/.config/alacritty/alacritty.toml'
abbr -a .hypr 'nvim $HOME/.config/hypr'
abbr -a .waybar 'nvim $HOME/.config/waybar'
abbr -a .project 'cd $HOME/project'
abbr -a .dotfiles 'cd $HOME/project/dotfiles'
abbr -a .paper 'nvim $HOME/project/paper_backup/src/main.rs'
abbr -a .pinguin 'nvim $HOME/project/pinguin-graphql/src/main.rs'
abbr -a .t 'tmux new -s rigel'
abbr -a .ta 'tmux a'
abbr -a .bwarden 'gpg -d $HOME/.nextcloud/Kleopatra.box/brandon/bwarden-brandon.asc && gpgconf --kill all'
abbr -a gree 'fish_greeting'
abbr -a .bc '$HOME/utility/clear-clipboard-wayland-hyprland'
abbr -a .config 'cd $HOME/.config/'

abbr -a .db_pinguin 'psql -h 192.168.100.144 -p 5432 db_pinguin -U stomp'
abbr -a .nix-list 'nix-env -q'
abbr -a .nix-update 'nix-env -u'
#upgrade nix 
#abbr -a .nix-env-upgrade 'nix-channel --update; nix-env --install --attr nixpkgs.nix nixpkgs.cacert; systemctl daemon-reload; systemctl restart nix-daemon'

abbr -a rpi 'ssh rpi'
abbr -a hive 'ssh hive'
abbr -a rick 'ssh rick'

abbr -a .ipv6_off 'sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1'
abbr -a .ipv6_on 'sudo sysctl -w net.ipv6.conf.all.disable_ipv6=0' # use for gaming

abbr -a neofetch 'fastfetch'
abbr -a start_virtio '$HOME/project/dotfiles/scripts/arch/start-virtio-virtual-machine-QEMU'
abbr -a stop_virtio 'sudo virsh net-destroy default'
abbr -a stop_network 'sudo systemctl stop NetworkManager'
abbr -a start_network 'sudo systemctl start NetworkManager'
abbr -a start_ssh 'sudo systemctl start sshd'
abbr -a stop_ssh 'sudo systemctl stop sshd'


#v4l2loopback
abbr -a v4l2_load 'sudo modprobe v4l2loopback video_nr=2 card_label=v4l2loopback_screen_sharing exclusive_caps=1'
abbr -a v4l2_unload 'sudo modprobe -r v4l2loopback'
abbr -a v4l2_list 'v4l2-ctl --list-devices'

#wf-recorder screen_sharing full screen
abbr -a screen_sharing 'wf-recorder --muxer=v4l2 --codec=rawvideo --file=/dev/video2 -x yuv420p'
#wf-recorder screen_sharing portion of the screen (need install slurp)
abbr -a screen_sharing_portion 'wf-recorder -g "$(slurp)" --muxer=v4l2 --codec=rawvideo --file=/dev/video2 -x yuv420p'

#git
abbr -a gl 'git log --all --decorate --oneline --graph'
abbr -a gs 'git status'

#A cat clone with syntax highlighting https://github.com/sharkdp/bat
if command -v bat > /dev/null
        abbr -a cat 'bat'
        abbr -a bat 'cat'
end


#duplex ethernet speed
abbr -a .duplex1000 'sudo ethtool -s enp4s0 speed 1000 duplex full autoneg on'
abbr -a .duplex100 'sudo ethtool -s enp4s0 speed 1000 duplex full autoneg on'
abbr -a .duplexshow 'sudo ethtool enp4s0'

complete --command aurman --wraps pacman

if status --is-interactive
   clear
   alias ssh="TERM=xterm-256color $(which ssh)"
   #alias ssh="alacritty $(which ssh)"

   export GPG_TTY=$(tty)

   #rust
   export PATH="$HOME/.cargo/bin:$PATH"
   export PATH="$HOME/project/depot_tools:$PATH"

   #Go
   export PATH="$HOME/go/bin:$PATH"

   #pipx PATH
   export PATH="$HOME/.local/bin:$PATH"

   # git clone error RPC failed:curl 56 GnuTLS recv error (-54):Error in the pull function .
   # ```
   # export GIT_TRACE_PACKET=1
   # export GIT_TRACE=1
   # export GIT_CURL_VERBOSE=1
   # ```

   #cosmic
   #export CARGO_HOME="$srcdir/cargo-home"
   #export RUSTUP_TOOLCHAIN=stable


   #pip python venv
   #set PIP_VENV "$HOME/.venv/bin/"
   #source "$PIP_VENV/activate.fish"

   #base16_shell
   set BASE16_SHELL "$HOME/.config/base16-shell/"
   source "$BASE16_SHELL/profile_helper.fish"

   # npm packages
   set NPM_PACKAGES "$HOME/.npm-packages"
   set PATH $PATH $NPM_PACKAGES/bin
   set MANPATH $NPM_PACKAGES/share/man $MANPATH

   #android-platform
   export PATH="$HOME/apps/platform-tools:$PATH"

   # ssh gnome/keyring
   # set SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/gcr/ssh"
   set SSH_AUTH_SOCK ""
   set SSH_AUTH_SOCK (cat $HOME/.ssh/ssh_auth_sock)

   # override color_command
   # set -U fish_color_command 16AA64
   # set -U fish_color_param 7A4DBD

end

if command -v eza > /dev/null
	abbr -a l 'eza'
	abbr -a ls 'eza'
	abbr -a ll 'eza -l'
	abbr -a lll 'eza -la'
    abbr -a nix 'nix-env'
else
	abbr -a l 'ls'
	abbr -a ll 'ls -l'
	abbr -a lll 'ls -la'
    abbr -a vi 'vi'
    abbr -a vim 'vim'
end

if test -f /usr/share/autojump/autojump.fish;
	source /usr/share/autojump/autojump.fish;
end

# Nix shell profiles
if test -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish;
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish;
end
# End Ni

#manual load hyprpaper image
function load_image
        hyprctl hyprpaper preload "~/Pictures/wallhaven.cc/wallhaven-md37wk_1920x1080.png"
        hyprctl hyprpaper wallpaper "HDMI-A-1,~/Pictures/wallhaven.cc/wallhaven-md37wk_1920x1080.png"
end

#ssh-agent start
abbr -a list_ssh_agent 'ps -e | grep \'ssh\' && cat $HOME/.ssh/ssh_auth_sock'
function start_ssh_agent
        eval (ssh-agent -c) 
        ssh-add ~/.ssh/rpi_earendel_ed25519
        ssh-add ~/.ssh/hive_wendy_ed25519
        ssh-add ~/.ssh/rick_phoebe_ed25519
        echo $SSH_AUTH_SOCK > $HOME/.ssh/ssh_auth_sock
        timeout_ssh_agent
end

function stop_ssh_agent
        kill $SSH_AGENT_PID
        cat /dev/null > $HOME/.ssh/ssh_auth_sock
end

function list_ssh_agent
        ps -e | grep 'ssh'
        cat $HOME/.ssh/ssh_auth_sock
end

#timeout
function timeout_ssh_agent
        set delay 3600
        dunstify -u normal "SSH AGENT Timeout: $delay second"
        $HOME/.config/fish/timeout-ssh-agent.fish -t $delay &
end

function timeout_clipboard
        $HOME/.config/fish/timeout-clipboard.fish &
end

#dunst
function stop_dunst
        set dunst_pid (cat $HOME/.config/dunst/dunst_sock)
        if test "$dunst_pid"
                kill $dunst_pid
                cat /dev/null > $HOME/.config/dunst/dunst_sock
        else 
                printf "No Pid available!"
        end
end

function list_dunst
        ps -e | grep 'dunst'
end

# Type - to move up to top parent dir which is a repository
function d
	while test $PWD != "/"
		if test -d .git
			break
		end
		cd ..
	end
end

# Fish git prompt
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate ''
set __fish_git_prompt_showupstream 'none'
set -g fish_prompt_pwd_dir_length 3

# colored man output
# from http://linuxtidbits.wordpress.com/2009/03/23/less-colors-for-man-pages/
setenv LESS_TERMCAP_mb \e'[01;31m'       # begin blinking
setenv LESS_TERMCAP_md \e'[01;38;5;74m'  # begin bold
setenv LESS_TERMCAP_me \e'[0m'           # end mode
setenv LESS_TERMCAP_se \e'[0m'           # end standout-mode
setenv LESS_TERMCAP_so \e'[38;5;246m'    # begin standout-mode - info box
setenv LESS_TERMCAP_ue \e'[0m'           # end underline
setenv LESS_TERMCAP_us \e'[04;38;5;146m' # begin underline

setenv FZF_DEFAULT_COMMAND 'fd --type file --follow'
setenv FZF_CTRL_T_COMMAND 'fd --type file --follow'
setenv FZF_DEFAULT_OPTS '--height 20%'

function fish_user_key_bindings
	bind \cz 'fg>/dev/null ^/dev/null'
	if functions -q fzf_key_bindings
		fzf_key_bindings
	end
end

function fish_prompt
	set_color brblack
	echo -n "["(date "+%H:%M")"] "
    set_color 16AA64
	echo -n (hostnamectl hostname)
	if [ $PWD != $HOME ]
		set_color brblack
		echo -n ':'
		set_color 7A4DBD
		echo -n (basename $PWD)
	end
	set_color 1796B8
	printf '%s ' (__fish_git_prompt)
	set_color B23F61
	echo -n '| '
	set_color normal
end

function fish_greeting
	echo 
	echo -e (uname -ro | awk '{print " \\\\e[1mOS: \\\\e[0;32m"$0"\\\\e[0m"}')
	echo -e (uptime -p | sed 's/^up //' | awk '{print " \\\\e[1mUptime: \\\\e[0;32m"$0"\\\\e[0m"}')                                         # packages procps
	echo -e (uname -n | awk '{print " \\\\e[1mHostname: \\\\e[0;32m"$0"\\\\e[0m"}')                                                         # packages lsb-release
    echo -e (lsb_release -d | awk -F ':' '/Description/ {gsub("\t","",$2);print " \\\\e[1mDescription: \\\\e[0;32m"$2"\\\\e[0m"; exit}')
    echo -e (awk -F ':' '/model name/ {print " \\\\e[1mCPU: \\\\e[0;32m"$2"\\\\e[0m"; exit}' /proc/cpuinfo)
    echo -e (lspci | grep -E "VGA|3D controller" | awk -F ':' '/VGA/ {print " \\\\e[1mVGA:\\\\e[0;32m"$3"\\\\e[0m"; exit}')                 # packages pciutils
    echo -e (lspci | grep -E "VGA|3D controller" | awk -F ':' '/3D/ {print " \\\\e[1m3D:\\\\e[0;32m"$3"\\\\e[0m"; exit}')                   # packages pciutils
	echo -e (echo $XDG_SESSION_TYPE | awk '{print " \\\\e[1mSession: \\\\e[0;32m"$0"\\\\e[0m"}')
    echo -e (whoami | awk '{print " \\\\e[1mUser: \\\\e[0;32m"$0"\\\\e[0m"}')
	echo -e " \\e[1mDisk usage:\\e[0m"
	echo
	echo -ne (\
		df -l -h | grep -E 'dev/(xvda|sd|mapper)' | \
		awk '{printf "\\\\t%s\\\\t%4s / %4s  %s\\\\n\n", $6, $3, $2, $5}' | \
		sed -e 's/^\(.*\([8][5-9]\|[9][0-9]\)%.*\)$/\\\\e[0;31m\1\\\\e[0m/' -e 's/^\(.*\([7][5-9]\|[8][0-4]\)%.*\)$/\\\\e[0;33m\1\\\\e[0m/' | \
		paste -sd ''\
	)
	echo

	echo -e " \\e[1mNetwork:\\e[0m"
	echo
	# http://tdt.rocks/linux_network_interface_naming.html
	echo -ne (\
		ip addr show up scope global | \
			grep -E ': <|inet' | \
			sed \
				-e 's/^[[:digit:]]\+: //' \
				-e 's/: <.*//' \
				-e 's/.*inet[[:digit:]]* //' \
				-e 's/\/.*//'| \
			awk 'BEGIN {i=""} /\.|:/ {print i" "$0"\\\n"; next} // {i = $0}' | \
			sort | \
			column -t -R1 | \
			# public addresses are underlined for visibility \
			sed 's/ \([^ ]\+\)$/ \\\e[4m\1/' | \
			# private addresses are not \
			sed 's/m\(\(10\.\|172\.\(1[6-9]\|2[0-9]\|3[01]\)\|192\.168\.\).*\)/m\\\e[24m\1/' | \
			# unknown interfaces are cyan \
			sed 's/^\( *[^ ]\+\)/\\\e[36m\1/' | \
			# ethernet interfaces are normal \
			sed 's/\(\(en\|enp\|em\|eth\)[^ ]* .*\)/\\\e[39m\1/' | \
			# wireless interfaces are purple \
			sed 's/\(wl[^ ]* .*\)/\\\e[35m\1/' | \
			# wwan interfaces are yellow \
			sed 's/\(ww[^ ]* .*\).*/\\\e[33m\1/' | \
			sed 's/$/\\\e[0m/' | \
			sed 's/^/\t/' \
		)
      echo
      #echo -e " \\e[0;31mKaspa:\\e[0m"
      #echo -e ($HOME/project/kaspaApi/target/release/kaspa_api --price | awk '{print "\\\\e[0m        price: \\\\e[0;32m"$0"\\\\e[0m"}')
      #echo -e ($HOME/project/kaspaApi/target/release/kaspa_api --blockreward | awk '{print "\\\\e[0m        current block reward: \\\\e[0;33m"$0"\\\\e[0m"}')
      #echo
    # echo -e ' \\e[31mnote!: '
    # echo -e '       \\e[36m *\\e[33mhyprpaper xdg-desktop-portal-hyprland (current use: extra-staging)'
    # echo -e '       \\e[36m *\\e[33mhyprpaper-0.6.0-3-x86_64.pkg.tar.zst xdg-desktop-portal-hyprland-1.3.1-4-x86_64.pkg.tar.zst'
    # echo -e '       \\e[36m *\\e[33min Downloads'
    # echo 

end
