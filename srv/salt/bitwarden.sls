bitwarden:
    cmd.run:
        - name: flatpak install -y --or-update flathub com.bitwarden.desktop
        - require:
            - cmd: flatpak-flathub
