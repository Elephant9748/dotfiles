#! /usr/bin/fish 

#sleep 10
#kill $SSH_AGENT_PID
#cat /dev/null > $HOME/.ssh/ssh_auth_sock
#printf "SSH AGENT Time is up!"

set timeout 10 #default_value
set ssh_pid $SSH_AGENT_PID 

function notify_dunst -d "start"
        set timeout_already_set 0
        while set -q argv[1]
                set option $argv[1]
                switch "$option"
                        case -t --timeout:
                                set --erase argv[1]
                                set timeout $argv[1]
                                #sleep $timeout
                                sleep $timeout
                                kill $ssh_pid
                                cat /dev/null > $HOME/.ssh/ssh_auth_sock
                                #printf "\nSSH AGENT Time is up!"
                                dunstify -u normal "SSH AGENT Time is up!"
                                ps -e | grep 'dunst' | awk '{print $1}' | cat > $HOME/.config/dunst/dunst_sock
                        case "*"
                                printf "error: %s\n" $option
                end
                set --erase argv[1]
        end
end


function notify_hyprctl -d "start"
        set timeout_already_set 0
        while set -q argv[1]
                set option $argv[1]
                switch "$option"
                        case -t --timeout:
                                set --erase argv[1]
                                set timeout $argv[1]
                                #sleep $timeout
                                sleep $timeout
                                kill $ssh_pid
                                cat /dev/null > $HOME/.ssh/ssh_auth_sock
                                #printf "\nSSH AGENT Time is up!"
                                hyprctl notify 5 5000 "rgb(16985A)" "SSH Agent Time is up!"
                                ps -e | grep 'dunst' | awk '{print $1}' | cat > $HOME/.config/dunst/dunst_sock
                        case "*"
                                printf "error: %s\n" $option
                end
                set --erase argv[1]
        end
end

notify_hyprctl $argv &
