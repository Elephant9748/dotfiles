#! /usr/bin/fish

set delay 180

set wl_clipboard (wl-paste --list-type)
if test "$wl_clipboard"
        sleep $delay
        wl-copy -c
        printf "\nTime is Up wl_clipboard clear!"
else 
        printf "Clipboard Already Clean\n"
end

