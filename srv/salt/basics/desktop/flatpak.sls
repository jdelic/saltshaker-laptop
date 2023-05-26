
flatpak:
    pkg.installed:
        - pkgs:
            - flatpak
            - gir1.2-flatpak-1.0
            - flatpak-xdg-utils
        - install_recommends: False
        - require:
            - pkg: desktop-packages


flatpak-flathub:
    cmd.run:
        - name: flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
        - require:
            - pkg: flatpak
