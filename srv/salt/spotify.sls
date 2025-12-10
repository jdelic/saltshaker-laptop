spotify:
    cmd.run:
        - name: flatpak install -y --or-update flathub com.spotify.Spotify
        - require:
            - cmd: flatpak-flathub


# vim: syntax=yaml
