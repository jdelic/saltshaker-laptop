libvirt-packages:
    pkg.installed:
        - pkgs:
            - libvirt-daemon
            - libvirt-daemon-system
            - qemu-kvm
            - qemu-system-x86
            - qemu-utils
            - virt-install
        - require:
            - pkg: basesystem-packages
