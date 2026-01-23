
xerox-driver:
    pkg.installed:
        - sources:
            - xeroxofficeprtdrv: https://download.support.xerox.com/pub/drivers/CQ8580/drivers/linux/pt_BR/XeroxOfficev5Pkg-Linuxx86_64-5.20.661.4684.deb
        - require:
            - pkg: desktop-packages
