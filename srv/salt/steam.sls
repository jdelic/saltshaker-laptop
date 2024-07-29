steam:
    file.managed:
        - name: /var/cache/salt/steam/steam-launcher.deb
        - source: 'https://cdn.cloudflare.steamstatic.com/client/installer/steam.deb'
        - skip_verify: True
        - replace: False
        - makedirs: True
        - user: root
        - group: root
        - mode: '0644'
        - dir_mode: '0755'
    pkg.installed:
        - sources:
            - steam-launcher: /var/cache/salt/steam/steam-launcher.deb
        - onchanges:
            - file: steam
        - require:
            - pkg: desktop-packages
            - file: steam
