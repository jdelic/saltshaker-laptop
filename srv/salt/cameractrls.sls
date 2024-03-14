cameractrls:
    cmd.run:
        - name: flatpak install -y --or-update flathub hu.irl.cameractrls
        - require:
            - cmd: flatpak-flathub
