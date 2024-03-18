amd-firmware:
    pkg.installed:
        - pkgs:
            - amd64-microcode
            - firmware-amd-graphics
        - require:
            - pkg: basesystem-packages