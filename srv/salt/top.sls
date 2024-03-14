# Laptop desktop environment from Debian Netinst minimal installation

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
        - xerox

    'id:hades':
        - match: grain
        - nvidia
        - cameractrls
        - steam
