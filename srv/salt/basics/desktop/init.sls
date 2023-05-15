#include:
#    - .libinput


desktop-packages:
    pkg.installed:
        - pkgs:
            - alsa-firmware-loaders
            - alsa-utils
            - apulse
            - apt-file
            - arc-theme
            - at-spi2-core
            - bluez-obexd
            - bluez-tools
            - chrome-gnome-shell
            - cups
            - dnsmasq  # required by libvirtd
            - fonts-liberation
            - gnome-shell
            - gdm3
            - gimp
            - gir1.2-spiceclientgtk-3.0
            - gir1.2-wp-0.4
            - gnome-control-center
            - gnome-icon-theme
            - gnome-remote-desktop
            - gnome-session
            - gnome-shell-extension-manager
            - gnome-terminal
            - gnome-tweaks
            - gthumb
            - libasound2-plugins
            - libcanberra-pulse
            - libdbus-glib-1-2
            - libgdk-pixbuf2.0-bin
            - libinput-tools
            - libpam-gnome-keyring
            - libpipewire-0.3-common
            - libpipewire-0.3-modules
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
            - pipewire-bin
            - pipewire-audio
            - pipewire-pulse
            - qemu-system-x86
            - seahorse
            - snapd
            - sound-theme-freedesktop
            - spice-client-gtk
            - spice-vdagent
            - squashfs-tools
            - swtpm
            - swtpm-libs
            - swtpm-tools
            - system-config-printer
            - ttf-mscorefonts-installer
            - unison-gtk
            - virt-manager
            - virt-viewer
            - virtinst
            - vlc
            - wayland-utils
            - wayland-protocols
            - weston
            - wireplumber
            - wmctrl
            - x11-xserver-utils
            - xdotool
            - xfonts-scalable
            - xserver-xorg
            - zenity
        - install_recommends: False
        - require:
            - pkg: basesystem-packages


xerox-driver:
    pkg.installed:
        - sources:
            - xeroxofficeprtdrv: https://download.support.xerox.com/pub/drivers/CQ8580/drivers/linux/pt_BR/XeroxOfficev5Pkg-Linuxx86_64-5.20.661.4684.deb


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
        - backup: minion


# vim: syntax=yaml
