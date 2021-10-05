desktop-packages:
    pkg.installed:
        - pkgs:
            - alsa-firmware-loaders
            - alsa-utils
            - apulse
            - apt-file
            - arc-theme
            - at-spi2-core
            - chrome-gnome-shell
            - gnome-shell
            - gdm3
            - gimp
            - gnome-control-center
            - gnome-icon-theme
            - gnome-session
            - gnome-terminal
            - gnome-themes-standard
            - gnome-tweaks
            - gthumb
            - libasound2-plugins
            - libcanberra-pulse
            - libdbus-glib-1-2
            - libgdk-pixbuf2.0-bin
            - libinput-tools
            - libvirt-daemon
            - libvirt-daemon-system
            - nautilus
            - network-manager
            - network-manager-openvpn
            - network-manager-gnome
            - network-manager-openvpn-gnome
            - p7zip-full
            - plymouth
            - plymouth-themes
            - pulseaudio
            - pulseaudio-module-bluetooth
            - pulseaudio-module-gsettings
            - snapd
            - sound-theme-freedesktop
            - squashfs-tools
            - virt-manager
            - unison-gtk
            - virtinst
            - vlc
            - wmctrl
            - x11-xserver-utils
            - xdotool
            - xfonts-scalable
            - xserver-xorg
            - zenity
        - install_recommends: False
        - require:
            - pkg: basesystem-packages


desktop-activated:
    cmd.run:
        - name: systemctl set-default graphical.target
        - require:
            - pkg: desktop-packages


snap-service:
    service.running:
        - name: snapd
        - enable: True


set-wayland-state:
    file.managed:
        - name: /etc/gdm3/daemon.conf
        - source: salt://basics/daemon.conf.jinja
        - template: jinja

# vim: syntax=yaml
