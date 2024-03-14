steam:
    file.managed:
        - name: /var/cache/salt/steam/steam-launcher.deb
        - source: 'https://cdn.cloudflare.steamstatic.com/client/installer/steam.deb'
        - skip_verify: True
        - makedirs: True
        - user: root
        - group: root
        - mode: '0600'
    pkg.installed:
        - sources:
            - steam-launcher: /var/cache/salt/steam/steam-launcher.deb
        - require:
            - pkg: desktop-packages
            - file: steam
