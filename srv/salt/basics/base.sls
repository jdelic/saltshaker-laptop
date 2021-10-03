basesystem-packages:
    pkg.installed:
        - pkgs:
            - unzip
            - info
            - efitools
            - make
            - git
            - firejail
            - smbios-utils
            - byobu
            - firmware-linux-nonfree
            - less
            - bash-completion
            - coreutils
            - patch
            - dnsutils
            - net-tools
            - libcap2-bin
            - apt-transport-https
            - apt-transport-s3
            - cron
            - dbus
            - dbus-user-session
            - jq
            - curl
            - systemd-timesyncd
        - order: 1

