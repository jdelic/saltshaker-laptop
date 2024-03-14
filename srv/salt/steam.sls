steam:
    file.managed:
        - name: /var/cache/salt/steam/steam.deb
        - source: 'https://cdn.cloudflare.steamstatic.com/client/installer/steam.deb'
        - skip_verify: True
        - makedirs: True
        - user: root
        - group: root
        - mode: '0600'
    pkg.installed:
        - sources:
            - steam: /var/cache/salt/steam/steam.deb
        - require:
            - pkg: desktop-packages
            - file: steam
