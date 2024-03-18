include:
    - .flatpak


desktop-packages:
    pkg.installed:
        - pkgs:
            - alsa-firmware-loaders
            - alsa-utils
            - apulse
            - apt-file
            - arc-theme
            - at-spi2-core
            - bluetooth
            - bluez-obexd
            - bluez-tools
            - chrome-gnome-shell
            - cups
            - dnsmasq  # required by libvirtd
            - evince
            - fonts-liberation
            - fonts-powerline  # for starship
            - gnome-shell
            - gdm3
            - ghostscript
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
            - imagemagick
            - libasound2-plugins
            - libcanberra-pulse
            - libdbus-glib-1-2
            - libgdk-pixbuf2.0-bin
            - libgnome-bluetooth13
            - libinput-tools
            - libpam-gnome-keyring
            - libpipewire-0.3-common
            - libpipewire-0.3-modules
            - libvirt-daemon
            - libvirt-daemon-system
            - malcontent  # unfortunately needed because otherwise gnome-settings->Applications doesn't populate
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


{% for user in pillar['users'] %}
    {% for key, extid in {"Move_Clock@rmy.pobox.com": "2",
            "vertical-overview@RensAlthuis.github.com": "4144",
            "no-overview@fthx": "4099",
            "trayIconsReloaded@selfmade.pl": "2890"}.items() %}
install-extensions-{{user}}-{{extid}}:
    cmd.script:
        - name: install-gnome-extensions.sh -e {{extid}}
        - source: salt://basics/desktop/install-gnome-extensions.sh
        - runas: {{user}}
        - unless: test -d "{{salt['file.join'](salt['user.info'](user).home, ".local", "share", "gnome-shell", "extensions", key)}}"
    {% endfor %}
{% endfor %}


# vim: syntax=yaml
