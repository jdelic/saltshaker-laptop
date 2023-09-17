firewalld-config-placeholder:
    file.managed:
        - name: /etc/firewalld/00-ignore
        - contents: |
              # nothing to see here, this is just for salt


firewalld:
    service.running:
        - sig: /usr/sbin/python3 /usr/sbin/firewalld
        - watch:
              - file: /etc/firewalld*
        - require:
              - pkg: basesystem-packages


firewalld-public-zone:
    firewalld.present:
        - name: public
        - interfaces:
            {{ pillar['public-interfaces'] }}
