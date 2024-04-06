# Desktop environment from Debian Netinst minimal installation

base:
    '*':
        - albert
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
        - xerox

    'id:hades':
        - match: grain
        - basics.amd-firmware
        - nvidia
        - cameractrls
        - cuda
        - steam
