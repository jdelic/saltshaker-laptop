basesystem-packages:
    pkg.installed:
        - pkgs:
            - apt-transport-https
            - apt-transport-s3
            - bash-completion
            - bind9-dnsutils
            - byobu
            - coreutils
            - cron
            - curl
            - dbus
            - dbus-user-session
            - dbus-x11
            - efitools
            - firejail
            - firewalld
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
            - rfkill
            - systemd-timesyncd
            - traceroute
            - uhubctl
            - unzip
            - usbguard
        - order: 1
        - require:
            - pkgrepo: trixie


usbguard:
    service.running:
        - enable: True
        - require:
            - pkg: basesystem-packages
    # enable WCN785x bluetooth. We don't want to add this to udev, so it's not enabled during boot.
    # So we add a usbguard rule for it here. This only exists on my Gigabyte Aorus x870e.
    cmd.run:
        - name: >
            usbguard append-rule 'allow id 0489:e10d serial "" name "" hash 
                "PmlV/iHfj5xpTD0gx8bauwSPEDfVsG+1FRpCXvs9k/Y=" parent-hash 
                "LkSVCKUK8lHT19PTHzleQzgA7+hrJbuneikfbrwZl/I=" via-port "1-10" 
                with-interface { e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 } 
                with-connect-type "unknown"
        - onlyif: >
            usbguard list-devices | grep -q 'block id 0489:e10d'
        - require:
            - service: usbguard

# vim: syntax=yaml
