# install the Anytype note-taking app
anytype:
    cmd.run:
        - name: flatpak install -y --or-update flathub io.anytype.anytype
        - require:
            - cmd: flatpak-flathub
