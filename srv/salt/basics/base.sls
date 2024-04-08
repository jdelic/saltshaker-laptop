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
            - dbus-x11
            - dnsutils
            - efitools
            - firejail
            - firewalld
            - firmware-linux-nonfree
            - git
            - info
            - jq
            - less
            - libcap2-bin
            - make
            - man-db
            - manpages
            - net-tools
            - nftables
            - ntfs-3g
            - patch
            - pmount
            - python-is-python3
            - smbios-utils
            - systemd-timesyncd
            - unzip
            - usbguard
        - order: 1
        - require:
            - pkgrepo: bookworm


# vim: syntax=yaml
