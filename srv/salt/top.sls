# Desktop environment from Debian Netinst minimal installation

base:
    'not G@id:rampart':
        - match: compound
        - albert
        - anytype
        - ardour
        - basics
        - bitwarden
        - cameractrls
        - crush
        - dev
        - discord
        - element
        - firefox
        - gimp
        - handy
        - inkscape
        - intellij
        - obs
        - salt-minion
        - signal
        - slack
        - spotify
        - starship
        - thunderbird
        - vscode
        - yubikey
        #- zoom

    'id:parasite':
        - match: grain
        #- airtame
        - basics.intel-firmware
        - drivers.printing.hp

    'id:hades':
        - match: grain
        - basics.amd-firmware
        - drivers.cuda  # includes NVIDIA drivers
        #- steam
        - drivers.printing.hp
        - drivers.reiner_cyberjack
        - special.usbguard-wcn785x
        - vuescan

    'id:rampart':
        - match: grain
        - basics.base
        - basics.crypto
        - basics.etc_mods.inputrc
        - basics.firewalld
        - basics.grub
        - basics.intel-firmware
        - basics.libvirt
        - basics.noexim
        - basics.nounup
        - basics.repos
        - basics.udev
        - basics.vim
        - headless
        - salt-minion
        - starship.install
