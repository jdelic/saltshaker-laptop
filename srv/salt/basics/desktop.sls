desktop-packages:
    pkg.installed:
        - pkgs:
            - gnome-shell
            - gdm3
            - gnome-session
            - arc-theme
            - gnome-themes-standard
            - gnome-control-center
            - nautilus
            - gnome-icon-theme
            - x11-xserver-utils
            - network-manager
            - network-manager-openvpn
            - network-manager-gnome
            - network-manager-openvpn-gnome
            - pulseaudio-module-gsettings
            - pulseaudio-module-bluetooth
            - pulseaudio
            - gnome-terminal
            - gnome-tweaks
            - plymouth
            - plymouth-themes
            - gthumb
            - gimp
            - libinput-tools
            - xdotool
            - wmctrl
            - xfonts-scalable
            - xserver-xorg
            - apt-file
            - virt-manager
            - libvirt-daemon
            - p7zip-full
            - nftables
            - vlc
            - unison-gtk
            - libgdk-pixbuf2.0-bin
            - at-spi2-core
            - chrome-gnome-shell
            - virtinst
            - libvirt-daemon-system
        - install_recommends: False
        - require:
            - pkg: basesystem-packages


desktop-activated:
    cmd.run:
        - name: systemctl set-default graphical.target
        - require:
            - pkg: desktop-packages
