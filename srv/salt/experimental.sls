kernel-600:
    pkg.installed:
        - pkgs:
            - linux-image-amd64
            - linux-headers-amd64
            - firmware-linux
            - firmware-linux-free
            - firmware-linux-nonfree
            - firmware-misc-nonfree
            - firmware-intel-sound
        - install_recommends: False
        - fromrepo: bullseye-backports
        - require:
            - backports-org-bullseye