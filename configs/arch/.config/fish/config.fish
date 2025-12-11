function fish_greeting
	echo 
	echo -e (uname -ro | awk '{print " \\\\e[1mOS: \\\\e[0;32m"$0"\\\\e[0m"}')
	echo -en (uptime -p | sed 's/^up //' | awk '{print " \\\\e[1mUptime: \\\\e[0;32m"$0"\\\\e[0m"}')                                         # packages procps
    echo -e (timedatectl show -P NTPSynchronized | awk '{if ($0=="yes") print " \\\\e[1mNtp: \\\\e[0;32mOk\\\\e[0m";else print " \\\\e[1mNtp: \\\\033[0;31mOops!\\\\e[0m"}')
	echo -e (uname -n | awk '{print " \\\\e[1mHostname: \\\\e[0;32m"$0"\\\\e[0m"}')                                                         # packages lsb-release
    echo -e (lsb_release -d | awk -F ':' '/Description/ {gsub("\t","",$2);print " \\\\e[1mDescription: \\\\e[0;32m"$2"\\\\e[0m"; exit}')
    echo -e (awk -F ':' '/model name/ {print " \\\\e[1mCPU: \\\\e[0;32m"$2"\\\\e[0m"; exit}' /proc/cpuinfo)
    echo -e (lspci | grep -E "VGA|3D controller" | awk -F ':' '/VGA/ {print " \\\\e[1mVGA:\\\\e[0;32m"$3"\\\\e[0m"; exit}')                 # packages pciutils
    echo -e (lspci | grep -E "VGA|3D controller" | awk -F ':' '/3D/ {print " \\\\e[1m3D:\\\\e[0;32m"$3"\\\\e[0m"; exit}')                   # packages pciutils
	echo -e (echo $XDG_SESSION_TYPE | awk '{print " \\\\e[1mSession: \\\\e[0;32m"$0"\\\\e[0m"}')(echo $XDG_CURRENT_DESKTOP | awk '{print " \\\\e[0;32m"$0"\\\\e[0m"}')
    echo -e (whoami | awk '{print " \\\\e[1mUser: \\\\e[0;32m"$0"\\\\e[0m"}')
	echo -e " \\e[1mDisk usage:\\e[0m"
	echo
	echo -ne (\
		df -l -h | grep -E 'dev/(xvda|sd|mapper|vda)' | \
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
      set_color 16AA64
      echo -e ' note!: '
      set_color 6A6362
      echo -e '\t*created emergency backup (tracy,proton)'
      set_color F53C3C
      echo -e '\t*supply chain attack: check dependencies npm packages.!!! '
      set_color 605F5E
      echo -e '\t*https://socket.dev/blog/npm-author-qix-compromised-in-major-supply-chain-attack'
      echo -e '\t*https://gist.github.com/sindresorhus/2b7466b1ec36376b8742dc711c24db20'
      echo -e '\t*https://github.com/chalk/chalk/issues/656'
      set_color F53C3C
      echo -e '\t*DONT UPRADE webtorrent-cli, prettier yet'
      set_color normal
      echo 

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
	# echo -n '⟩ '
	set_color normal
end

#reflector mirror sync in arch
if command -v reflector > /dev/null
        abbr -a mirror_sync 'sudo reflector -c NL -p https --sort age --sort score -l 20 --save /etc/pacman.d/mirrorlist'
end

if command -v webtorrent > /dev/null
        abbr -a wt 'webtorrent download'
end

# system monitor cli
if command -v btm > /dev/null
        abbr -a monitors 'btm --theme gruvbox-light -T'
        # config `~/.config/bottom/bottom.toml`
        # now just use `btm`
end
#sudo-rs
if command -v sudo-rs > /dev/null
        abbr -a sudo 'sudo-rs'
end

#dust 
if command -v dust > /dev/null 
        abbr -a size 'dust -d 1 -c -B'
end

#git
if command -v git > /dev/null
        abbr -a g git
        abbr -a gc 'git checkout'
        abbr -a ga 'git add -p'
        abbr -a gl 'git log --all --decorate --oneline -50 --graph'
        abbr -a gs 'git status'
        abbr -a gss 'git diff --cached'
        abbr -a gsm 'git submodule update --init --recursive'
        abbr -a gr 'git rebase -i HEAD~3'
end

#cargo
if command -v cargo > /dev/null
        abbr -a cbn 'cargo b && dunstify -u normal -i "/home/rigel/.local/share/icons/rustacean-flat-happy.svg"  "🦀 cargo compilling finished!"'
        abbr -a crn 'cargo b -r && dunstify -u normal -i "/home/rigel/.local/share/icons/rustacean-flat-happy.svg"  "🦀 cargo compilling finished!"'
        abbr -a cb 'cargo b'
        abbr -a cr 'cargo r'
        abbr -a cc 'cargo c'
        abbr -a cw 'cargo c --workspace'
        abbr -a cn 'cargo new'
        abbr -a cnb 'cargo new --bin'
        abbr -a cnl 'cargo new --lib'
        # .
        # ├── Cargo.toml
        # ├── examples
        # │   └── example.rs
        # └── src
        # └── main.rs
        #
        # cargo r --example [name file of examples]
        abbr -a cx 'cargo r --example'
end

#mini-redis
if command -v mini-redis-server > /dev/null
        abbr -a mr 'mini-redis-server --port 7000'
end

#A cat clone with syntax highlighting https://github.com/sharkdp/bat
if command -v bat > /dev/null
        abbr -a cat 'bat'
        abbr -a bat 'cat'
end

if command -v yazi > /dev/null
        abbr -a ya 'yazi'
        abbr -a y 'yazi'
end

if command -v fd > /dev/null
        abbr -a ft 'fd -H -t f -d 1' #find type file max deep 1 
        abbr -a fd1 'fd -H -t d -d 1' #find type directory max deep 1 
end

if command -v nvim > /dev/null
        abbr -a v 'nvim'
        abbr -a vi 'nvim'
        abbr -a vim 'nvim'
        abbr -a ndiff 'nvim -d'
end

if command -v hyprctl > /dev/null
        abbr -a cursor_phinger_dark 'hyprctl setcursor "phinger-cursors-dark" 14'
        abbr -a cursor_pop 'hyprctl setcursor "Pop" 20'
        abbr -a cursor_cap 'hyprctl setcursor "Capitaine" 12'
end


#duplex ethernet speed
abbr -a .duplex1000 'sudo ethtool -s enp4s0 speed 1000 duplex full autoneg on'
abbr -a .duplex100 'sudo ethtool -s enp4s0 speed 1000 duplex full autoneg on'
abbr -a .duplexshow 'sudo ethtool enp4s0'

#activate python venv manual
#to deactive just type: deactive
abbr -a .venv 'source $HOME/.venv/bin/activate.fish'

#steam debugger nvidia_offload
#nvidia-smi pmon # running process on nvidia

complete --command aurman --wraps pacman

if status --is-interactive
   clear
   alias ssh="TERM=xterm-256color $(command -v ssh)"
   #alias ssh="alacritty $(which ssh)"

   export GPG_TTY=$(tty)
   # ssh agent for ssh
   # ----------------------------
   # ssh gnome/keyring
   # set SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/gcr/ssh"
   if test -e $HOME/.ssh_auth_sock
           set -x SSH_AUTH_SOCK ""
           set -x SSH_AUTH_SOCK (cat $HOME/.ssh/ssh_auth_sock)
   end

   # ssh agent from gnupg
   # ----------------------------
   # set SSH_AGENT_PID ""
   # set -x -U SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
   # set -x -U SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh"

   # gopass
   set -x PASSWORD_STORE_DIR $HOME/Pgp/pinned/boxpass

   # paperpass
   set -x PAPERPASS_CONFIG $HOME/.config/paperpass/paperpass.toml
   #paperbackup
   set -x PAPERBACKUP_CONFIG $HOME/.config/paperbackup/config.toml

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

   #base16_shell -->> git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
   set BASE16_SHELL "$HOME/.config/base16-shell/"
   source "$BASE16_SHELL/profile_helper.fish"

   # npm packages
   set NPM_PACKAGES "$HOME/.npm-packages"
   set PATH $PATH $NPM_PACKAGES/bin
   set MANPATH $NPM_PACKAGES/share/man $MANPATH

   #android-platform
   # export PATH="/opt/android-sdk/platform-tools/:$PATH"

   #tauri android 
   if test -d /mnt/d/android-studio
           set -x JAVA_HOME /mnt/d/android-studio/jbr/
           set -x ANDROID_HOME /mnt/d/android-project/Android-Sdk/
           set -x PATH $PATH $ANDROID_HOME/cmdline-tools
           set -x PATH $PATH $ANDROID_HOME/build-tools/35.0.1
           set NDK_dir (ls -1 $ANDROID_HOME/ndk)
           set -x NDK_HOME $ANDROID_HOME/ndk/$NDK_dir
           set -x PATH $PATH $ANDROID_HOME/ndk/$NDK_dir
           set -x PATH $PATH $ANDROID_HOME/platform-tools
   end

   # override color_command
   # set -U fish_color_command 16AA64
   # set -U fish_color_param 7A4DBD

   # MANPAGE
   # man: can't open the manpath configuration file /etc/man_db.conf
   # do this: 
   # sudo aa-enforce usr.bin.man
   # or put into complain:
   # sudo aa-complain usr.bin.man || sudo aa-complain /etc/apparmor.d/usr.bin.man
   # or something related to this:
   # ERROR: Profile for /usr/lib/@{chromium}/@{chromium} exists in /etc/apparmor.d/chromium_browser 
   # and {'f': '/etc/apparmor.d/chromium', 'p': 'chromium', 're': AARE('/usr/lib/@{chromium}/@{chromium}')}

   # Apparmor disabled manpage 
   # sudo apparmor_parser -R /etc/apparmor.d/usr.bin.man
   # Apparmor enabled manpage 
   # sudo apparmor_parser /etc/apparmor.d/usr.bin.man
   set MANPATH (manpath) $MANPATH
   set -g man_blink -o red
   set -g man_bold -o green
   set -g man_standout -b black 93a1a1
   set -g man_underline -u 93a1a1

end

if command -v eza > /dev/null
	abbr -a l 'eza'
	abbr -a ls 'eza'
	abbr -a ll 'eza -l'
	abbr -a lg 'eza -l -G'
	abbr -a llg 'eza -la -G'
	abbr -a lll 'eza -la'
    abbr -a nix 'nix-env'
else
	abbr -a l 'ls'
	abbr -a ll 'ls -l'
	abbr -a lll 'ls -la'
    abbr -a vi 'vi'
    abbr -a vim 'vim'
end

# df dont show tmpfs
if command -v df > /dev/null
   abbr -a drives 'df -x tmpfs -hT'
end

#clipboard wayland 
#abbr -a .bc '$HOME/utility/clear-clipboard-wayland-hyprland'
function .bc 
        if command -v wl-copy > /dev/null
                wl-copy -c
        else 
                printf "wl-copy not found"
        end
end

#paru 
if command -v paru > /dev/null
   abbr -a p 'paru'
end

#if test -f /usr/share/autojump/autojump.fish;
#	source /usr/share/autojump/autojump.fish;
#end

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

#check ssh_auth_sock exist!
if test -e !$HOME/.ssh/ssh_auth_sock;
        if test -d !$HOME/.ssh;
                mkdir $HOME/.ssh
        end
        touch $HOME/.ssh/ssh_auth_sock
end

#ssh-agent start
abbr -a list_ssh_agent 'ps -e | grep \'ssh\' && cat $HOME/.ssh/ssh_auth_sock'
function start_ssh_agent
        eval (ssh-agent -c) 
        ssh-add ~/.ssh/rpi_earendel_ed25519 
        ssh-add ~/.ssh/hive_wendy_ed25519 
        ssh-add ~/.ssh/rick_phoebe_ed25519 
        ssh-add ~/.ssh/id_ed25519
        echo $SSH_AUTH_SOCK > $HOME/.ssh/ssh_auth_sock
        timeout_ssh_agent
end

#ssh-agent start lan
abbr -a list_ssh_lan 'ps -e | grep \'ssh\' && cat $HOME/.ssh/ssh_auth_sock'
function start_ssh_agent_lan
        eval (ssh-agent -c) 
        ssh-add ~/.ssh/rpi_earendel_ed25519 
        ssh-add ~/.ssh/hive_wendy_ed25519 
        ssh-add ~/.ssh/rick_phoebe_ed25519 
        echo $SSH_AUTH_SOCK > $HOME/.ssh/ssh_auth_sock
        timeout_ssh_agent
end

#ssh-agent gpg Auth
function start_ssh_agent_gpg
        set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
        sed -i 's:pinentry-program /usr/bin/pinentry-curses:# pinentry-program /usr/bin/pinentry-curses:g' ~/.gnupg/gpg-agent.conf
        sed -i 's:# pinentry-program /usr/bin/pinentry-gtk:pinentry-program /usr/bin/pinentry-gtk:' ~/.gnupg/gpg-agent.conf
        gpgconf --launch gpg-agent
end

function stop_ssh_agent_gpg
        set -x SSH_AUTH_SOCK ""
        sed -i 's:# pinentry-program /usr/bin/pinentry-curses:pinentry-program /usr/bin/pinentry-curses:g' ~/.gnupg/gpg-agent.conf
        sed -i 's:pinentry-program /usr/bin/pinentry-gtk:# pinentry-program /usr/bin/pinentry-gtk:' ~/.gnupg/gpg-agent.conf
        gpgconf --kill all
end

#ssh-agent github start 
function start_ssh_agent_only_git
        eval (ssh-agent -c) 
        ssh-add ~/.ssh/id_ed25519
        echo $SSH_AUTH_SOCK > $HOME/.ssh/ssh_auth_sock
        timeout_ssh_agent
end

function stop_ssh_agent
        set get_pid (ps -e | rg -i "ssh" | awk '{print $1}')
        kill $get_pid
        cat /dev/null > $HOME/.ssh/ssh_auth_sock
end

function list_ssh_agent
        ssh-add -L
        ps -e | grep 'ssh'
        cat $HOME/.ssh/ssh_auth_sock
end

#timeout
function timeout_ssh_agent
        set delay 3600
        if command -v dunstify > /dev/null
                dunstify -u normal -i "/home/rigel/.local/share/icons/ssh.png" "SSH AGENT Timeout: $delay second"
                $HOME/.config/fish/timeout-ssh-agent.fish -t $delay &
        else 
                printf "No notify Agent found!"
        end 
        # # native hyprland notify
        # if command -v hyprctl > /dev/null
        #         hyprctl notify 1 5000 "rgb(16985A)" "SSH Agent Timeout: $delay second"
        #         $HOME/.config/fish/timeout-ssh-agent.fish -t $delay &
        # else 
        #         printf "No notify Agent found!"
        # end
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

#fzf_key_bindings
function fish_user_key_bindings
	fzf_key_bindings
end

#torsocks
function start_tor 
        if command -v torsocks > /dev/null
                sudo systemctl start tor
        end
end
function stop_tor
        if command -v torsocks > /dev/null
                sudo systemctl stop tor
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

# ssh
function rpi 
        if command -v ssh > /dev/null
                ssh rpi
        end
end
function hive
        if command -v ssh > /dev/null
                ssh hive
        end
end
function rick
        if command -v ssh > /dev/null
                ssh rick
        end
end

#battery
function battery_status
        if command -v upower > /dev/null
                set_color green;
                printf "Battery_BAT1\n"
                printf "------------\n"
                set_color normal
                upower -i /org/freedesktop/UPower/devices/battery_BAT1 
                set_color green;
                printf "line_power_ACAD\n"
                printf "---------------\n"
                set_color normal;
                upower -i /org/freedesktop/UPower/devices/line_power_ACAD
                set_color green;
                printf "DisplayDevice\n"
                printf "-------------\n"
                set_color normal;
                upower -i /org/freedesktop/UPower/devices/DisplayDevice
        else 
                printf "upower binaries not foun!"
        end
end

function loop_battery_status
        while true
                clear
                battery_status
                sleep 1
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

abbr -a yr 'cal -y'
abbr -a e nvim
abbr -a m make
abbr -a o xdg-open
abbr -a vimdiff 'nvim -d'
abbr -a ct 'cargo t'

abbr -a cle 'clear'
abbr -a cl 'clear'
abbr -a .lua 'cd $HOME/.config/nvim/lua'
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
abbr -a .paper 'nvim $HOME/project/paperbackup/src/main.rs'
abbr -a .pinguin 'nvim $HOME/project/pinguin-graphql/src/main.rs'
abbr -a .t 'tmux new -s rigel'
abbr -a .ta 'tmux a'
abbr -a .bwarden 'gpg -d $HOME/.nextcloud/Kleopatra.box/brandon/bwarden-brandon.asc && gpgconf --kill all'
abbr -a gree 'fish_greeting'
abbr -a .config 'cd $HOME/.config/'

abbr -a .db_pinguin 'psql -h 192.168.100.144 -p 5432 db_pinguin -U stomp'
abbr -a .nix-list 'nix-env -q'
abbr -a .nix-update 'nix-env -u'
#upgrade nix 
#abbr -a .nix-env-upgrade 'nix-channel --update; nix-env --install --attr nixpkgs.nix nixpkgs.cacert; systemctl daemon-reload; systemctl restart nix-daemon'

abbr -a .ipv6_off 'sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1'
abbr -a .ipv6_on 'sudo sysctl -w net.ipv6.conf.all.disable_ipv6=0' # use for gaming

abbr -a fa 'fastfetch'
abbr -a start_virtio '$HOME/project/dotfiles/bins/arch/start-virtio-virtual-machine-QEMU'
abbr -a stop_virtio 'sudo virsh net-destroy default'
abbr -a stop_network 'sudo systemctl stop NetworkManager'
abbr -a start_network 'sudo systemctl start NetworkManager'
abbr -a start_ssh 'sudo systemctl start sshd'
abbr -a stop_ssh 'sudo systemctl stop sshd'

#printer service
abbr -a start_printer 'sudo systemctl start cups'
abbr -a stop_printer 'sudo systemctl stop cups'

#v4l2loopback
abbr -a v4l2_load 'sudo modprobe v4l2loopback video_nr=2 card_label=v4l2loopback_screen_sharing exclusive_caps=1'
abbr -a v4l2_unload 'sudo modprobe -r v4l2loopback'
abbr -a v4l2_list 'v4l2-ctl --list-devices'

#wf-recorder screen_sharing full screen
abbr -a screen_sharing 'wf-recorder --muxer=v4l2 --codec=rawvideo --file=/dev/video2 -x yuv420p'
#wf-recorder screen_sharing portion of the screen (need install slurp)
abbr -a screen_sharing_portion 'wf-recorder -g "$(slurp)" --muxer=v4l2 --codec=rawvideo --file=/dev/video2 -x yuv420p'

#v4l2loopback droid
# https://github.com/Genymobile/scrcpy/blob/v2.3.1/doc/camera.md
# https://github.com/Genymobile/scrcpy/blob/v2.3.1/doc/v4l2.md
abbr -a droid-list-camera 'scrcpy --list-cameras'
abbr -a droid-list-camera-sizes 'scrcpy --list-camera-sizes'
abbr -a droid-camera-front 'scrcpy --video-source=camera --camera-size=720x480 --camera-facing=front --camera-fps=30 \
--orientation=90 --no-audio --v4l2-sink=/dev/video2'
abbr -a droid-camera-back 'scrcpy --video-source=camera --camera-size=720x480 --camera-facing=back --camera-fps=30 \
--orientation=90 --no-audio --v4l2-sink=/dev/video2'
abbr -a droid-adb-network 'adb tcpip 12001'

