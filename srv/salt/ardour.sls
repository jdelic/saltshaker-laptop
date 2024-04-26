# install the Ardour sound station
ardour:
    cmd.run:
        - name: flatpak install -y --or-update flathub org.ardour.Ardour
        - require:
            - cmd: flatpak-flathub
