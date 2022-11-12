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
            - dnsmasq  # required by libvirtd
            - fonts-liberation
            - gnome-shell
            - gdm3
            - gimp
            - gir1.2-spiceclientgtk-3.0
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
            - ttf-mscorefonts-installer
            - unison-gtk
            - virt-manager
            - virt-viewer
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


libinput-gestures-git:
    git.latest:
        - name: https://github.com/bulletmark/libinput-gestures
        - target: /var/cache/salt/libinput-gestures
        - branch: master
        - require:
            - pkg: desktop-packages


{% for user in pillar['users'] %}
libinput-gestures-install:
    cmd.run:
        - name: /var/cache/salt/libinput-gestures/libinput-gestures-setup desktop
        - cwd: /var/cache/salt/libintput-gestures
        - unless: /var/cache/salt/libinput/gestures/libinput-gestures-setup status | grep -q "libinput-gestures is installed"
        - runas: {{user}}
        - watch:
            - git: libinput-gestures-git

libinput-gestures-start:
    cmd.run:
        - name: /var/cache/salt/libinput-gestures/libinput-gestures-setup autostart start
        - cwd: /var/cache/salt/libinput-gestures
        - unless: /var/cache/salt/libinput-gestures/libinput-gestures-setup status | grep -q "libinput-gestures is set to autostart"
        - runas: {{user}}
        - require:
            - cmd: libinput-gestures-install

group-input-{{user}}:
    user.present:
        - name: {{user}}
        - optional_groups:
            - input
            - libvirt
{% endfor %}

# vim: syntax=yaml
