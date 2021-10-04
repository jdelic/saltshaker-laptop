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
            - sound-theme-freedesktop
            - virt-manager
            - unison-gtk
            - virtinst
            - vlc
            - wmctrl
            - x11-xserver-utils
            - xdotool
            - xfonts-scalable
            - xserver-xorg
        - install_recommends: False
        - require:
            - pkg: basesystem-packages


desktop-activated:
    cmd.run:
        - name: systemctl set-default graphical.target
        - require:
            - pkg: desktop-packages
