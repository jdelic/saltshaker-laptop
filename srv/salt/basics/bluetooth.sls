bluetooth-a2dp:
    file.managed:
        - name: /etc/systemd/system/bluetooth.service.d/override.conf
        - source: salt://basics/bluetooth.override.conf
        - makedirs: True
        - user: root
        - group: root
        - mode: '0644'
        - require:
            - pkg: desktop-packages
    service.running:
        - name: bluetooth
        - watch:
            - file: bluetooth-a2dp


# vim: syntax=yaml
