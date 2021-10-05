microsoft-teams:
    file.managed:
        - name: /var/cache/microsoft_teams.deb
        - source: https://teams.microsoft.com/downloads/desktopurl?env=production&plat=linux&arch=x64&download=true&linuxArchiveType=deb
        - skip_verify: True  # :-( Microsoft doesn't publish SHA hashes
    pkg.installed:
        - sources:
            - teams: /var/cache/microsoft_teams.deb
        - onchanges:
            - file: microsoft-teams
        - require:
            - file: microsoft-teams
            - pkg: desktop-packages
