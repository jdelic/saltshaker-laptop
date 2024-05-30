
hpprinters:
    pkg.installed:
        - pkgs:
            - hplip
            - printer-driver-hpcups
            - printer-driver-postscript-hp
            - printer-driver-hpijs
            - libsane-hpaio
        - install_recommends: False
        - require:
            - pkg: desktop-packages
