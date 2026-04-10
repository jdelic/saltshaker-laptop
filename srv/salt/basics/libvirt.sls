libvirt-packages:
    pkg.installed:
        - pkgs:
            - dnsmasq-base  # required by libvirtd
            - libvirt-daemon
            - libvirt-daemon-system
            - qemu-kvm
            - qemu-system-x86
            - qemu-utils
            - virt-install
        - require:
            - pkg: basesystem-packages
