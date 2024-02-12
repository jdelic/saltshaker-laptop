inkscape:
    cmd.run:
        - name: flatpak install -y --or-update flathub org.inkscape.Inkscape
        - require:
            - cmd: flatpak-flathub
