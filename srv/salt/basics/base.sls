basesystem-packages:
    pkg.installed:
        - pkgs:
            - apt-transport-https
            - apt-transport-s3
            - bash-completion
            - byobu
            - coreutils
            - cron
            - curl
            - dbus
            - dbus-user-session
            - dnsutils
            - efitools
            - firejail
            - firmware-linux-nonfree
            - git
            - info
            - jq
            - less
            - libcap2-bin
            - make
            - net-tools
            - nftables
            - patch
            - smbios-utils
            - systemd-timesyncd
            - unzip
        - order: 1

