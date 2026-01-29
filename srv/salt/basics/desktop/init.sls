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
            - cups
            - cups-pk-helper
            - dnsmasq  # required by libvirtd
            - eog
            - eog-plugins
            - evince
            - fonts-liberation
            - fonts-noto-color-emoji
            - fonts-powerline  # for starship
            - gnome-shell
            - gdm3
            - ghostscript
            - gir1.2-libinsane-1.0
            - gir1.2-spiceclientgtk-3.0
            - gir1.2-wp-0.5
            - gnome-browser-connector
            - gnome-control-center
            - gnome-icon-theme
            - gnome-remote-desktop
            - gnome-session
            - gnome-shell-extension-manager
            - gnome-terminal
            - gnome-tweaks
            - gphoto2
            - gthumb
            - gvfs-backends
            - gvfs-fuse
            - imagemagick
            - libasound2-plugins
            - libcanberra-pulse
            - libdbus-glib-1-2
            - libgdk-pixbuf2.0-bin
            - libgnome-bluetooth-3.0-13
            - libgnome-bluetooth-ui-3.0-13
            - libimobiledevice-1.0-6
            - libimobiledevice-utils
            - libinput-tools
            - libpam-gnome-keyring
            - libpipewire-0.3-common
            - libpipewire-0.3-modules
            - libsane1
            - libusbmuxd-tools
            - libvirt-daemon
            - libvirt-daemon-system
            - malcontent  # unfortunately needed because otherwise gnome-settings->Applications doesn't populate
            - nautilus
            - network-manager
            - network-manager-openvpn
            - network-manager-gnome
            - network-manager-openvpn-gnome
            - ovmf  # UEFI for KVM VMs
            - p7zip-full
            - plymouth
            - plymouth-themes
            - pipewire-bin
            - pipewire-audio
            - pipewire-pulse
            - printer-driver-cups-pdf
            - pulseaudio-utils  # this delivers pactl which we need to control virtual sound sinks
            - python3-gi
            - qemu-system-modules-spice
            - qemu-system-x86
            - qemu-utils
            - seahorse
            - smart-notifier
            - smartmontools
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
            - usbguard-notifier
            - usbmuxd
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


smartd-service:
    service.running:
        - name: smartd
        - enable: True
        - require:
            - pkg: desktop-packages


snap-service:
    service.running:
        - name: snapd
        - enable: True
        - require:
            - pkg: desktop-packages


set-wayland-state:
    file.managed:
        - name: /etc/gdm3/daemon.conf
        - source: salt://basics/daemon.conf.jinja
        - template: jinja
        - backup: minion


