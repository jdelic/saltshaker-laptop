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
            - git-lfs
            - htop
            - i2c-tools
            - info
            - jq
            - less
            - libcap2-bin
            - lm-sensors
            - make
            - man-db
            - manpages
            - net-tools
            - nftables
            - ntfs-3g
            - patch
            - pmount
            - python-is-python3
            - read-edid
            - smbios-utils
            - systemd-timesyncd
            - traceroute
            - unzip
            - usbguard
        - order: 1
        - require:
            - pkgrepo: bookworm


usbguard:
    service.running:
        - enable: True
        - require:
            - pkg: basesystem-packages

# vim: syntax=yaml
