# Desktop environment from Debian Netinst minimal installation

base:
    '*':
        - albert
        - ardour
        - basics
        - dev
        - discord
        - enpass
        - firefox
        - gimp
        - inkscape
        - intellij
        - obs
        - salt-minion
        - slack
        - spotify
        - starship
        - thunderbird
        - yubikey
        - zoom

    'id:parasite':
        - match: grain
        - airtame
        - basics.intel-firmware
        - printing.hp
        - printing.xerox

    'id:hades':
        - match: grain
        - basics.amd-firmware
        - cameractrls
        - cuda  # includes NVIDIA drivers
        - steam
        - printing.hp
