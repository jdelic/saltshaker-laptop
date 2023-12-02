gimp:
    cmd.run:
        - name: flatpak install -y --or-update flathub org.gimp.GIMP
        - require:
            - cmd: flatpak-flathub
