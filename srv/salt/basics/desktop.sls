desktop-packages:
    pkg.installed:
        - pkgs:
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
            - libgdk-pixbuf2.0-bin
            - libinput-tools
            - libvirt-daemon
            - libvirt-daemon-system
            - nautilus
            - network-manager
            - network-manager-openvpn
            - network-manager-gnome
            - network-manager-openvpn-gnome
            - plymouth
            - plymouth-themes
            - pulseaudio
            - pulseaudio-module-bluetooth
            - pulseaudio-module-gsettings
            - virt-manager
            - p7zip-full
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
