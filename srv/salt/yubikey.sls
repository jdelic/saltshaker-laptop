yubikey-packages:
    pkg.installed:
        - pkgs:
            - ykcs11
            - ykls
            - yubico-piv-tool
            - libpam-yubico
            - yubikey-manager
        - install_recommends: False
