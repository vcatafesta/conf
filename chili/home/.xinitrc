#umc 2560 1080 50 --rbt
#2560x1080x49.94 @ 55.239kHz
#Modeline "2560x1080x49.94"  150.250000  2560 2608 2640 2720  1080 1083 1087 1106  +HSync -VSync
#xrandr --verbose --newmode "2560x1080x49.94"  150.250000  2560 2608 2640 2720  1080 1083 1087 1106  +HSync -VSync
#xrandr --verbose --addmode HDMI-1 "2560x1080x49.94"
#xrandr --output HDMI-1 --mode "2560x1080x49.94"
#xrandr --output DVI-I-1 --preferred
#xrandr --output DVI-I-1 --right-of VGA-1

exec xfce4-session
#xrandr --verbose --newmode "2560x1080x49.94"  150.250000  2560 2608 2640 2720  1080 1083 1087 1106  +HSync -VSync
#xrandr --verbose --addmode HDMI-1 "2560x1080x49.94"
#xrandr --output HDMI-1 --mode "2560x1080x49.94"
#exec mate-session
#export XDG_SESSION_TYPE=x11
#export GDK_BACKEND=x11
#exec gnome-session
#export XDG_CURRENT_DESKTOP=GNOME-Classic:GNOME
#export GNOME_SHELL_SESSION_MODE=classic
#exec gnome-session

setxkbmap -layout br
#BSPWM
setxkbmap &
nitrogen --restore &
xsetroot -cursor_name left_ptr
picom -f &
exec bspwm



