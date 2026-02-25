# The Flatpak version comes with i386 drivers in a separate support container so we don't need to
# eff around with multiarch.

steam:
    cmd.run:
        - name: flatpak install -y --or-update flathub com.valvesoftware.Steam
        - require:
            - cmd: flatpak-flathub
