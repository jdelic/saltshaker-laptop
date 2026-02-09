# Desktop environment from Debian Netinst minimal installation

base:
    '*':
        - albert
        - ardour
        - basics
        - bitwarden
        - cameractrls
        - crush
        - dev
        - discord
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
        - vuescan