network-manager-etc-interfaces:
    file.managed:
        - name: /etc/network/interfaces
        - user: root
        - group: root
        - mode: '0644'
        - contents: |
            # THIS FILE IS MANAGED BY SALT
            # This file describes the network interfaces available on your system
            # and how to activate them. For more information, see interfaces(5).
            source /etc/network/interfaces.d/*

            # The loopback network interface
            auto lo
            iface lo inet loopback

            # ... all other interfaces are managed by network-manager
        - require:
            - pkg: desktop-packages


{% for user in pillar['users'] %}
    {# The ids can be found in .local/share/gnome-shell/extensions/ and the numerical part comes from the URL on
       extensions.gnome.org #}
    {% for key, extid in {"Move_Clock@rmy.pobox.com": "2",
            "vertical-workspaces@G-DH.github.com": "5177",
            "no-overview@fthx": "4099",
            "appindicatorsupport@rgcjonas.gmail.com": "615",
            "gjsosk@vishram1123.com": "5949",
            "tactile@lundal.io": "4548"}.items() %}
install-extensions-{{user}}-{{extid}}:
    cmd.script:
        - name: install_gnome_extensions.sh -e {{extid}}
        - source: salt://basics/desktop/install_gnome_extensions.sh
        - runas: {{user}}
        - unless: test -d "{{salt['file.join'](salt['user.info'](user).home, ".local", "share", "gnome-shell", "extensions", key)}}"
        - require:
            - pkg: desktop-packages
    {% endfor %}

script-gnome-task-keyboard-shortcuts-{{user}}:
    file.managed:
        - name: {{salt['file.join'](salt['user.info'](user).home, ".local", "lib", "saltshaker-startup", "gnome_alttab_setup.py")}}
        - source: salt://basics/desktop/gnome_alttab_setup.py
        - user: {{user}}
        - group: {{user}}
        - mode: '0700'
        - makedirs: True
        - require:
            - pkg: desktop-packages


startup-gnome-task-keyboard-shortcuts-{{user}}:
    file.accumulated:
        - name: startup-scripts-{{user}}
        - filename: {{salt['file.join'](salt['user.info'](user).home, ".local", "lib", "saltshaker-startup", "startup.sh")}}
        - text: /usr/bin/python3 {{salt['file.join'](salt['user.info'](user).home, ".local", "lib", "saltshaker-startup", "gnome_alttab_setup.py")}}
        - require_in:
            - file: startup-scripts-file-{{user}}
        - require:
            - file: script-gnome-task-keyboard-shortcuts-{{user}}


script-gnome-desktop-keyboard-shortcuts-{{user}}:
    file.managed:
        - name: {{salt['file.join'](salt['user.info'](user).home, ".local", "lib", "saltshaker-startup", "gnome_vertical_workspace_setup.py")}}
        - source: salt://basics/desktop/gnome_vertical_workspace_setup.py
        - user: {{user}}
        - group: {{user}}
        - mode: '0700'
        - makedirs: True
        - require:
            - cmd: install-extensions-{{user}}-5177


startup-gnome-desktop-keyboard-shortcuts-{{user}}:
    file.accumulated:
        - name: startup-scripts-{{user}}
        - filename: {{salt['file.join'](salt['user.info'](user).home, ".local", "lib", "saltshaker-startup", "startup.sh")}}
        - text: /usr/bin/python3 {{salt['file.join'](salt['user.info'](user).home, ".local", "lib", "saltshaker-startup", "gnome_vertical_workspace_setup.py")}}
        - require_in:
            - file: startup-scripts-file-{{user}}
        - require:
            - file: script-gnome-desktop-keyboard-shortcuts-{{user}}


script-calendar-display-options-{{user}}:
    file.managed:
        - name: {{salt['file.join'](salt['user.info'](user).home, ".local", "lib", "saltshaker-startup", "tweak_topbar_calendar_settings.py")}}
        - source: salt://basics/desktop/tweak_topbar_calendar_settings.py
        - user: {{user}}
        - group: {{user}}
        - mode: '0700'
        - makedirs: True
        - require:
            - pkg: desktop-packages


startup-calendar-display-options-{{user}}:
    file.accumulated:
        - name: startup-scripts-{{user}}
        - filename: {{salt['file.join'](salt['user.info'](user).home, ".local", "lib", "saltshaker-startup", "startup.sh")}}
        - text: /usr/bin/python3 {{salt['file.join'](salt['user.info'](user).home, ".local", "lib", "saltshaker-startup", "tweak_topbar_calendar_settings.py")}}
        - require_in:
            - file: startup-scripts-file-{{user}}
        - require:
            - file: script-calendar-display-options-{{user}}


startup-gsettings-enforce-usbguard:
    file.accumulated:
        - name: startup-scripts-{{user}}
        - filename: {{salt['file.join'](salt['user.info'](user).home, ".local", "lib", "saltshaker-startup", "startup.sh")}}
        - text: |
            gsettings set org.gnome.desktop.privacy usb-protection-level 'always'
            gsettings set org.gnome.desktop.privacy usb-protection false
        - require_in:
            - file: startup-scripts-file-{{user}}
        - require:
            - pkg: desktop-packages


startup-scripts-file-{{user}}:
    file.managed:
        - name: {{salt['file.join'](salt['user.info'](user).home, ".local", "lib", "saltshaker-startup", "startup.sh")}}
        - source: salt://basics/desktop/startup.jinja.sh
        - user: {{user}}
        - group: {{user}}
        - mode: '0700'
        - makedirs: True
        - template: jinja
        - context:
             user: {{user}}


startup-scripts-autostart-{{user}}:
    file.managed:
        - name: {{salt['file.join'](salt['user.info'](user).home, ".config", "autostart", "saltshaker-autostart.desktop")}}
        - source: salt://basics/desktop/saltshaker-autostart.jinja.desktop
        - user: {{user}}
        - group: {{user}}
        - mode: '0640'
        - makedirs: True
        - template: jinja
        - require:
            - file: startup-scripts-file-{{user}}
{% endfor %}


# vim: syntax=yaml
