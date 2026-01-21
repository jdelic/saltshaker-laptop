# Desktop environment from Debian Netinst minimal installation

base:
    '*':
        - albert
        - ardour
        - basics
        - cameractrls
        - crush
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
        - vscode
        - yubikey
        #- zoom

    'id:parasite':
        - match: grain
        - airtame
        - basics.intel-firmware
        - printing.hp

    'id:hades':
        - match: grain
        - basics.amd-firmware
        - cuda  # includes NVIDIA drivers
        #- steam
        - printing.hp
        - vuescan
