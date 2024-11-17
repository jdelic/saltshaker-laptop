intel-firmware:
    pkg.installed:
        - pkgs:
            - intel-microcode
            - firmware-intel-sound
            - firmware-sof-signed
            - firmware-linux-nonfree
            - firmware-linux
            - iucode-tool
        - require:
            - pkg: basesystem-packages