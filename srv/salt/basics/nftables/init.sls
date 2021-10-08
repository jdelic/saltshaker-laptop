nftables-config:
    file.managed:
        - name: /etc/nftables.conf
        - source: salt://nftables/nftables.conf
        - user: root
        - group: root
        - mode: '0755'
        - require:
            - pkg: basesystem-packages


/etc/nftables.d:
    file.directory:
        - makedirs: True
        - user: root
        - group: root
        - mode: '0755'


nftables-service:
    service.running:
        - name: nftables
        - enable: True
        - require:
            - file: nftables-config
