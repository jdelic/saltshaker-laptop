intel-firmware:
    pkg.installed:
        - pkgs:
            - intel-microcode
            - firmware-intel-sound
            - firmware-sof-signed
            - iucode-tool
        - require:
            - pkg: basesystem-packages