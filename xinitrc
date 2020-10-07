xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
compton -f &
wal -R &

exec ~/bin/startdwm;
