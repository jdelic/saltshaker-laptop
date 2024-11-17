amd-firmware:
    pkg.installed:
        - pkgs:
            - amd64-microcode
            - firmware-amd-graphics
            - firmware-linux-nonfree
            - firmware-linux
        - require:
            - pkg: basesystem-packages


x870e-firmware:
    pkg.installed:
        - pkgs:
            - firmware-atheros
            - firmware-linux-nonfree
            - firmware-realtek
        - fromrepo: bookworm-backports
        - order: 1
        - require:
            - pkgrepo: bookworm-backports
            - pkg: basesystem-packages
