
hpprinters:
    pkg.installed:
        - pkgs:
            - hplip
            - printer-driver-hpcups
            - printer-driver-postscript-hp
            - printer-driver-hpijs
            - libsane-hpaio
        - no_install_recommends: True
        - require:
            - pkg: desktop-packages
