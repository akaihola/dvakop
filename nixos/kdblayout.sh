#!/usr/bin/env bash

# work-around for https://unix.stackexchange.com/a/378811/2140
#gnome-keyring-daemon --replace

xkb_options() {
    gsettings set org.gnome.desktop.input-sources xkb-options "$@"
}

notify() {
    notify-send -t 100 -a Keyboard -u normal "$@"
}

case "$1" in
fi)
    notify fi
    xkb_options "['caps:none']"
    ;;
dvakop)
    notify dvakop
    xkb_options "['dvakop:dvakop', 'dvakop:modifiers']"
esac
